//
//  APTProductsListModuleInput.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

@class APTCategoryPlainObject;
@class APTBrandPlainObject;
@class APTProductPlainObject;

NS_ASSUME_NONNULL_BEGIN

@protocol APTProductsListModuleInput <RamblerViperModuleInput>

@required

- (void) configureModuleWithCategory:(nullable APTCategoryPlainObject *)category brand:(nullable APTBrandPlainObject *)brand;
- (void) configureModuleForAnalogsForProduct:(APTProductPlainObject *)product;
- (void) configureModuleWithProductIds:(NSArray *)productsIds searchTerm:(NSString *)term;
@end

NS_ASSUME_NONNULL_END
