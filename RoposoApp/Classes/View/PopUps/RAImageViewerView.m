//
//  RAImageViewerView.m
//  RoposoApp
//
//  Created by Munch on 6/14/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import "RAImageViewerView.h"
#import "RAWebImageView.h"

@implementation RAImageViewerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showImageWithUrl:(NSString *)imageUrl {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    RAImageViewerView *imageViewer = [[RAImageViewerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenRect.size.width, screenRect.size.height)];
    [imageViewer setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f]];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:imageViewer];
    [imageViewer configureWithImageUrl:imageUrl];
}

- (void)configureWithImageUrl:(NSString *)imageUrl {
    RAWebImageView *imageView = [[RAWebImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width - 40.0f, self.frame.size.width - 20.0f)];
    [imageView setCenter:CGPointMake(self.frame.size.width * 0.5f, self.frame.size.height * 0.5f)];
    [self addSubview:imageView];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView loadImageWithUrl:imageUrl
                    placeHolder:@"placeholder"
                 withCompletion:^(BOOL success, NSError *error) {
                     
                 }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton setFrame:CGRectMake(5.0f, 5.0f, 50.0f, 30.0f)];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(action_close:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
}

- (void)action_close:(id)sender {
    [self removeFromSuperview];
}

@end
