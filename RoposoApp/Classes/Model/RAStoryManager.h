//
//  RAStoryManager.h
//  RoposoApp
//
//  Created by Munch on 6/14/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAStoryManager : NSObject

+ (void)like:(BOOL)like
 storyWithId:(NSString *)storyId;
+ (void)follow:(BOOL)follow
    userWithId:(NSString *)userId;

@end
