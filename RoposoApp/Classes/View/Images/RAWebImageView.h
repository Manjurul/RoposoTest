//
//  RAWebImageView.h
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RAWebImageView : UIImageView

typedef void (^RAWebImageLoadingCompletionHandler)(BOOL success, NSError *error);

- (void)loadImageWithUrl:(NSString *)imageUrl
             placeHolder:(NSString *)placeholderImageName
          withCompletion:(RAWebImageLoadingCompletionHandler)completion;

@end
