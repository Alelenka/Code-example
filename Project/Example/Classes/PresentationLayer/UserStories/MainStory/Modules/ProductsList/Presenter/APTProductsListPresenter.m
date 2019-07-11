//
//  APTProductsListPresenter.m
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTProductsListPresenter.h"

#import "APTProductsListViewInput.h"
#import "APTProductsListInteractorInput.h"
#import "APTProductsListRouterInput.h"
#import "APTProductsListModuleOutput.h"

#import "APTFilterProductsListModuleOutput.h"
#import "APTProductAlreadyInCartModuleOutput.h"

NS_ASSUME_NONNULL_BEGIN

@interface APTProductsListPresenter () <APTFilterProductsListModuleOutput, APTProductAlreadyInCartModuleOutput>
@property (nonatomic) BOOL hideFilters;
@end

@implementation APTProductsListPresenter

#pragma mark - Методы APTProductsListModuleInput

- (void) configureModuleForAnalogsForProduct:(APTProductPlainObject *)product {
	self.hideFilters = YES;
	[self.interactor configureProductsListForProductAnalogs:product];
}

- (void) configureModuleWithCategory:(nullable APTCategoryPlainObject *)category brand:(nullable APTBrandPlainObject *)brand {
	self.hideFilters = NO;
	[self.interactor configureProductsListForCategory:category brand:brand];
}

- (void) configureModuleWithProductIds:(NSArray *)productsIds searchTerm:(NSString *)term {
	self.hideFilters = YES;
	[self.interactor configureWithSearchProductsArray:productsIds titleTerm:term];
}

#pragma mark - Методы <APTProductsListViewOutput>

- (void) didLoadView {
	[self.view setupInitialStateWithTitle:[self.interactor obtainModuleTitle] hideFilters:self.hideFilters];
	[self.interactor receiveProductsList];
}

- (void) didDisplayView {
	[self.interactor checkIfAfterRegionError];
	[self.view updateWithProducts:[self.interactor obtainProducts]];
}

- (void) showProductDetails:(APTProductPlainObject *)product {
	[self.interactor checkProductOrKit:product];
}

- (void) showFilter {
	[self.router showFiltersForCategory:[self.interactor obtainCurrentCategoryId]
														 andBrand:[self.interactor obtainCurrentBrandId]
													withFilters:[self.interactor obtainFilters]
												 moduleOutput:self];
}

- (void) showSort {
	[self.view showSortMenu];
}

- (void) selectSortType:(APTProductsListSortType)type {
	[self.interactor sortProducts:type];
}

- (void) addProductToFavorite:(APTProductPlainObject *)product {
	[self.interactor addProductToFavorite:product];
}

- (void) needToChangeCartStateForProduct:(APTProductPlainObject *)product {
	[self.interactor changeCartStateForProduct:product];
}

- (void) showAuthorizationScreen {
	[self.router showAuthorization];
}

- (void) requestMoreProduct {
	[self.interactor receiveProductsList];
}

#pragma mark - Методы <APTProductsListInteractorOutput>

- (void) confirmationError:(NSString *)message {
	[self.view presentError:message];
}

- (void) productsReceived {
	[self.view updateWithSortModel:[self.interactor obtainCurrentSortModel]];
	[self.view updateWithProducts:[self.interactor obtainProducts]];
	[self.view updateFiltersWithCount:[self.interactor obtainAppliedFiltersCount]];
}

- (void) errorUserUnauthorizedForFavorites {
	[self.view showAlertErrorUserUnauthorizedForFavorites];
}

- (void) openProductModule:(APTProductPlainObject *)product {
	[self.router showProductDetails:(APTProductPlainObject *)product];
}

- (void) openKitModule:(APTProductPlainObject *)product {
	[self.router showProductKitDetails:(APTProductPlainObject *)product];
}

- (void) loadingDidStart {
	[self.view showActivity];
}

- (void) loadingDidEnd {
	[self.view hideActivity];
}

- (void) displayProductAlreadyInCart:(APTProductPlainObject *)product newProduct:(APTProductPlainObject *)desiredProduct {
	[self.router showAlreadyInCartModuleWithCartItem:product desiredProduct:desiredProduct moduleOutput:self];
}

- (void) regionProblemError {
	[self.router goToRegionSelection];
}

#pragma mark - APTFilterProductsListModuleOutput
- (void) applyFilters:(nullable NSArray <APTFilterPlainObject *> *)filters {
	[self.interactor updateFilters:filters];
}

#pragma mark - APTProductAlreadyInCartModuleOutput

- (void) newProductAddedToCartAfterRemovingSimilarOne {
	[self productsReceived];
}
	
@end

NS_ASSUME_NONNULL_END
