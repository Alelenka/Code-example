//
//  APTProductsListRouter.m
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import <ViperMcFlurry/ViperMcFlurry.h>

#import "APTProductsListRouter.h"
#import "APTProductsListConstants.h"

#import "APTFilterProductsListModuleInput.h"
#import "APTProductDetailModuleInput.h"
#import "APTKitDetailModuleInput.h"
#import "APTProductAlreadyInCartModuleInput.h"

#import "APTStoryboardScreenConstants.h"
#import "APTStoryboardList.h"

NS_ASSUME_NONNULL_BEGIN

@implementation APTProductsListRouter

#pragma mark - Методы <APTProductsListRouterInput>

- (void) showFiltersForCategory:(NSString *)categoryId andBrand:(NSString *)brandId withFilters:(NSArray *)filters moduleOutput:(id)moduleOutput {
	RamblerViperOpenModulePromise *promise = [self.transitionHandler openModuleUsingSegue:kProductListToFilterProductsListSegueIdentifier];
	[promise thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<RamblerViperModuleInput> moduleInput) {
		if (![moduleInput conformsToProtocol:@protocol(APTFilterProductsListModuleInput)]) {
			return nil;
		}
		id<APTFilterProductsListModuleInput> confirmationModuleInput = (id<APTFilterProductsListModuleInput>)moduleInput;
		if (filters.count > 0) {
			[confirmationModuleInput configureModuleWithFilters:filters];
		} else {
			[confirmationModuleInput configureModuleWithCategoryId:categoryId brandId:brandId];
		}
		return moduleOutput;
	}];
}

- (void) showProductDetails:(APTProductPlainObject *)product {
	RamblerViperModuleFactory *factory = [[RamblerViperModuleFactory alloc] initWithViewControllerLoader:APTStoryboardList.productsDetails
																																					 andViewControllerIdentifier:kAPTProductDetailViewControllerIdentifier];
	
	[[self.transitionHandler openModuleUsingFactory:factory
															withTransitionBlock:^(id<RamblerViperModuleTransitionHandlerProtocol> sourceModuleTransitionHandler,
																										id<RamblerViperModuleTransitionHandlerProtocol> destinationModuleTransitionHandler) {
																UIViewController *sourceViewController = (UIViewController *)sourceModuleTransitionHandler;
																UIViewController *destinationViewController = (UIViewController *)destinationModuleTransitionHandler;
																UINavigationController *navigationController = [sourceViewController navigationController];
																[navigationController pushViewController:destinationViewController animated:YES];
															}] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<APTProductDetailModuleInput> moduleInput) {
																[moduleInput configureModuleWithProduct:product];
																return nil;
															}];
	
}

- (void)showProductKitDetails:(APTProductPlainObject *)product {
	RamblerViperModuleFactory *factory = [[RamblerViperModuleFactory alloc] initWithViewControllerLoader:APTStoryboardList.productsDetails
																																					 andViewControllerIdentifier:kAPTKitDetailViewController];
	
	[[self.transitionHandler openModuleUsingFactory:factory
															withTransitionBlock:^(id<RamblerViperModuleTransitionHandlerProtocol> sourceModuleTransitionHandler,
																										id<RamblerViperModuleTransitionHandlerProtocol> destinationModuleTransitionHandler) {
																UIViewController *sourceViewController = (UIViewController *)sourceModuleTransitionHandler;
																UIViewController *destinationViewController = (UIViewController *)destinationModuleTransitionHandler;
																UINavigationController *navigationController = [sourceViewController navigationController];
																[navigationController pushViewController:destinationViewController animated:YES];
															}] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<APTKitDetailModuleInput> moduleInput) {
																[moduleInput configureModuleWithProductKit:product];
																return nil;
															}];
}

@end

NS_ASSUME_NONNULL_END
