//
//  StatisticsRingParentViewModel.h
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RingInstructionsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsRingParentViewModel : NSObject

@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSMutableArray *valueDataArr;
@property (nonatomic,strong) NSString *ringTitle;
@property (nonatomic,strong) NSString *ringDescription;
@property (nonatomic,strong) NSMutableArray *ringInstructionsListDataArray;

@property (nonatomic,strong) NSArray *colorsArray;

@end

NS_ASSUME_NONNULL_END
