//
//  RAStoryManager.m
//  RoposoApp
//
//  Created by Munch on 6/14/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import "RAStoryManager.h"
#import "RADatabaseManager.h"
#import "RAConstants.h"

@implementation RAStoryManager

+ (void)like:(BOOL)like
 storyWithId:(NSString *)storyId {
    [[RADatabaseManager sharedManager] like:like
                                storyWithId:storyId];
    [[NSNotificationCenter defaultCenter] postNotificationName:k_LikedNotification
                                                        object:nil
                                                      userInfo:@{k_storyId : storyId, k_status : like ? @1 : @0}];
}

+ (void)follow:(BOOL)follow
    userWithId:(NSString *)userId {
    [[RADatabaseManager sharedManager] follow:follow
                                   userWithId:userId];
    [[NSNotificationCenter defaultCenter] postNotificationName:k_FollowedNotification
                                                        object:nil
                                                      userInfo:@{k_userId : userId, k_status : follow ? @1 : @0}];
}

@end
