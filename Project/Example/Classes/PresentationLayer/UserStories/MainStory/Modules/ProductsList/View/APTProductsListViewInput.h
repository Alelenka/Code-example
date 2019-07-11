//
//  APTProductsListViewInput.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@class APTProductsListSortModel;

@protocol APTProductsListViewInput <NSObject>

@required

- (void) setupInitialStateWithTitle:(NSString *)title hideFilters:(BOOL)hideFilters;

- (void) updateWithProducts:(NSArray *)products;
- (void) updateWithSortModel:(APTProductsListSortModel *)sortModel;
- (void) updateFiltersWithCount:(NSInteger)appliedFilterCount;
- (void) showSortMenu;
- (void) showAlertErrorUserUnauthorizedForFavorites;

- (void) presentError:(NSString *)message;

- (void) showActivity;
- (void) hideActivity;
@end

NS_ASSUME_NONNULL_END
