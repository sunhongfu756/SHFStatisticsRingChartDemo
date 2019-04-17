//
//  StatisticsDataModel.h
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsDataModel : NSObject

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *descriptionStr;
@property (nonatomic,strong) UIFont *descriptionFont;//首页统计能用到
@property (nonatomic,strong) UIColor *textColor;//统计详情页能用到

@end

NS_ASSUME_NONNULL_END
