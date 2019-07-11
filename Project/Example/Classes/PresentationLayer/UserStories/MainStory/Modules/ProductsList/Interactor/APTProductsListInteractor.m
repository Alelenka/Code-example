//
//  APTProductsListInteractor.m
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//
#import <UIKit/UIKit.h>
#import <libextobjc/EXTScope.h>

#import "APTProductsListInteractor.h"
#import "APTProductsListInteractorOutput.h"

#import "APTProductService.h"
#import "APTFavoriteService.h"
#import "APTUserService.h"
#import "APTCartService.h"

#import "APTPonsomizer.h"

#import "APTProductModelObject.h"
#import "APTProductPlainObject.h"
#import "APTProductNodeModelObject.h"

#import "APTCategoryModelObject.h"
#import "APTCategoryPlainObject.h"

#import "APTBrandPlainObject.h"
#import "APTProfileModelObject.h"
#import "APTFilterPlainObject.h"
#import "APTFilterValuePlainObject.h"

#import "APTProductsListSortModel.h"

#import "APTUIStringList.h"

NS_ASSUME_NONNULL_BEGIN

static NSInteger const kAPTProductsListInteractorLimitOffset = 50;

@interface APTProductsListInteractor ()
@property (nonatomic, strong) NSString *moduleTitle;
@property (nonatomic, strong) NSArray *products;

@property (nonatomic, strong) APTProductsListSortModel *sortModel;
@property (nonatomic, strong) NSArray <APTFilterPlainObject *> *filtersArray;

@end

@implementation APTProductsListInteractor

- (instancetype)init {
	self = [super init];
	if (self) {
		_products = @[];
		_sortModel = [[APTProductsListSortModel alloc] initWithSortType:APTProductsListSortTypePopularity];
	}
	return self;
}

#pragma mark - Методы <APTProductsListInteractorInput>

- (NSArray <APTProductPlainObject *> *) obtainProducts {
	NSArray *favotitesIds = [self.favoriteService obtainFavoritesIds];
	
	for (APTProductPlainObject *product in self.products) {
		BOOL fav = [favotitesIds containsObject:product.id];
		product.favorite = [NSNumber numberWithBool:fav];
		product.quantityInBasket = [self.cartService quantityInCartForProductWithId:product.id];
	}

	return self.products;
}

- (void) configureProductsListForCategory:(APTCategoryPlainObject *)category brand:(APTBrandPlainObject *)brand {
	if (brand) {
		self.moduleTitle = brand.originalName;
	} else {
		self.moduleTitle = category.name;
	}
	self.currentCategoryId = category.id;
	self.currentBrandId = brand.id;
}

- (void) configureProductsListForProductAnalogs:(APTProductPlainObject *)product {
	self.moduleTitle = APTUIStringList.productDetailAnalogsTitle;
	self.analogParentProduct = product;
}

- (void) configureWithSearchProductsArray:(NSArray *)productIds titleTerm:(NSString *)term {
	self.barcodeSearchProductArray = productIds;
	self.moduleTitle = term;
}

- (void) receiveProductsList {
	if (self.endReached) {
		return;
	}
	if (!self.endedLoading){
		return;
	}
	
	self.endedLoading = NO;
	
	NSInteger offset = (NSInteger)[self.products count];
	NSInteger limit = kAPTProductsListInteractorLimitOffset;
	
	[self.output loadingDidStart];
	@weakify(self);
	
	if (self.analogParentProduct) {
		[self.productService updateAnalogsForProduct:self.analogParentProduct
																					 limit:50
																					offset:0
																 completionBlock:^(NSArray *data, NSError *error) {
																	 @strongify(self);
																	 self.endedLoading = YES;
																	 if (!error){
																		 [self _updateProducts:data];
																	 } else {
																		 if (error.code == APTMethodErrorCodeRegionNotFound) {
																			 self.regionProblemOccured = YES;
																			 [self.output regionProblemError];
																		 } else {
																			 [self.output confirmationError:error.localizedDescription];
																		 }
																	 }
																	 [self.output loadingDidEnd];
																 }];
	} else if (self.barcodeSearchProductArray.count > 0) {
		[self.productService updateConcreteProductsWithIds:self.barcodeSearchProductArray
																			 completionBlock:^(NSArray *data, NSError *error) {
																				 @strongify(self);
																				 self.endedLoading = YES;
																				 self.endReached = YES;
																				 if (!error){
																					 [self _updateProducts:data];
																				 } else {
																					 if (error.code == APTMethodErrorCodeRegionNotFound) {
																						 self.regionProblemOccured = YES;
																						 [self.output regionProblemError];
																					 } else {
																						 [self.output confirmationError:error.localizedDescription];
																					 }

																				 }
																				 [self.output loadingDidEnd];
																			 }];
		
	} else {
		NSMutableDictionary *filter = @{@"onlyAvailable" : @YES}.mutableCopy;
		if (self.filtersArray.count > 0) {
			[filter setObject:[self _filterStates] forKey:@"state"];
		}
		[self.productService updateProductListWithSortOrder:self.sort.sortOrderKey
																							 category:self.currentCategoryId
																								brandId:self.currentBrandId
																								 filter:[filter copy]
																									limit:limit
																								 offset:offset
																				completionBlock:^(NSArray *data, NSError *error) {
																					@strongify(self);
																					self.endedLoading = YES;
																					if (error){
																						if (error.code == APTMethodErrorCodeRegionNotFound) {
																							self.regionProblemOccured = YES;
																							[self.output regionProblemError];
																						} else {
																							[self.output confirmationError:error.localizedDescription];
																						}

																					} else {
																						[self _updateProducts:data];
																					}
																				
																					[self.output loadingDidEnd];
																				}];
	}
}

- (void) updateFilters:(NSArray <APTFilterPlainObject *> *)filters {
	self.filtersArray = filters;
	self.products = @[];
	self.endedLoading = YES;
	self.endReached = NO;
	[self receiveProductsList];
}

- (void) sortProducts:(APTProductsListSortType)sortOrderType {
	if (self.sort.sortType != sortOrderType ) {
		self.sort.sortType = sortOrderType;
		self.products = @[];
		self.endedLoading = YES;
		self.endReached = NO;
		[self receiveProductsList];
	}
}

- (void) addProductToFavorite:(APTProductPlainObject *)product {
	if (![self.userService isUserAuthorized]) {
		[self.output errorUserUnauthorizedForFavorites];
		[self.output productsReceived];
		return;
	}
	[self.output loadingDidStart];
	@weakify(self);
	[self.favoriteService changeProductFavoriteStatus:product
																		completionBlock:^(NSError *error) {
																			@strongify(self);
																			if (error) {
																				[self.output confirmationError:error.localizedDescription];
																				if (error.code == APTMethodErrorCodeUserNotAuthorized) {
																					[self.userService logoutAfterServerError];
																				}
																			} else {
																				BOOL wasIsFav = product.favorite.boolValue;
																				product.favorite = [NSNumber numberWithBool:!wasIsFav];
																			}
																			[self.output productsReceived];
																			[self.output loadingDidEnd];
																		}];
}

- (void) changeCartStateForProduct:(APTProductPlainObject *)product {
	[self.output loadingDidStart];
	@weakify(self);
	
	if (product.quantityInBasket == 0) {
		[self.cartService addOneProductToCart:product completionBlock:^(NSError * _Nullable error) {
			@strongify(self);
			[self.output loadingDidEnd];
			
			if (error){
				[self.output confirmationError:error.localizedDescription];
			} else {
				product.quantityInBasket = [self.cartService quantityInCartForProductWithId:product.id];
				[self.output productsReceived];
			}
			
		}];
	} else {
		[self.cartService removeCompletelyProductFromCart:product completionBlock:^(NSError * _Nullable error) {
			@strongify(self);
			[self.output loadingDidEnd];
		
			if (error){
				[self.output confirmationError:error.localizedDescription];
			} else {
				product.quantityInBasket = [self.cartService quantityInCartForProductWithId:product.id];
				[self.output productsReceived];
			}
		}];
	}
}

- (NSString *) obtainModuleTitle {
	return self.moduleTitle;
}

- (NSString *) obtainCurrentCategoryId {
	return self.currentCategoryId;
}

- (NSString *) obtainCurrentBrandId {
	return self.currentBrandId;
}

- (NSArray <APTFilterPlainObject *> *) obtainFilters {
	return self.filtersArray;
}

- (APTProductsListSortModel *) obtainCurrentSortModel {
	return self.sort;
}

- (NSInteger) obtainAppliedFiltersCount {
	NSInteger count = 0;
	for (APTFilterPlainObject *filter in self.filtersArray) {
		
		if (filter.statisticType == APTFilterStatisticTypeInterval && filter.intervalSelected) {
			count++;
			
		} else if (filter.statisticType == APTFilterStatisticTypeEnum && filter.selectedEnumValues.count > 0) {
			count = count + (NSInteger)filter.selectedEnumValues.count;
		}
	}
	return count;
}

- (void) checkProductOrKit:(APTProductPlainObject *)product {
	if (product.set) {
		[self.output openKitModule:product];
	} else {
		[self.output openProductModule:product];
	}
}

#pragma mark - Private
- (void) _updateProducts:(NSArray *)data {
	if (data.count == 0 || data.count < kAPTProductsListInteractorLimitOffset){
		self.endReached = YES;
	}
	
	NSMutableArray *allProduct = [NSMutableArray arrayWithArray:self.products];
	[allProduct addObjectsFromArray:data];
	self.products = [allProduct copy];
	
	[self.output productsReceived];
}

- (NSDictionary *) _filterStates {
	NSMutableDictionary *filterState = @{}.mutableCopy;
	
	for (APTFilterPlainObject *filter in self.filtersArray) {
		NSMutableArray *codes = @[].mutableCopy;
		
		if (filter.statisticType == APTFilterStatisticTypeInterval && filter.intervalSelected) {
			[codes addObject:@(filter.minSelectedIntervalValue)];
			[codes addObject:@(filter.maxSelectedIntervalValue)];
			
		} else if (filter.statisticType == APTFilterStatisticTypeEnum && filter.selectedEnumValues.count > 0) {
			for (APTFilterValuePlainObject *value in filter.selectedEnumValues) {
				[codes addObject:value.code];
			}
		}
		
		if (codes.count > 0) {
			[filterState setValue:[codes copy] forKey:filter.code];
		}
	}
	
	return [filterState copy];
}

@end

NS_ASSUME_NONNULL_END
