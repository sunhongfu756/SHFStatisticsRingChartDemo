//
//  RingInstructionsCollectionViewCell.h
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RingInstructionsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RingInstructionsCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) RingInstructionsListModel *ringInstructionsListModel;
@end

NS_ASSUME_NONNULL_END
