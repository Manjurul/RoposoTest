//
//  RAHomeCollectionViewCell.h
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RAStory, RAWebImageView;
@protocol RAHomeCollectionViewCellDelegate;

@interface RAHomeCollectionViewCell : UICollectionViewCell

@property(nonatomic, assign) id<RAHomeCollectionViewCellDelegate> delegate;

- (void)loadStoryWithId:(NSString *)storyId;

@end



@protocol RAHomeCollectionViewCellDelegate <NSObject>

@optional

- (void)homeCell:(RAHomeCollectionViewCell *)cell didSelectImageView:(RAWebImageView *)imageView;
- (void)homeCell:(RAHomeCollectionViewCell *)cell didSelectFollow:(BOOL)follow;
- (void)homeCell:(RAHomeCollectionViewCell *)cell didSelectLike:(BOOL)like;

@end