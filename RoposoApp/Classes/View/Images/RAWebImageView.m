//
//  RAWebImageView.m
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import "RAWebImageView.h"

static NSCache*         _imageCache = nil;

@implementation RAWebImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadImageWithUrl:(NSString *)imageUrl
             placeHolder:(NSString *)placeholderImageName
          withCompletion:(RAWebImageLoadingCompletionHandler)completion {
    if(!_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    if(placeholderImageName && placeholderImageName.length && !self.image) {
        self.image = [UIImage imageNamed:placeholderImageName];
    }
    if(imageUrl && imageUrl.length) {
        UIImage *image = [_imageCache objectForKey:imageUrl];
        if(image) {
            self.image = image;
            completion(YES, nil);
        }
        else {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
            [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                 if(data && !error) {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         UIImage *image = [UIImage imageWithData:data];
                                                         self.image = image;
                                                         [_imageCache setObject:image forKey:imageUrl];
                                                     });
                                                     completion(YES, nil);
                                                 }
                                                 else {
                                                     completion(NO, error);
                                                 }
                                             }] resume];
        }
    }
    else {
        NSError *error = [NSError errorWithDomain:@"InvalidUrl" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Invalid Url"}];
        completion(NO, error);
    }
}

@end
