//
//  APTProductsListInteractorInput.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APTProductsListSortModel.h"

@class APTCategoryPlainObject;
@class APTBrandPlainObject;
@class APTProductPlainObject;
@class APTFilterPlainObject;

@protocol APTProductsListInteractorInput <NSObject>

@required

- (void) configureProductsListForCategory:(APTCategoryPlainObject *)category brand:(APTBrandPlainObject *)brand;
- (void) configureProductsListForProductAnalogs:(APTProductPlainObject *)product;
- (void) configureWithSearchProductsArray:(NSArray *)productIds titleTerm:(NSString *)term;

- (void) receiveProductsList;

- (void) updateFilters:(NSArray <APTFilterPlainObject *> *)filters;
- (void) addProductToFavorite:(APTProductPlainObject *)product;
- (void) sortProducts:(APTProductsListSortType)sortOrderType;
- (void) changeCartStateForProduct:(APTProductPlainObject *)product;

- (NSArray <APTProductPlainObject *> *) obtainProducts;
- (NSString *) obtainCurrentCategoryId;
- (NSString *) obtainCurrentBrandId;

- (NSArray <APTFilterPlainObject *> *) obtainFilters;
- (NSInteger) obtainAppliedFiltersCount;

- (APTProductsListSortModel *) obtainCurrentSortModel;
- (NSString *) obtainModuleTitle;

- (void) checkProductOrKit:(APTProductPlainObject *)product;
- (void) checkIfAfterRegionError;
@end
