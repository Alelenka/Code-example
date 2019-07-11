//
//  APTProductsListCellObjectBuilder.m
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTProductsListCellObjectBuilder.h"

#import "APTProductsListProductTableViewCellObject.h"

@interface APTProductsListCellObjectBuilder ()
@property (nonatomic, weak) id delegate;
@end

@implementation APTProductsListCellObjectBuilder

- (instancetype) initWithDelegate:(id)cellsDelegate {
    self = [super init];
    if (self) {
        _delegate = cellsDelegate;
    }
    return self;
}

- (NSArray *) buildObjectsWithProducts:(NSArray <APTProductPlainObject *> *)products {
	NSMutableArray *cellObjects = [NSMutableArray arrayWithCapacity:products.count];
	for (APTProductPlainObject *product in products){
		[cellObjects addObject:[self buildObjectWithProduct:product]];
	}
	
	return [cellObjects copy];
}

#pragma mark - cellObject
- (APTProductsListProductTableViewCellObject *) buildObjectWithProduct:(APTProductPlainObject *)product {
	return [APTProductsListProductTableViewCellObject objectWithProduct:product delegate:self.delegate];
}

@end
