//
//  RingInstructionsListCollectionView.h
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RingInstructionsListCollectionViewDelegate <NSObject>

@end

@interface RingInstructionsListCollectionView : UICollectionView

@property (nonatomic,weak) id<RingInstructionsListCollectionViewDelegate> workbenchDelegate;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

