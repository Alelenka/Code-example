//
//  APTProductsListPresenter.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTProductsListViewOutput.h"
#import "APTProductsListInteractorOutput.h"
#import "APTProductsListModuleInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol APTProductsListModuleOutput;

@protocol APTProductsListViewInput;
@protocol APTProductsListInteractorInput;
@protocol APTProductsListRouterInput;

@interface APTProductsListPresenter :
NSObject <APTProductsListModuleInput, APTProductsListViewOutput, APTProductsListInteractorOutput>

@property (nonatomic, weak) id<APTProductsListModuleOutput> moduleOutput;

@property (nonatomic, weak) id<APTProductsListViewInput> view;
@property (nonatomic, strong) id<APTProductsListInteractorInput> interactor;
@property (nonatomic, strong) id<APTProductsListRouterInput> router;

@end

NS_ASSUME_NONNULL_END
