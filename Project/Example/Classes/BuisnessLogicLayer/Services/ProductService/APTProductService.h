//
//  APTProductService.h
//  Example
//
//  Created by Alenka on 11/07/2019.
//  Copyright © 2019 Alenka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^APTProductServiceCompletionBlock)(NSError *error);
typedef void(^APTProductServiceDataCompletionBlock)(id data, NSError *error);

@class APTProductPlainObject;
@class APTProductModelObject;

@class APTCategoryModelObject;
@class APTCategoryPlainObject;

@protocol APTProductService <NSObject>
- (void) getCategoriesTreeWithCompletionBlock:(APTProductServiceCompletionBlock)completion;

- (void) updateProductListWithSortOrder:(NSString *)order
															 category:(NSString *)categoryId
																brandId:(NSString *)brandId
																 filter:(NSDictionary *)filter
																	limit:(NSInteger)limit
																 offset:(NSInteger)offset
												completionBlock:(APTProductServiceDataCompletionBlock)completion;

- (void) updateProductInfo:(NSString *)productId
					 completionBlock:(APTProductServiceDataCompletionBlock)completion;
//...
- (NSArray <APTCategoryModelObject *> *) obtainCategoriesForMenu;
- (APTProductModelObject *) obtainProductWithId:(NSString *)productId;
- (APTCategoryModelObject *) obtainCategoryWithId:(NSString *)categoryId;

@end

NS_ASSUME_NONNULL_END
