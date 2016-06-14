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
#import "RAConstants.h"

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

@property(nonatomic, strong) NSString *storyId;

@end

@implementation RAHomeCollectionViewCell

#pragma mark - Load

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notification_followed:)
                                                 name:k_FollowedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notification_liked:)
                                                 name:k_LikedNotification
                                               object:nil];
}

- (void)loadStoryWithId:(NSString *)storyId {
    self.storyId = storyId;
    RAStory *story = [[RADatabaseManager sharedManager] storyForId:self.storyId];
    RAUser *creator = [[RADatabaseManager sharedManager] userWithId:story.creator];
    [_profileImageView loadImageWithUrl:creator.image
                            placeHolder:@"placeholder"
                         withCompletion:^(BOOL success, NSError *error) {
                             
                         }];
    [_postImageView loadImageWithUrl:story.imageUrl
                         placeHolder:@"placeholder"
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
        [_followButton setSelected:YES];
    }
    if([story.isLiked boolValue]) {
        [_likeButton setSelected:YES];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_imageViewTapped:)];
    [_postImageView addGestureRecognizer:tapGesture];
}

#pragma mark - Button Actions

- (IBAction)action_follow:(id)sender {
    UIButton *followButton = (UIButton *)sender;
    followButton.selected = !followButton.selected;
    if(self.delegate && [self.delegate respondsToSelector:@selector(homeCell:didSelectFollow:)]) {
        [self.delegate homeCell:self didSelectFollow:followButton.selected];
    }
}

- (IBAction)action_like:(id)sender {
    UIButton *likeButton = (UIButton *)sender;
    likeButton.selected = !likeButton.selected;
    if(self.delegate && [self.delegate respondsToSelector:@selector(homeCell:didSelectLike:)]) {
        [self.delegate homeCell:self didSelectLike:likeButton.selected];
    }
}

- (IBAction)action_comment:(id)sender {
    
}

#pragma mark - Gestures

- (void)gesture_imageViewTapped:(UITapGestureRecognizer *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(homeCell:didSelectImageView:)]) {
        [self.delegate homeCell:self didSelectImageView:(RAWebImageView *)sender.view];
    }
}

#pragma mark - Gestures

- (void)notification_followed:(NSNotification *)notification {
    NSString *userId = notification.userInfo[k_userId];
    RAStory *story = [[RADatabaseManager sharedManager] storyForId:self.storyId];
    RAUser *creator = [[RADatabaseManager sharedManager] userWithId:story.creator];
    if([creator.iD isEqualToString:userId]) {
        NSNumber *status = notification.userInfo[k_status];
        _followButton.selected = [status boolValue];
    }
}

- (void)notification_liked:(NSNotification *)notification {
    NSString *storyId = notification.userInfo[k_storyId];
    if([self.storyId isEqualToString:storyId]) {
        NSNumber *status = notification.userInfo[k_status];
        _likeButton.selected = [status boolValue];
    }
}

@end
