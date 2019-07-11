//
//  APTProductsListSortModel.h
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    APTProductsListSortTypePopularity,
    APTProductsListSortTypePrice,
    APTProductsListSortTypeName,
} APTProductsListSortType;

@interface APTProductsListSortModel : NSObject

@property (nonatomic, assign) APTProductsListSortType sortType;
@property (nonatomic, strong, readonly, nullable) NSString *sortOrderKey;
- (instancetype)initWithSortType:(APTProductsListSortType)sortType;

+ (NSString *) stringSortType:(APTProductsListSortType)sortType;
+ (NSArray *) sortList;

@end

NS_ASSUME_NONNULL_END
