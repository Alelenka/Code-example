//
//  AppDelegate.m
//  Example
//
//  Created by Alenka on 11/07/2019.
//  Copyright © 2019 Alenka. All rights reserved.
//

#import <RamblerTyphoonUtils/AssemblyCollector.h>
#import <GoogleMaps/GoogleMaps.h>

#import "AppDelegate.h"

#import "APTUserInterfaceConfiguratorProtocol.h"
#import "APTCoreDataConfigurator.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSArray *)initialAssemblies {
	RamblerInitialAssemblyCollector *collector = [RamblerInitialAssemblyCollector new];
	return [collector collectInitialAssemblyClasses];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
#if DEBUG
//	[GMSServices provideAPIKey:@""];
#else
//	[GMSServices provideAPIKey:@""];
#endif
	[self.userInterfaceConfigurator prepareKeyboard];
	[self.userInterfaceConfigurator configureNavigationItemsAppearance];
	[self.userInterfaceConfigurator configureNavigationBar];
	[self.userInterfaceConfigurator configureSearchBarAppearance];
	
	[self.coreDataConfigurator setupCoreDataStack];
	
	
	return YES;
}
@end
