//
//  APTProductsListAssembly.m
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTProductsListAssembly.h"

#import "APTProductsListViewController.h"
#import "APTProductsListInteractor.h"
#import "APTProductsListPresenter.h"
#import "APTProductsListRouter.h"

#import "APTProductsListDataDisplayManager.h"
#import "APTProductsListCellObjectBuilder.h"
#import "APTListTableViewAnimator.h"

#import "APTServiceComponents.h"
#import "APTPonsomizerAssembly.h"

NS_ASSUME_NONNULL_BEGIN

@implementation APTProductsListAssembly

#pragma mark - VIPER

- (APTProductsListViewController *)viewProductsListModule {
	return [TyphoonDefinition withClass:[APTProductsListViewController class]
												configuration:^(TyphoonDefinition *definition) {
													[definition injectProperty:@selector(output)
																								with:[self presenterProductsListModule]];
													[definition injectProperty:@selector(moduleInput)
																								with:[self presenterProductsListModule]];
													[definition injectProperty:@selector(dataDisplayManager)
																								with:[self dataDisplayManagerProductsList]];
													[definition injectProperty:@selector(tableViewAnimator)
																								with:[self tableViewAnimatorProductsList]];
												}];
}

- (APTProductsListInteractor *)interactorProductsListModule {
	return [TyphoonDefinition withClass:[APTProductsListInteractor class]
												configuration:^(TyphoonDefinition *definition) {
													[definition injectProperty:@selector(output)
																								with:[self presenterProductsListModule]];
													[definition injectProperty:@selector(ponsomizer)
																								with:[self.ponsomizerAssembly ponsomizer]];
													[definition injectProperty:@selector(productService)
																								with:[self.serviceComponents productService]];
													[definition injectProperty:@selector(favoriteService)
																								with:[self.serviceComponents favoriteService]];
													[definition injectProperty:@selector(userService)
																								with:[self.serviceComponents userService]];
													[definition injectProperty:@selector(cartService)
																								with:[self.serviceComponents cartService]];
												}];
}

- (APTProductsListPresenter *)presenterProductsListModule {
	return [TyphoonDefinition withClass:[APTProductsListPresenter class]
												configuration:^(TyphoonDefinition *definition) {
													[definition injectProperty:@selector(view)
																								with:[self viewProductsListModule]];
													[definition injectProperty:@selector(interactor)
																								with:[self interactorProductsListModule]];
													[definition injectProperty:@selector(router)
																								with:[self routerProductsListModule]];
												}];
}

- (APTProductsListRouter *)routerProductsListModule {
	return [TyphoonDefinition withClass:[APTProductsListRouter class]
												configuration:^(TyphoonDefinition *definition) {
													[definition injectProperty:@selector(transitionHandler)
																								with:[self viewProductsListModule]];
												}];
}

- (APTProductsListDataDisplayManager *) dataDisplayManagerProductsList {
	return [TyphoonDefinition withClass:[APTProductsListDataDisplayManager class]
												configuration:^(TyphoonDefinition *definition) {
													[definition injectProperty:@selector(cellObjectBuilder)
																								with:[self cellObjectBuilderProductsList]];
													[definition injectProperty:@selector(delegate)
																								with:[self viewProductsListModule]];
													[definition injectProperty:@selector(animator)
																								with:[self tableViewAnimatorProductsList]];
												}];
}

- (APTProductsListCellObjectBuilder *) cellObjectBuilderProductsList {
	return [TyphoonDefinition withClass:[APTProductsListCellObjectBuilder class]
												configuration:^(TyphoonDefinition *definition) {
													[definition useInitializer:@selector(initWithDelegate:)
																					parameters:^(TyphoonMethod *initializer) {
																						[initializer injectParameterWith:[self dataDisplayManagerProductsList]];
																					}];
												}];
}

- (APTListTableViewAnimator *) tableViewAnimatorProductsList {
	return [TyphoonDefinition withClass:[APTListTableViewAnimator class]];
}

@end

NS_ASSUME_NONNULL_END
