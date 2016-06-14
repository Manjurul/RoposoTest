//
//  RAHomeCollectionViewCell.m
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import "RAHomeCollectionViewCell.h"
#import "RADatabaseManager.h"
#import "RAWebImageView.h"
#import "RAUser.h"
#import "RAStory.h"

@interface RAHomeCollectionViewCell () {
    IBOutlet RAWebImageView*            _profileImageView;
    IBOutlet RAWebImageView*            _postImageView;

    IBOutlet UILabel*                   _nameLabel;
    IBOutlet UILabel*                   _handleLabel;
    IBOutlet UILabel*                   _titleLabel;
    IBOutlet UILabel*                   _messageLabel;
    IBOutlet UILabel*                   _verbLabel;
    IBOutlet UILabel*                   _likeCountLabel;
    IBOutlet UILabel*                   _commentCountLabel;

    IBOutlet UIButton*                  _followButton;
    IBOutlet UIButton*                  _likeButton;
    IBOutlet UIButton*                  _commentButton;
}

@end

@implementation RAHomeCollectionViewCell

#pragma mark - Load

- (void)loadStory:(RAStory *)story {
    RAUser *creator = [[RADatabaseManager sharedManager] userWithId:story.creator];
    [_profileImageView loadImageWithUrl:creator.image
                            placeHolder:@""
                         withCompletion:^(BOOL success, NSError *error) {
                             
                         }];
    [_postImageView loadImageWithUrl:story.imageUrl
                         placeHolder:@""
                      withCompletion:^(BOOL success, NSError *error) {
                          
                      }];
    [_nameLabel setText:creator.name];
    [_handleLabel setText:creator.handle];
    [_titleLabel setText:story.title];
    [_messageLabel setText:story.story];
    [_verbLabel setText:story.verb];
    [_likeCountLabel setText:[NSString stringWithFormat:@"(%ld)", [story.likeCount longValue]]];
    [_commentCountLabel setText:[NSString stringWithFormat:@"(%ld)", [story.commentCount longValue]]];
        
    if([creator.isFollowing boolValue]) {
        [_followButton setTitle:@"Following" forState:UIControlStateNormal];
        [_followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_followButton setBackgroundColor:[UIColor blueColor]];
    }
    if([story.isLiked boolValue]) {
        [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_likeButton setBackgroundColor:[UIColor blueColor]];
    }
}

#pragma mark - Button Actions

- (IBAction)action_follow:(id)sender {
    
}

- (IBAction)action_like:(id)sender {
    
}

- (IBAction)action_comment:(id)sender {
    
}

@end
