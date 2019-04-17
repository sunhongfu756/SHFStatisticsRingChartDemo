//
//  RingInstructionsListModel.h
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RingInstructionsListModel : NSObject

@property (nonatomic,strong) UIColor *imgColor;
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *value;
@property (nonatomic,strong) NSString *percentage;
@property (nonatomic,assign) CGFloat percentageWidth;

@end

NS_ASSUME_NONNULL_END
