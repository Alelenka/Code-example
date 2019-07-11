//
//  APTProductsListRouter.h
//   Example
//
//  Created by Alena Belyaeva on 11/1/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTModuleRouterBase.h"
#import "APTProductsListRouterInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface APTProductsListRouter : APTModuleRouterBase <APTProductsListRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end

NS_ASSUME_NONNULL_END


