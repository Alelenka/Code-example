//
//  APTProductsListInteractor.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTProductsListInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol APTProductsListInteractorOutput;
@protocol APTProductService;
@protocol APTPonsomizer;
@protocol APTFavoriteService;
@protocol APTUserService;
@protocol APTCartService;

@interface APTProductsListInteractor : NSObject <APTProductsListInteractorInput>

@property (nonatomic, weak) id<APTProductsListInteractorOutput> output;
@property (nonatomic, strong) id <APTProductService> productService;
@property (nonatomic, strong) id <APTFavoriteService> favoriteService;
@property (nonatomic, strong) id <APTUserService> userService;
@property (nonatomic, strong) id <APTCartService> cartService;

@property (nonatomic, strong) id <APTPonsomizer> ponsomizer;
@end

NS_ASSUME_NONNULL_END
