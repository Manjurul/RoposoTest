//
//  RAUser+CoreDataProperties.h
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RAUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface RAUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *iD;
@property (nullable, nonatomic, retain) NSString *about;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *profileUrl;
@property (nullable, nonatomic, retain) NSString *handle;
@property (nullable, nonatomic, retain) NSNumber *isFollowing;
@property (nullable, nonatomic, retain) NSNumber *followers;
@property (nullable, nonatomic, retain) NSNumber *followings;
@property (nullable, nonatomic, retain) NSDate *createdDate;

@end

NS_ASSUME_NONNULL_END
