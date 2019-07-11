//
//  APTProductsListProductTableViewCell.h
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Nimbus/NICellFactory.h>

NS_ASSUME_NONNULL_BEGIN

@protocol APTProductsListProductTableViewCellDelegate <NSObject>
- (void) didTapAddProductToCart;
@end

@interface APTProductsListProductTableViewCell : UITableViewCell <NICell>

@property (nonatomic, weak) id<APTProductsListProductTableViewCellDelegate> delegate;
- (void) setProductInCart:(BOOL)inCart;
@end

NS_ASSUME_NONNULL_END
