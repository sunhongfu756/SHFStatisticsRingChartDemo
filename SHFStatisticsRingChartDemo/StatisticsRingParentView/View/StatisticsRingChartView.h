//
//  StatisticsRingChartView.h
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsRingChartView : UIView

#define k_Width_Scale  (self.frame.size.width / [UIScreen mainScreen].bounds.size.width)

/**
 *  数据源标题数组
 */
@property (nonatomic, strong) NSArray * valueDataTitlesArr;


/**
 *  数据源的数组
 */
@property (nonatomic, strong) NSArray * valueDataArr;


/**
 *  循环图中的颜色数组
 */
@property (nonatomic, strong) NSArray * fillColorArray;


/**
 *  环图宽度
 */
@property (nonatomic, assign) CGFloat ringWidth;

/**
 *  中间无色区域半径
 */
@property (nonatomic,assign) CGFloat redius;

/**
 *
 *  图表圆环的中心点
 */
@property (assign, nonatomic)  CGPoint chartOrigin;

/**
 *
 *  图表圆环的中心数值
 */
@property (strong, nonatomic)  NSString *ringTitle;

/**
 *
 *  图表圆环的中心描述
 */
@property (nonatomic,strong) NSString *ringDescription;

/**
 *  开始绘制图表.
 */
- (void)showAnimation;

@end

NS_ASSUME_NONNULL_END
