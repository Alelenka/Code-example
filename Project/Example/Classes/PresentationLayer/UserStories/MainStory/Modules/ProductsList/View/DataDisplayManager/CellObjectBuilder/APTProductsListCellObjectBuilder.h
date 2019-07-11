//
//  APTProductsListCellObjectBuilder.h
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class APTProductsListProductTableViewCellObject;
@class APTProductPlainObject;

@interface APTProductsListCellObjectBuilder : NSObject
- (instancetype) initWithDelegate:(id)cellsDelegate;

- (NSArray *) buildObjectsWithProducts:(NSArray <APTProductPlainObject *> *)products;
- (APTProductsListProductTableViewCellObject *) buildObjectWithProduct:(APTProductPlainObject *)product;
@end
