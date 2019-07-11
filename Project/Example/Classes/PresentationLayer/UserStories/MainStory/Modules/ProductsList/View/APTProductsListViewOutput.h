//
//  APTProductsListViewOutput.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APTProductsListSortModel.h"

NS_ASSUME_NONNULL_BEGIN

@class APTProductPlainObject;

@protocol APTProductsListViewOutput <NSObject>

@required

- (void) didLoadView;
- (void) didDisplayView;
- (void) showProductDetails:(APTProductPlainObject *)product;
- (void) showFilter;
- (void) showSort;
- (void) selectSortType:(APTProductsListSortType)type;
- (void) addProductToFavorite:(APTProductPlainObject *)product;
- (void) needToChangeCartStateForProduct:(APTProductPlainObject *)product;
- (void) showAuthorizationScreen;

- (void) requestMoreProduct;

@end

NS_ASSUME_NONNULL_END
