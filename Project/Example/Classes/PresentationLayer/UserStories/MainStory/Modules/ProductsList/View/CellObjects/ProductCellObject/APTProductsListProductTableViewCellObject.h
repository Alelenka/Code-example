//
//  APTProductsListProductTableViewCellObject.h
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NimbusModels.h>

#import "APTProductsListProductTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class APTProductPlainObject;

@protocol APTProductsListProductTableViewCellObjectDelegate <NSObject>
@required
- (void) didTapAddProductToCart:(APTProductPlainObject *)product;
@end

@interface APTProductsListProductTableViewCellObject : NSObject <NICellObject, APTProductsListProductTableViewCellDelegate>

@property (nonatomic, weak) id<APTProductsListProductTableViewCellObjectDelegate> delegate;
@property (nonatomic, strong, readonly) APTProductPlainObject *product;

+ (instancetype) objectWithProduct:(APTProductPlainObject *)product delegate:(id <APTProductsListProductTableViewCellObjectDelegate>) delegate;
@end

NS_ASSUME_NONNULL_END
