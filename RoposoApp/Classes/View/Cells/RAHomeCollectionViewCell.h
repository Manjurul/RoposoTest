//
//  RAHomeCollectionViewCell.h
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RAStory;
@interface RAHomeCollectionViewCell : UICollectionViewCell

- (void)loadStory:(RAStory *)story;

@end
