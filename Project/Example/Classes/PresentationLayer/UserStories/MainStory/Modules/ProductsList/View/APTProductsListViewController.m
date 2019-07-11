//
//  APTProductsListViewController.m
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import <libextobjc/EXTScope.h>

#import "APTProductsListViewController.h"
#import "APTProductsListViewOutput.h"

#import "APTProductsListDataDisplayManager.h"
#import "APTListTableViewAnimator.h"

#import "APTProductsListProductTableViewCell.h"
#import "APTBadgeButton.h"

#import "APTProductsListSortModel.h"

#import "APTUIStringList.h"

#import "NSString+APTFormatting.h"

@interface APTProductsListViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *sortButton;
@property (nonatomic, weak) IBOutlet APTBadgeButton *filterButton;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *filterHeight;

@property (nonatomic) APTProductsListSortType currentSortType;

@end

@implementation APTProductsListViewController

#pragma mark - LifeCycle

- (void) viewDidLoad {
	[super viewDidLoad];
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	[self.output didLoadView];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.output didDisplayView];
  APTTrackEvent(APTAnalyticEventProductListShow);
}

#pragma mark - Методы <APTProductsListViewInput>

- (void) setupInitialStateWithTitle:(NSString *)title hideFilters:(BOOL)hideFilters {
	self.filterHeight.constant = hideFilters ? 0.0f : 46.0f;
	self.title = title;
	[self prepareUI];
	
	self.tableViewAnimator.tableView = self.tableView;
	
	self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
	self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView
																												 withBaseDelegate:self.dataDisplayManager];
}

- (void) updateWithSortModel:(APTProductsListSortModel *)sortModel {
	self.currentSortType = sortModel.sortType;
}

- (void) updateWithProducts:(NSArray *)products {
	[self.dataDisplayManager updateWithProducts:products];
}

- (void) updateFiltersWithCount:(NSInteger)appliedFilterCount {
	[self.filterButton setBadgeString: appliedFilterCount > 0 ? [NSString stringWithFormat:@"%ld", (long)appliedFilterCount] : @""];
}

- (void) showSortMenu {
	UIAlertController *customActionSheet = [UIAlertController alertControllerWithTitle:APTUIStringList.sortText
																																						 message:nil
																																			preferredStyle:UIAlertControllerStyleActionSheet];
	
	for (NSUInteger ii = 0; ii < APTProductsListSortModel.sortList.count; ii++) {
		NSNumber *item = APTProductsListSortModel.sortList[ii];
		APTProductsListSortType actionSortType = item.unsignedIntegerValue;
		@weakify(self);
		UIAlertAction *alertAction = [UIAlertAction actionWithTitle:[APTProductsListSortModel stringSortType:actionSortType]
																													style:UIAlertActionStyleDefault
																												handler:^(UIAlertAction * action) {
																													@strongify(self)
																													[self.output selectSortType:actionSortType];
																												}];
		
		if (self.currentSortType == actionSortType) {
			[alertAction setValue:@YES forKey:@"checked"];
		}
		[customActionSheet addAction:alertAction];
	}
	
	UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:APTUIStringList.cancelEnglishText style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
	[customActionSheet addAction:cancelButton];
	
	UIPopoverPresentationController *popPresenter = [customActionSheet popoverPresentationController];
	popPresenter.sourceView = self.sortButton;
	popPresenter.sourceRect = self.sortButton.bounds;
	
	[self presentViewController:customActionSheet animated:YES completion:nil];
}

- (void) showAlertErrorUserUnauthorizedForFavorites {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:APTUIStringList.alertErrorUserUnauthorizedForFavorites preferredStyle:UIAlertControllerStyleAlert];
	@weakify(self);
	UIAlertAction *okAlert = [UIAlertAction actionWithTitle:APTUIStringList.okButtonText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		@strongify(self);
		[self.output showAuthorizationScreen];
	}];
	[alert addAction:okAlert];
	UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:APTUIStringList.cancelRussianText style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
	[alert addAction:cancelButton];
	[self presentViewController:alert animated:YES completion:nil];
}

- (void) presentError:(NSString *)message {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:APTUIStringList.errorTitleText message:message preferredStyle:UIAlertControllerStyleAlert];
	[alert addAction:[UIAlertAction actionWithTitle:APTUIStringList.okButtonText
																						style:UIAlertActionStyleDefault
																					handler:^(UIAlertAction * _Nonnull action) {
																						
																					}]];
	[self presentViewController:alert animated:YES completion:nil];
}

- (void) showActivity {
	[self showActivityHUD];
}

- (void) hideActivity {
	[self hideActivityHUD];
}

#pragma mark - Actions

- (IBAction) sortButtonTapped:(id)sender {
	[self.output showSort];
}

- (IBAction) filterButtonTapped:(id)sender {
	[self.output showFilter];
}

#pragma mark - APTProductsListDataDisplayManagerProtocol
- (void) didTapCellWithProduct:(APTProductPlainObject *)product {
	[self.output showProductDetails:product];
}

- (void) addProductToFavorite:(APTProductPlainObject *)product {
	[self.output addProductToFavorite:product];
}

- (void) endOfTableReached {
	[self.output requestMoreProduct];
}

- (void) cellDidTapAddProductToCart:(APTProductPlainObject *)product {
	[self.output needToChangeCartStateForProduct:product];
}


#pragma mark - Private

- (void) prepareUI {
	self.tableView.tableFooterView = [UIView new];
	[self.sortButton setTitle:APTUIStringList.sortText forState:UIControlStateNormal];
	[self.filterButton setTitle:APTUIStringList.filtersText forState:UIControlStateNormal];
}

@end
