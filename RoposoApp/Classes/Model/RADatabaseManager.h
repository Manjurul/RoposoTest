//
//  RADatabaseManager.h
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RAUser, RAStory;
@interface RADatabaseManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (RADatabaseManager *)sharedManager;
- (void)saveContext;
- (void)loadData;

#pragma mark - Users

- (RAUser*)userWithId:(NSString *)iD;

#pragma mark - Stories

- (NSArray<RAStory *>*)allStories;
- (RAStory *)storyForId:(NSString *)iD;

@end
