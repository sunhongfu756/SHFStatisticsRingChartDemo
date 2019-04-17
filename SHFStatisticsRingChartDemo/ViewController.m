//
//  ViewController.m
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import "ViewController.h"
#import "StatisticsRingParentView.h"
#import "StatisticsRingParentViewModel.h"

@interface ViewController ()
@property (nonatomic,strong) StatisticsRingParentView *ringparentView;
@property (nonatomic,strong) NSArray *ringColorsArray;
@property (nonatomic,strong) StatisticsRingParentViewModel *statisticsRingParentViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.ringparentView];
    [self getDataSources];
    self.ringparentView.ringParentViewModel = self.statisticsRingParentViewModel;
}

- (void)getDataSources
{
    /*环形图数组色值*/
    self.ringColorsArray = @[[UIColor colorWithHexString:@"#5E99FF"],[UIColor colorWithHexString:@"#FFAD49"],[UIColor colorWithHexString:@"#4EBAD1"],[UIColor colorWithHexString:@"#BCD665"],[UIColor colorWithHexString:@"#C492F8"],[UIColor colorWithHexString:@"#FFC784"],[UIColor colorWithHexString:@"#67AB6A"],[UIColor colorWithHexString:@"#8D76F0"],[UIColor colorWithHexString:@"#FF6B6B"],[UIColor colorWithHexString:@"#5671AF"],[UIColor colorWithHexString:@"#FFEB3B"]];
    
    self.statisticsRingParentViewModel = [[StatisticsRingParentViewModel alloc] init];
    _statisticsRingParentViewModel.titleStr = @"数据来源";
    _statisticsRingParentViewModel.ringDescription = @"数量(单)";
    _statisticsRingParentViewModel.valueDataArr = [NSMutableArray array];
    _statisticsRingParentViewModel.colorsArray = self.ringColorsArray;
    NSMutableArray *dataArray = [self getRingInstructionsListModel];
    _statisticsRingParentViewModel.ringInstructionsListDataArray = dataArray;
    CGFloat total = 0;
    for (RingInstructionsListModel *model in dataArray) {
        total += [model.value floatValue];
    }
    _statisticsRingParentViewModel.ringTitle = [NSString stringWithFormat:@"%.0f",total];
    //第一个是百分比最大的  所有的都以最大的为标准 如果数据没排序 需要自己先排序
    RingInstructionsListModel *maxModel = dataArray.firstObject;
    CGFloat percentageWidth = [self getTextWidth:[UIFont systemFontOfSize:12] string:[NSString stringWithFormat:@"%.2f%c",([maxModel.value integerValue] / total * 100),'%']] + 2;
    
    for (RingInstructionsListModel *model in dataArray) {
        NSInteger index = [dataArray indexOfObject:model];
        model.imgColor = self.ringColorsArray[index];
        model.percentage = [NSString stringWithFormat:@"%.2f%c",([model.value floatValue] / total * 100),'%'];
        if ([model.value floatValue] > 0) {
            [_statisticsRingParentViewModel.valueDataArr addObject:model.value];
        }
        model.percentageWidth = percentageWidth;
    }
}

- (NSMutableArray *)getRingInstructionsListModel
{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *titleArray = @[@"携程",@"去哪",@"散户",@"美团",@"百度"];
    NSArray *valueArray = @[@"35",@"22",@"18",@"10",@"6"];
    for (int i = 0; i < titleArray.count; i++) {
        RingInstructionsListModel *model = [[RingInstructionsListModel alloc] init];
        model.titleStr = titleArray[i];
        model.value = valueArray[i];
        [dataArray addObject:model];
    }
    return dataArray;
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

#pragma mark - Getter
- (StatisticsRingParentView *)ringparentView
{
    if (!_ringparentView) {
        //        _ringparentView = [[StatisticsRingParentView alloc] initWithFrame:CGRectMake(12, 12, SCREEN_WIDTH - 2*12, 54+160 + (24+0+12))];
        _ringparentView = [[StatisticsRingParentView alloc] initWithFrame:CGRectMake(12, 100, SCREEN_WIDTH - 2*12, 54+160 + (24+0+12))];
        _ringparentView.layer.cornerRadius = 4;
        _ringparentView.layer.borderColor = [UIColor colorWithHexString:@"#000000" andAlpha:0.08].CGColor;
        _ringparentView.layer.borderWidth = 1;
        _ringparentView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" andAlpha:1];
    }
    return _ringparentView;
}


@end
