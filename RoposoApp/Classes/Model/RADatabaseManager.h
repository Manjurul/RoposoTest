//
//  RADatabaseManager.h
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RADatabaseManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (RADatabaseManager *)sharedManager;

- (void)saveContext;


@end
