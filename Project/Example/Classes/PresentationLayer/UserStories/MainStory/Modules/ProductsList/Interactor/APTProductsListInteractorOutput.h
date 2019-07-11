//
//  APTProductsListInteractorOutput.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class APTProductPlainObject;

@protocol APTProductsListInteractorOutput <NSObject>

@required
- (void) productsReceived;
- (void) confirmationError:(NSString *)message;
- (void) errorUserUnauthorizedForFavorites;

- (void) openProductModule:(APTProductPlainObject *)product;
- (void) openKitModule:(APTProductPlainObject *)product;

- (void) loadingDidStart;
- (void) loadingDidEnd;

- (void) displayProductAlreadyInCart:(APTProductPlainObject *)product newProduct:(APTProductPlainObject *)desiredProduct;

- (void) regionProblemError;

@end

NS_ASSUME_NONNULL_END

