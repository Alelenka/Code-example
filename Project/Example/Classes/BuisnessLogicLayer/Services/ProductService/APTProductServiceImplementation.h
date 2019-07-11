//
//  APTProductServiceImplementation.h
//  Example
//
//  Created by Alenka on 11/07/2019.
//  Copyright © 2019 Alenka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APTProductService.h"

@class APTProductOperationFactory;
@protocol APTOperationScheduler;

NS_ASSUME_NONNULL_BEGIN

@interface APTProductServiceImplementation : NSObject  <APTProductService>
@property (nonatomic, strong) APTProductOperationFactory *productOperationFactory;
@property (nonatomic, strong) id <APTOperationScheduler> operationScheduler;

@end

NS_ASSUME_NONNULL_END
