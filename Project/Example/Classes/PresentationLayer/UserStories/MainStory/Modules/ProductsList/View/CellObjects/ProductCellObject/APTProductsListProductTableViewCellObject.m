//
//  APTProductsListProductTableViewCellObject.m
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTProductsListProductTableViewCellObject.h"

@implementation APTProductsListProductTableViewCellObject

- (instancetype) initWithProduct:(APTProductPlainObject *)product  delegate:(id <APTProductsListProductTableViewCellObjectDelegate>) delegate{
	self = [super init];
	if (self) {
		_product = product;
		_delegate = delegate;
	}
	return self;
}

+ (instancetype) objectWithProduct:(APTProductPlainObject *)product delegate:(id <APTProductsListProductTableViewCellObjectDelegate>) delegate{
	return [[[self class] alloc] initWithProduct:product delegate:delegate] ;
}

#pragma mark - NICellObject

- (Class)cellClass {
	return [APTProductsListProductTableViewCell class];
}

#pragma mark - NINibCellObject

- (UINib *)cellNib {
	return [UINib nibWithNibName:NSStringFromClass([APTProductsListProductTableViewCell class]) bundle:[NSBundle mainBundle]];
}

#pragma mark - <APTProductsListProductTableViewCellDelegate>

- (void) didTapAddProductToCart {
	[self.delegate didTapAddProductToCart:self.product];
}

@end
