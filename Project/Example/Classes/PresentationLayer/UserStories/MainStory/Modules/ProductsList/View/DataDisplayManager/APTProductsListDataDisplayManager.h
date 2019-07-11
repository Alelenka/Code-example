//
//  APTProductsListDataDisplayManager.h
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APTDataDisplayManager.h"
#import "APTProductsListProductTableViewCellObject.h"

@class APTProductsListCellObjectBuilder;
@class APTListTableViewAnimator;
@class APTProductPlainObject;

@protocol APTProductsListDataDisplayManagerProtocol <NSObject>
- (void) didTapCellWithProduct:(APTProductPlainObject *)product;
- (void) endOfTableReached;
- (void) addProductToFavorite:(APTProductPlainObject *)product;
- (void) cellDidTapAddProductToCart:(APTProductPlainObject *)product;
@end

@interface APTProductsListDataDisplayManager : NSObject <APTDataDisplayManager, UITableViewDelegate, APTProductsListProductTableViewCellObjectDelegate>

@property (nonatomic, weak) id <APTProductsListDataDisplayManagerProtocol> delegate;
@property (nonatomic, strong) APTProductsListCellObjectBuilder *cellObjectBuilder;
@property (nonatomic, weak) APTListTableViewAnimator *animator;

- (void) updateWithProducts:(NSArray *)products;

@end
