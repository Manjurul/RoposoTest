//
//  RAStory+CoreDataProperties.h
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RAStory.h"

NS_ASSUME_NONNULL_BEGIN

@interface RAStory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *story;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *verb;
@property (nullable, nonatomic, retain) NSString *creator;
@property (nullable, nonatomic, retain) NSString *postUrl;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *isLiked;
@property (nullable, nonatomic, retain) NSNumber *likeCount;
@property (nullable, nonatomic, retain) NSNumber *commentCount;

@end

NS_ASSUME_NONNULL_END
