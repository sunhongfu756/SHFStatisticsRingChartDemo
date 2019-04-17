//
//  StatisticsRingChartView.m
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//
#import "StatisticsRingChartView.h"

#define k_COLOR_STOCK @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000], [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],[UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],[UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000]]

@interface StatisticsRingChartView ()

//环图间隔 单位为π
@property (nonatomic,assign)CGFloat itemsSpace;

//数值和
@property (nonatomic,assign) CGFloat totolCount;

@end

@implementation StatisticsRingChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.chartOrigin = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2);
        _redius = (CGRectGetHeight(self.frame) -60*k_Width_Scale)/4;
        _ringWidth = 40;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setValueDataArr:(NSArray *)valueDataArr
{
    _valueDataArr = valueDataArr;
    
    [self configBaseData];
}

- (void)configBaseData
{
    _totolCount = 0;
    _itemsSpace =  2.0 / 90; //四分之一 π 一周360 _itemsSpace间隔是想要的d间隔数占四分之一周的百分比系数
    if (_valueDataArr.count < 2) {
        _itemsSpace = 0;
    }
    for (id obj in _valueDataArr) {
        
        _totolCount += [obj floatValue];
        
    }
}

//开始动画
- (void)showAnimation
{
    /*        动画开始前，应当移除之前的layer         */
    for (int i = 0; i < self.layer.sublayers.count; i++) {
        CALayer *layer = self.layer.sublayers[i];
        [layer removeFromSuperlayer];
    }
    
    CGFloat lastBegin = -M_PI_2;
    
    CGFloat totloL = 0;
    NSInteger  i = 0;
    for (id obj in _valueDataArr) {
        
        CAShapeLayer *layer = [CAShapeLayer layer] ;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        layer.fillColor = [UIColor clearColor].CGColor;
        
        if (i<_fillColorArray.count) {
            layer.strokeColor =[_fillColorArray[i] CGColor];
        }else{
            layer.strokeColor =[k_COLOR_STOCK[i%k_COLOR_STOCK.count] CGColor];
        }
        CGFloat cuttentpace = [obj floatValue] / _totolCount * (M_PI * 2 - _itemsSpace * _valueDataArr.count);
        
        totloL += [obj floatValue] / _totolCount;
        CGFloat redius = _redius + _ringWidth/2;
        [path addArcWithCenter:self.chartOrigin radius:redius startAngle:lastBegin  endAngle:lastBegin  + cuttentpace clockwise:YES];
        
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        layer.lineWidth = _ringWidth;
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        basic.fromValue = @(0);
        basic.toValue = @(1);
        basic.duration = 1.0;
        basic.fillMode = kCAFillModeForwards;
        
        [layer addAnimation:basic forKey:@"basic"];
        lastBegin += (cuttentpace+_itemsSpace);
        i++;
    }
}

-(void)drawRect:(CGRect)rect
{
    //    if (!_valueDataTitlesArr.count) {
    //        return;
    //    }
    CGContextRef contex = UIGraphicsGetCurrentContext();
    NSString *str = self.ringTitle;
    UIFont *font = [UIFont systemFontOfSize:18];
    if (str.length > 7) {
        font = [UIFont systemFontOfSize:15];
    }
    CGFloat leftSpace = (self.width - 2*_ringWidth - _redius*2)/2;
    CGFloat topSpace = (self.height - 2*_ringWidth - _redius*2)/2;
    CGFloat textWidth = [self getTextWidth:font string:str];
    //    CGSize textSize = [self sizeOfContent:@"99999" labelFont:UIFontMedium(kWord_Font_18pt) isFixWidth:NO fixValue:20];
    textWidth = MIN(textWidth, _redius*2);
    [self drawText:str context:contex atPoint:CGRectMake(leftSpace + _ringWidth  +(_redius*2 - textWidth)/2,topSpace + 60, textWidth, 22) WithColor:[UIColor colorWithHexString:@"#4487FA"] font:font];

    CGFloat titleWidth = [self getTextWidth:[UIFont systemFontOfSize:12] string:self.ringDescription];
    [self drawText:self.ringDescription context:contex atPoint:CGRectMake(leftSpace + _ringWidth  +(_redius*2 - titleWidth)/2, topSpace + 85, titleWidth, 17) WithColor:[UIColor colorWithHexString:@"#949DA1"] font:[UIFont systemFontOfSize:12]];
    
    if (!_valueDataTitlesArr.count) {
        return;
    }
    CGFloat lastBegin = 0;
    CGFloat longLen = _redius +_ringWidth*2*k_Width_Scale;
    for (NSInteger i = 0; i<_valueDataArr.count; i++) {
        id obj = _valueDataArr[i];
        CGFloat currentSpace = [obj floatValue] / _totolCount * (M_PI * 2 - _itemsSpace * _valueDataArr.count);;
        NSLog(@"%f",currentSpace);
        CGFloat midSpace = lastBegin + currentSpace / 2;
        
        CGPoint begin = CGPointMake(self.chartOrigin.x + sin(midSpace) * _redius, self.chartOrigin.y - cos(midSpace)*_redius);
        CGPoint endx = CGPointMake(self.chartOrigin.x + sin(midSpace) * longLen, self.chartOrigin.y - cos(midSpace)*longLen);
        
        NSLog(@"%@%@",NSStringFromCGPoint(begin),NSStringFromCGPoint(endx));
        lastBegin += _itemsSpace + currentSpace;
        
        UIColor *color;
        
        if (_fillColorArray.count<_valueDataArr.count) {
            color = k_COLOR_STOCK[i%k_COLOR_STOCK.count];
        }else{
            color = _fillColorArray[i];
        }
        
        [self drawLineWithContext:contex andStarPoint:begin andEndPoint:endx andIsDottedLine:NO andColor:color];
        
        CGPoint secondP = CGPointZero;
        
        CGSize size = [[NSString stringWithFormat:@"%.02f%c",[obj floatValue] / _totolCount * 100,'%'] boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10*k_Width_Scale]} context:nil].size;
        
        if (midSpace < M_PI)
        {
            secondP =CGPointMake(endx.x + 20*k_Width_Scale, endx.y);
            [self drawText:[NSString stringWithFormat:@"%.02f%c",[obj floatValue] / _totolCount * 100,'%'] andContext:contex atPoint:CGPointMake(secondP.x + 3, secondP.y - size.height / 2) WithColor:color andFontSize:10*k_Width_Scale];
            [self drawText:self.valueDataTitlesArr[i] andContext:contex atPoint:CGPointMake(secondP.x + 3, secondP.y - size.height / 2 - 10) WithColor:color andFontSize:10*k_Width_Scale];
        }
        else
        {
            secondP =CGPointMake(endx.x - 20*k_Width_Scale, endx.y);
            [self drawText:[NSString stringWithFormat:@"%.02f%c",[obj floatValue] / _totolCount * 100,'%'] andContext:contex atPoint:CGPointMake(secondP.x - size.width - 3, secondP.y - size.height/2) WithColor:color andFontSize:10*k_Width_Scale];
            [self drawText:self.valueDataTitlesArr[i] andContext:contex atPoint:CGPointMake(secondP.x - 30, secondP.y - size.height / 2 - 10) WithColor:color andFontSize:10*k_Width_Scale];
            
        }
        [self drawLineWithContext:contex andStarPoint:endx andEndPoint:secondP andIsDottedLine:NO andColor:color];
        [self drawPointWithRedius:3*k_Width_Scale andColor:color andPoint:secondP andContext:contex];
    }
}

/**
 *  绘制文字
 *
 *  @param text    文字内容
 *  @param context 图形绘制上下文
 *  @param rect    绘制frame
 *  @param color   绘制颜色
 */
- (void)drawText:(NSString *)text context:(CGContextRef )context atPoint:(CGRect )rect WithColor:(UIColor *)color font:(UIFont*)font
{
    //    [[NSString stringWithFormat:@"%@",text] drawAtPoint:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    [[NSString stringWithFormat:@"%@",text] drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    
    [color setFill];
    
    CGContextDrawPath(context, kCGPathFill);
}

/*
 * @param CGPoint rect    绘制起点坐标
 */
- (void)drawText:(NSString *)text andContext:(CGContextRef )context atPoint:(CGPoint )rect WithColor:(UIColor *)color andFontSize:(CGFloat)fontSize
{
    [[NSString stringWithFormat:@"%@",text] drawAtPoint:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:color}];
    
    [color setFill];
    
    CGContextDrawPath(context, kCGPathFill);
}


/**
 *  绘制线段
 *
 *  @param context  图形绘制上下文
 *  @param start    起点
 *  @param end      终点
 *  @param isDotted 是否是虚线
 *  @param color    线段颜色
 */
- (void)drawLineWithContext:(CGContextRef )context andStarPoint:(CGPoint )start andEndPoint:(CGPoint)end andIsDottedLine:(BOOL)isDotted andColor:(UIColor *)color
{
    //    移动到点
    CGContextMoveToPoint(context, start.x, start.y);
    //    连接到
    CGContextAddLineToPoint(context, end.x, end.y);
    
    CGContextSetLineWidth(context, 0.3);
    
    [color setStroke];
    
    if (isDotted) {
        CGFloat ss[] = {1.5,2};
        
        CGContextSetLineDash(context, 0, ss, 2);
    }
    CGContextMoveToPoint(context, end.x, end.y);
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawPointWithRedius:(CGFloat)redius andColor:(UIColor *)color andPoint:(CGPoint)p andContext:(CGContextRef)contex
{
    CGContextAddArc(contex, p.x, p.y, redius, 0, M_PI * 2, YES);
    [color setFill];
    CGContextDrawPath(contex, kCGPathFill);
}

- (CGFloat)getTextWidth:(UIFont *)font string:(NSString *)string
{
    if (!string.length) {
        return 0;
    }
    CGSize size = [string boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
    return ceil(size.width);
    //    return size.width;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
