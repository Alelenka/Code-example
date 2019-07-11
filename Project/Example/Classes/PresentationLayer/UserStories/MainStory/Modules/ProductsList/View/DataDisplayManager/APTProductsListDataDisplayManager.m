//
//  APTProductsListDataDisplayManager.m
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <Nimbus/NimbusModels.h>

#import "APTProductsListDataDisplayManager.h"

#import "APTEditableCellFactory.h"
#import "APTTableViewAction.h"

#import "APTProductsListCellObjectBuilder.h"
#import "APTListTableViewAnimator.h"

#import "APTProductPlainObject.h"

#import "APTUIStringList.h"
#import "APTColorPalette.h"

@interface APTProductsListDataDisplayManager ()
@property (nonatomic, strong) NIMutableTableViewModel *tableViewModel;
@property (nonatomic, strong) NITableViewActions *tableViewActions;
@end

@implementation APTProductsListDataDisplayManager {
	NSMutableDictionary *cellHeightsDictionary;
}

- (void) updateWithProducts:(NSArray *)products {
	[self.tableViewModel removeSectionAtIndex:0];
	[self.tableViewModel addSectionWithTitle:@""];
	[self.tableViewModel addObjectsFromArray:[self.cellObjectBuilder buildObjectsWithProducts:products]];
	
	[self.animator reloadData];
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSNumber *height = [cellHeightsDictionary objectForKey:indexPath];
	if (height != nil) return height.floatValue;
	return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat height = [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
	return height;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	CGFloat distanceFromBottom = scrollView.contentSize.height - scrollView.contentOffset.y;
	if (distanceFromBottom < scrollView.frame.size.height) {
		[self.delegate endOfTableReached];
	}
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section >= tableView.numberOfSections || indexPath.row >= [tableView numberOfRowsInSection:indexPath.section]) {
		return nil;
	}
	
	APTProductsListProductTableViewCellObject *object = [self.tableViewModel objectAtIndexPath:indexPath];
	APTProductPlainObject *product = object.product;
	
	NSString *favTitle = product.favorite.boolValue ? APTUIStringList.favoritesRemoveFromButtonText : APTUIStringList.favoritesAddToButtonText;
	@weakify(self);
	UITableViewRowAction *addToFavoriteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
																																								 title: favTitle
																																						 handler:^(UITableViewRowAction *action, NSIndexPath *indexPathAction){
																																							 @strongify(self);
																																							 [self.delegate addProductToFavorite:product];
																																						 }];
	addToFavoriteAction.backgroundColor = APTColorPalette.applicationSelectedColor;
	
	return @[addToFavoriteAction];
}

#pragma mark - DataDisplayManager

- (id<UITableViewDataSource>) dataSourceForTableView:(UITableView *)tableView {
	[self _updateTableViewModel];
	return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
	if (!self.tableViewActions) {
		[self _setupTableViewActions];
	}
	return [self.tableViewActions forwardingTo:baseTableViewDelegate];
}

#pragma mark - <APTProductsListProductTableViewCellObjectDelegate>

- (void) didTapAddProductToCart:(APTProductPlainObject *)product {
	[self.delegate cellDidTapAddProductToCart:product];
}

#pragma mark - Private

- (void) _setupTableViewActions {
	self.tableViewActions = [[APTTableViewAction alloc] initWithTarget:self];
	self.tableViewActions.tableViewCellSelectionStyle = UITableViewCellSelectionStyleDefault;
	
	@weakify(self);
	[self.tableViewActions attachToClass:[APTProductsListProductTableViewCellObject class]
															tapBlock:^BOOL(APTProductsListProductTableViewCellObject *object, id target, NSIndexPath *indexPath) {
																@strongify(self);
																[self.delegate didTapCellWithProduct:object.product];
																return YES;
															}];
}

- (void) _updateTableViewModel {
	if (!self.tableViewModel) {
		self.tableViewModel = [[NIMutableTableViewModel alloc] initWithSectionedArray:@[@""]
																																				 delegate:(id)[APTEditableCellFactory class]];
	}
}

@end
