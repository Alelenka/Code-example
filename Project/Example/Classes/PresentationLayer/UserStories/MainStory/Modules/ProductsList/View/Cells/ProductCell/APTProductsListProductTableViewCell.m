//
//  APTProductsListProductTableViewCell.m
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//
#import <SDWebImage/SDWebImage.h>

#import "APTProductsListProductTableViewCell.h"
#import "APTProductsListProductTableViewCellObject.h"

#import "APTProductPlainObject.h"

#import "APTUIStringList.h"
#import "NSString+APTFormatting.h"
#import "NSDecimalNumber+APTFormatting.h"
#import "APTUIStringAttributesProvider.h"

@interface APTProductsListProductTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UILabel *productNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *productVendorLabel;
@property (nonatomic, weak) IBOutlet UILabel *productActiveSubstanceLabel;

@property (nonatomic, weak) IBOutlet UILabel *productPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *productOldPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;

@end

@implementation APTProductsListProductTableViewCell

#pragma mark - LifeCycle

- (void) prepareForReuse {
	[super prepareForReuse];
	
	[self.productImageView sd_cancelCurrentImageLoad];
	self.productImageView.image = nil;
	self.productNameLabel.text = nil;
	self.productVendorLabel.text = nil;
	self.productActiveSubstanceLabel.text = nil;

	self.productPriceLabel.text = nil;
	self.productOldPriceLabel.text = nil;
	self.addToCartButton.selected = NO;
}

- (void) didMoveToSuperview {
	[super didMoveToSuperview];
	[self layoutIfNeeded];
}

- (void) layoutSubviews {
	[super layoutSubviews];
}

- (void) setProductInCart:(BOOL)inCart {
	self.addToCartButton.selected = inCart;
}

#pragma mark - Actions

- (IBAction) addToCartAction:(id)sender {
	[self.delegate didTapAddProductToCart];
}

#pragma mark - NICell methods

- (BOOL) shouldUpdateCellWithObject:(APTProductsListProductTableViewCellObject *)object {
	
	self.productOldPriceLabel.text = @"";
	
	NSURL *imgUrl = [NSURL URLWithString:object.product.imageSmall];
	[self.productImageView sd_setImageWithURL:imgUrl];
	
	self.addToCartButton.selected = object.product.quantityInBasket > 0;
	self.addToCartButton.hidden = (object.product.amount == 0 || !object.product.isAvailable);
	
	NSString *name = [object.product.name stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	self.productNameLabel.text = name;
	[self.productNameLabel sizeToFit];
	
	self.productVendorLabel.text = object.product.vendor ? object.product.vendor.capitalizedString : @"";
	self.productActiveSubstanceLabel.text = object.product.substancesString;
	
	[self _configurePrice:object.product];
	self.delegate = object;
	
	return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
	return UITableViewAutomaticDimension;
}

#pragma mark - Private

- (void) _configurePrice:(APTProductPlainObject *)object {
  if (object.amount == 0 || !object.isAvailable) {
    self.productPriceLabel.text = APTUIStringList.outOfStockText;
  } else {
    self.productPriceLabel.text = object.price.apt_stringFormatting;
    if (object.oldPrice && ![object.oldPrice isEqual:object.price]) {
      self.productOldPriceLabel.attributedText = [[NSAttributedString alloc] initWithString:object.oldPrice.apt_stringFormatting
																																								 attributes:APTUIStringAttributesProvider.productsListOldPriceTextAttributes];
    }
  }
}

@end
