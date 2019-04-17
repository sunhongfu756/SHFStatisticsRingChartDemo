//
//  RingInstructionsListCollectionView.m
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import "RingInstructionsListCollectionView.h"
#import "RingInstructionsCollectionViewCell.h"

@interface RingInstructionsListCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

static NSString *identifier = @"RingInstructionsCollectionViewCell";

@implementation RingInstructionsListCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self registerClass:[RingInstructionsCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        self.delegate = self;
        self.dataSource = self;
        
        //        [self setBackgroundColor:[UIColor clearColor]];
        self.backgroundColor = [UIColor colorWithHexString:@"#F1F3F5"];
        
        self.layer.cornerRadius = 4;
        self.layer.borderColor = [UIColor colorWithHexString:@"#000000" andAlpha:0.04].CGColor;
        self.layer.borderWidth = 1;
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
//    NSInteger count = self.dataArray.count%4 != 0 ? self.dataArray.count + (4 - self.dataArray.count%4) : self.dataArray.count;
//    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _dataArray.count) {
        RingInstructionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.ringInstructionsListModel = _dataArray[indexPath.row];

        return cell;
    }
    else
    {
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.width, 34);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Private
- (void)setDataArray:(NSMutableArray *)dataArray
{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
    }
    [self  reloadData];
    
    [self performBatchUpdates:^{
        self.frame = CGRectMake(self.left, self.top, self.width, self.contentSize.height);
    } completion:^(BOOL finished) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
