//
//  RADatabaseManager.m
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import "RADatabaseManager.h"
#import "RAUser.h"
#import "RAStory.h"
#import "RAConstants.h"

static RADatabaseManager *databaseManager = nil;

@implementation RADatabaseManager

+ (RADatabaseManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseManager = [[RADatabaseManager alloc] init];
    });
    
    return databaseManager;
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.roposo.RoposoApp" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"RoposoApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"RoposoApp.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Load

- (void)loadData {
    NSString *storyAdded = [[NSUserDefaults standardUserDefaults] objectForKey:@"storyAdded"];
    if(!storyAdded) {
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"stories" ofType:@"json"];
        NSData *fileContent = [NSData dataWithContentsOfFile:jsonPath];
        NSArray *fileContentArray = [NSJSONSerialization JSONObjectWithData:fileContent options:NSJSONReadingAllowFragments error:nil];
        NSArray *users = [fileContentArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"handle != nil"]];
        NSArray *stories = [fileContentArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"handle = nil"]];
        [self addUsers:users];
        [self addStories:stories];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"storyAdded"];
    }
}


#pragma mark - Users


- (void)addUsers:(NSArray *)users
{
    for (NSDictionary *theDict in users) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"RAUser" inManagedObjectContext:self.managedObjectContext]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"(iD == %@)", theDict[@"id"]];
        [request setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
        RAUser *user = nil;
        
        if (results.count) {
            user = [results lastObject];
        }
        else {
            user = [NSEntityDescription insertNewObjectForEntityForName:@"RAUser" inManagedObjectContext:self.managedObjectContext];
        }
                
        VALIDATE_STRING_AND_ASSIGN(user.iD, @"id");
        VALIDATE_STRING_AND_ASSIGN(user.name, @"username");
        VALIDATE_STRING_AND_ASSIGN(user.about, @"about");
        VALIDATE_STRING_AND_ASSIGN(user.image, @"image");
        VALIDATE_STRING_AND_ASSIGN(user.profileUrl, @"url");
        VALIDATE_STRING_AND_ASSIGN(user.handle, @"handle");
        VALIDATE_NUMBER_AND_ASSIGN(user.isFollowing, @"is_following");
        VALIDATE_NUMBER_AND_ASSIGN(user.followings, @"following");
        VALIDATE_NUMBER_AND_ASSIGN(user.followers, @"followers");
        VALIDATE_DATE_AND_ASSIGN(user.createdDate, @"createdOn");
    }
    [self saveContext];
}

- (void)follow:(BOOL)follow
    userWithId:(NSString *)userId {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"RAUser" inManagedObjectContext:self.managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(iD == %@)", userId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    RAUser *user = nil;
    
    if (results.count) {
        user = [results lastObject];
        user.isFollowing = follow ? @1 : @0;
    }
    [self saveContext];
}


- (RAUser*)userWithId:(NSString *)iD {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"RAUser" inManagedObjectContext:self.managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(iD == %@)", iD];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    RAUser *user = nil;
    
    if (results.count) {
        user = [results lastObject];
    }
    return user;
}


#pragma mark - Stories


- (void)addStories:(NSArray *)stories
{
    for (NSDictionary *theDict in stories) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"RAStory" inManagedObjectContext:self.managedObjectContext]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"(iD == %@)", theDict[@"id"]];
        [request setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
        RAStory *story = nil;
        
        if (results.count) {
            story = [results lastObject];
        }
        else {
            story = [NSEntityDescription insertNewObjectForEntityForName:@"RAStory" inManagedObjectContext:self.managedObjectContext];
        }
        
        VALIDATE_STRING_AND_ASSIGN(story.iD, @"id");
        VALIDATE_STRING_AND_ASSIGN(story.story, @"description");
        VALIDATE_STRING_AND_ASSIGN(story.verb, @"verb");
        VALIDATE_STRING_AND_ASSIGN(story.creator, @"db");
        VALIDATE_STRING_AND_ASSIGN(story.postUrl, @"url");
        VALIDATE_STRING_AND_ASSIGN(story.imageUrl, @"si");
        VALIDATE_STRING_AND_ASSIGN(story.type, @"type");
        VALIDATE_STRING_AND_ASSIGN(story.title, @"title");
        VALIDATE_NUMBER_AND_ASSIGN(story.isLiked, @"like_flag");
        VALIDATE_NUMBER_AND_ASSIGN(story.likeCount, @"likes_count");
        VALIDATE_NUMBER_AND_ASSIGN(story.commentCount, @"comment_count");
    }
    [self saveContext];
}

- (void)like:(BOOL)like
 storyWithId:(NSString *)storyId {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"RAStory" inManagedObjectContext:self.managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(iD == %@)", storyId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    RAStory *story = nil;
    
    if (results.count) {
        story = [results lastObject];
        story.isLiked = like ? @1 : @0;
    }
    [self saveContext];
}


- (NSArray<RAStory *>*)allStories
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"RAStory" inManagedObjectContext:self.managedObjectContext]];
    [request setReturnsObjectsAsFaults:NO];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    return results;
}


- (RAStory *)storyForId:(NSString *)iD
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"RAStory" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(iD == %@)", iD];
    [request setPredicate:predicate];
    [request setReturnsObjectsAsFaults:NO];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if(results.count) {
        return [results firstObject];
    }
    return nil;
}

@end
