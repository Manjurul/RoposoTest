//
//  RAStoryViewController.m
//  RoposoApp
//
//  Created by Munch on 6/14/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import "RAStoryViewController.h"
#import "RADatabaseManager.h"
#import "RAWebImageView.h"
#import "RAImageViewerView.h"
#import "RAUser.h"
#import "RAStory.h"

@interface RAStoryViewController () {
    IBOutlet RAWebImageView*            _profileImageView;
    IBOutlet RAWebImageView*            _postImageView;
    
    IBOutlet UILabel*                   _nameLabel;
    IBOutlet UILabel*                   _handleLabel;
    IBOutlet UILabel*                   _followerLabel;
    IBOutlet UILabel*                   _followingLabel;
    IBOutlet UILabel*                   _aboutLabel;
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

@implementation RAStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.storyId) {
        RAStory *story = [[RADatabaseManager sharedManager] storyForId:self.storyId];
        if(story) {
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
            [_followerLabel setText:[NSString stringWithFormat:@"%ld Followers", [creator.followers longValue]]];
            [_followingLabel setText:[NSString stringWithFormat:@"%ld Followings", [creator.followings longValue]]];
            [_aboutLabel setText:creator.about];
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
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
            [_postImageView addGestureRecognizer:tapGesture];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Button Actions

- (IBAction)action_follow:(id)sender {
    
}

- (IBAction)action_like:(id)sender {
    
}

- (IBAction)action_comment:(id)sender {
    
}

#pragma mark - Gestures

- (void)imageViewTapped:(UITapGestureRecognizer *)sender {
    RAStory *story = [[RADatabaseManager sharedManager] storyForId:self.storyId];
    [RAImageViewerView showImageWithUrl:story.imageUrl];
}

@end
