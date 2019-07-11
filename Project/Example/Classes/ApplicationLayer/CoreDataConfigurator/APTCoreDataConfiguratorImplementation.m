//
//  APTCoreDataConfiguratorImplementation.m
//   Example
//
//  Created by Alyona Belyaeva on 09/07/2018.
//  Copyright © 2018 MiSolution. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>

#import "APTCoreDataConfiguratorImplementation.h"

@implementation APTCoreDataConfiguratorImplementation

#pragma mark - Public

- (void) setupCoreDataStack {
  if ([self shouldMigrateCoreData]) {
    [self migrateStore];
  } else {
    NSURL *directory = [self.fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.ru.example"];
    NSURL *storeURL = [directory URLByAppendingPathComponent:@"Example.sqlite"];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:storeURL];
  }
  [self _restoreCoreDataStructure];
}

- (BOOL)shouldMigrateCoreData {
  NSString *oldStoreName = [MagicalRecord defaultStoreName];
  return [self.fileManager fileExistsAtPath:oldStoreName];
}

- (void)migrateStore {
  NSString *oldStoreName = [MagicalRecord defaultStoreName];
  NSPersistentStoreCoordinator *coordinator = [NSPersistentStoreCoordinator MR_coordinatorWithSqliteStoreNamed:oldStoreName];
  // grab the current store
  NSPersistentStore *currentStore = coordinator.persistentStores.lastObject;
  // create a new URL
  NSURL *directory = [self.fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.ru.example"];
  NSURL *newStoreURL = [directory URLByAppendingPathComponent:@"Example.sqlite"];
  
  NSDictionary *storeOptions = @{NSPersistentStoreFileProtectionKey: NSFileProtectionComplete};
  // migrate current store to new URL
  [coordinator migratePersistentStore:currentStore
                                toURL:newStoreURL
                              options:storeOptions
                             withType:NSSQLiteStoreType
                                error:nil];
  [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:newStoreURL];
}

#pragma mark - Private

- (void) _restoreCoreDataStructure {
  NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
  [rootSavingContext performBlockAndWait:^{
    //...
    if ([rootSavingContext hasChanges]) {
      [rootSavingContext MR_saveToPersistentStoreAndWait];
    }
  }];
}

@end
