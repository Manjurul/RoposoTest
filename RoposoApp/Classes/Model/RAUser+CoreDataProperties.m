//
//  RAUser+CoreDataProperties.m
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RAUser+CoreDataProperties.h"

@implementation RAUser (CoreDataProperties)

@dynamic name;
@dynamic id;
@dynamic about;
@dynamic image;
@dynamic profileUrl;
@dynamic handle;
@dynamic isFollowing;
@dynamic followers;
@dynamic followings;
@dynamic createdDate;

@end
