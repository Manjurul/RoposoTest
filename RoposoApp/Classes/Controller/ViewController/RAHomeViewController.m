//
//  RAHomeViewController.m
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//

#import "RAHomeViewController.h"
#import "RAStoryViewController.h"
#import "RAHomeCollectionViewCell.h"
#import "RAImageViewerView.h"
#import "RADatabaseManager.h"
#import "RAStory.h"

@interface RAHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, RAHomeCollectionViewCellDelegate> {
    IBOutlet UICollectionView*              _storyCollectionView;
}

@property(nonatomic, strong) NSArray<RAStory *> *stories;

@end

@implementation RAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stories = [[RADatabaseManager sharedManager] allStories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"RAStoryViewController"]) {
        NSIndexPath *indexPath = [_storyCollectionView indexPathForCell:(RAHomeCollectionViewCell *)sender];
        RAStoryViewController *storyVC = [segue destinationViewController];
        RAStory *story = self.stories[indexPath.row];
        [storyVC setStoryId:story.iD];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RAHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RAHomeCollectionViewCell" forIndexPath:indexPath];
    cell.layer.masksToBounds = NO;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 7.0f;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.75f;
    cell.layer.shadowRadius = 5.0f;
    cell.layer.shadowOffset = CGSizeZero;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.shouldRasterize = YES;
    cell.delegate = self;
    [cell loadStory:self.stories[indexPath.row]];
    return cell;
}


#pragma mark - Collection View Cell Delegate


- (void)homeCell:(RAHomeCollectionViewCell *)cell didSelectImageView:(RAWebImageView *)imageView {
    NSIndexPath *indexPath = [_storyCollectionView indexPathForCell:cell];
    RAStory *story = self.stories[indexPath.row];
    [RAImageViewerView showImageWithUrl:story.imageUrl];
}


@end
