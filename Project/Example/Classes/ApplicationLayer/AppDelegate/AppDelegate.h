//
//  AppDelegate.h
//  Example
//
//  Created by Alenka on 11/07/2019.
//  Copyright © 2019 Alenka. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol APTUserInterfaceConfiguratorProtocol;
@protocol APTCoreDataConfigurator;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) id<APTUserInterfaceConfiguratorProtocol> userInterfaceConfigurator;
@property (nonatomic, strong) id<APTCoreDataConfigurator> coreDataConfigurator;

@end

