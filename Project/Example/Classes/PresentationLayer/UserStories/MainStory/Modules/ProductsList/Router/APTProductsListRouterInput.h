//
//  APTProductsListRouterInput.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class APTProductPlainObject;

NS_ASSUME_NONNULL_BEGIN

@protocol APTProductsListRouterInput <NSObject>

@required
- (void) showFiltersForCategory:(NSString *)categoryId andBrand:(NSString *)brandId withFilters:(NSArray *)filters moduleOutput:(id)moduleOutput;
- (void) showProductDetails:(APTProductPlainObject *)product;
- (void) showProductKitDetails:(APTProductPlainObject *)product;
- (void) showAuthorization;

- (void) showAlreadyInCartModuleWithCartItem:(APTProductPlainObject *)cartItem desiredProduct:(APTProductPlainObject *)desiredProduct moduleOutput:(id)moduleOutput;

- (void) goToRegionSelection;
@end

NS_ASSUME_NONNULL_END
