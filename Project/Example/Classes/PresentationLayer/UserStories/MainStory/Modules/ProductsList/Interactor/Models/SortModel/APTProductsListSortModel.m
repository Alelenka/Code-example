//
//  APTProductsListSortModel.m
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTProductsListSortModel.h"

#import "APTUIStringList.h"

@implementation APTProductsListSortModel

#pragma mark - LifeCycle

- (instancetype)initWithSortType:(APTProductsListSortType)sortType {
    self = [super init];
    if(self) {
        _sortType = sortType;
    }
    return self;
}

#pragma mark - Public

+ (NSString *) stringSortType:(APTProductsListSortType)sortType {
    switch (sortType) {
        case APTProductsListSortTypePopularity:
            return APTUIStringList.sortPopularityTypeText;
            break;
        case APTProductsListSortTypeName:
            return APTUIStringList.sortNameTypeText;
            break;
        case APTProductsListSortTypePrice:
            return APTUIStringList.sortPriceTypeText;
            break;
    }
}

+ (NSArray *) sortList {
    return @[
             @(APTProductsListSortTypePopularity),
             @(APTProductsListSortTypePrice),
             @(APTProductsListSortTypeName),
             ];
}

- (NSString *) sortOrderKey {
	switch (self.sortType) {
		case APTProductsListSortTypePopularity:
			return nil;
			break;
		case APTProductsListSortTypeName:
			return @"name";
			break;
		case APTProductsListSortTypePrice:
			return @"price";
			break;
	}
}

@end
