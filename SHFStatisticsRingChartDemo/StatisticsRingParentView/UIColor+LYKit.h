//
//  UIColor+LYKit.h
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LYKit)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(CGFloat)alpha;

// 渐变颜色
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;

// 渐变颜色 传rgb
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr start:(CGPoint)startPoint end:(CGPoint)endpoint;
//颜色渐变 传color
+ (CAGradientLayer *)setColorGradualChanging:(UIView *)view fromUIColor:(UIColor *)fromHexColorStr toUIColor:(UIColor *)toHexColorStr start:(CGPoint)startPoint end:(CGPoint)endpoint;
//根据图片获取图片的主色调
+(UIColor*)mostColor:(UIImage*)image;

// 改变UIColor的Alpha
+ (UIColor *)getNewColorWith:(UIColor *)color alpha:(CGFloat)newAlpha;
@end
