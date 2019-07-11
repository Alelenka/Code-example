//
//  APTCoreDataConfiguratorImplementation.h
//   Example
//
//  Created by Alyona Belyaeva on 09/07/2018.
//  Copyright © 2018 MiSolution. All rights reserved.
//

#import "APTCoreDataConfigurator.h"

@interface APTCoreDataConfiguratorImplementation : NSObject <APTCoreDataConfigurator>
@property (nonatomic, strong) NSFileManager *fileManager;
@end
