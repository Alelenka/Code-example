//
//  APTUserInterfaceConfiguratorProtocol.h
//  Example
//
//  Created by Alenka on 11/07/2019.
//  Copyright © 2019 Alenka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol APTUserInterfaceConfiguratorProtocol <NSObject>
- (void) prepareKeyboard;
- (void) configureNavigationItemsAppearance;
- (void) configureNavigationBar;
- (void) configureSearchBarAppearance;
@end

NS_ASSUME_NONNULL_END
