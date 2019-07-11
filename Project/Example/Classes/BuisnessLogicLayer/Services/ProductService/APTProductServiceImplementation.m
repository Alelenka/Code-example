//
//  APTProductServiceImplementation.m
//  Example
//
//  Created by Alenka on 11/07/2019.
//  Copyright © 2019 Alenka. All rights reserved.
//
#import <MagicalRecord/MagicalRecord.h>

#import "APTProductServiceImplementation.h"
#import "APTProductOperationFactory.h"

#import "APTOperationScheduler.h"
#import "APTCompoundOperationBase.h"

#import "APTMethodNameConstants.h"

@implementation APTProductServiceImplementation

- (void) getCategoriesTreeWithCompletionBlock:(APTProductServiceCompletionBlock)completion {
	NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
	[rootSavingContext performBlock:^{
		APTCompoundOperationBase *compoundOperation = [self.productOperationFactory getCategoryTree];
		compoundOperation.resultBlock = ^void(NSArray <APTCategoryModelObject *> *data, NSError *error) {
			
			//Remove oldCategories
			NSMutableArray *idsArray = @[].mutableCopy;
			for (APTCategoryModelObject *category in data) {
				[idsArray addObject:category.id];
				for (APTCategoryModelObject *subcategory in category.subcategories) {
					[idsArray addObject:subcategory.id];
				}
			}
			
			NSArray *allCategories = [APTCategoryModelObject MR_findAllInContext:rootSavingContext];
			NSMutableArray *oldCategories = @[].mutableCopy;
			
			for (APTCategoryModelObject *oldCategory in allCategories) {
				if (![idsArray containsObject:oldCategory.id]) {
					[oldCategories addObject:oldCategory];
				}
			}
			
			[rootSavingContext MR_deleteObjects:oldCategories];
			
			
			if (!error && [data count] > 0) {
				if ([rootSavingContext hasChanges]) {
					[rootSavingContext MR_saveToPersistentStoreAndWait];
				}
			}
			
			dispatch_async(dispatch_get_main_queue(), ^{
				completion(error);
			});
		};
		[self.operationScheduler addOperation:compoundOperation];
	}];
}

@end
