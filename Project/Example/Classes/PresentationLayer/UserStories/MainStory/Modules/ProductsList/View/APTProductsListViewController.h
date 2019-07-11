//
//  APTProductsListViewController.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTViewControllerBase.h"
#import "APTProductsListViewInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol APTProductsListViewOutput;

@class APTProductsListDataDisplayManager;
@class APTListTableViewAnimator;

@interface APTProductsListViewController : APTViewControllerBase <APTProductsListViewInput>

@property (nonatomic, strong) id<APTProductsListViewOutput> output;

@property (nonatomic, strong) APTProductsListDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) APTListTableViewAnimator *tableViewAnimator;

@end

NS_ASSUME_NONNULL_END
