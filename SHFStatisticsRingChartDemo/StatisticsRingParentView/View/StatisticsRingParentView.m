//
//  StatisticsRingParentView.m
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import "StatisticsRingParentView.h"
#import "StatisticsRingChartView.h"
#import "RingInstructionsListCollectionView.h"
#import "StatisticsDataModel.h"

@interface StatisticsRingParentView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) StatisticsRingChartView *ringChartView;

@property (nonatomic,strong) RingInstructionsListCollectionView *ringInstructionsListCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;;

@end

@implementation StatisticsRingParentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.ringChartView];
        [self addSubview:self.ringInstructionsListCollectionView];
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)setRingParentViewModel:(StatisticsRingParentViewModel *)ringParentViewModel
{
    //self.dataArray关于这个数组处理  如果视图不是放在tableview上 不涉及复用问题 就可以去掉  不需要关心
    if (_ringParentViewModel != ringParentViewModel) {
        _ringParentViewModel = ringParentViewModel;
        [self.dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:_ringParentViewModel.ringInstructionsListDataArray];
    }
    else
    {
        //为了不让重复赋值时候不停重绘环形图
        if (_dataArray.firstObject == ringParentViewModel.ringInstructionsListDataArray.firstObject)
        {
            return;
        }
        else
        {
            [self.dataArray removeAllObjects];
            [_dataArray addObjectsFromArray:ringParentViewModel.ringInstructionsListDataArray];
        }
    }
    NSMutableArray *titleArray = [NSMutableArray array];
    for (StatisticsDataModel *statisticsDataModel in ringParentViewModel.ringInstructionsListDataArray) {
        [titleArray addObject:statisticsDataModel.titleStr];
    }

    _titleLabel.text = ringParentViewModel.titleStr;
    
    if (_ringParentViewModel.valueDataArr.count) {
        _ringChartView.valueDataArr = _ringParentViewModel.valueDataArr;
        _ringChartView.valueDataTitlesArr = titleArray;
        _ringChartView.ringTitle = _ringParentViewModel.ringTitle;
        _ringChartView.ringDescription = _ringParentViewModel.ringDescription;
        _ringChartView.fillColorArray = _ringParentViewModel.colorsArray;
        [_ringChartView showAnimation];
        [_ringChartView setNeedsDisplay];
    }
    else
    {
    }
    
    _ringInstructionsListCollectionView.dataArray = _ringParentViewModel.ringInstructionsListDataArray;
    self.height = _ringInstructionsListCollectionView.bottom + 12;
}

#pragma mark - Getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, self.width - 2*12, 17 + 2*11)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom + 1, self.width, 1)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F3F5"];
    }
    
    return _lineView;
}

- (StatisticsRingChartView *)ringChartView
{
    if (!_ringChartView) {
//        _ringChartView = [[StatisticsRingChartView alloc] initWithFrame:CGRectMake((self.width-160)/2, self.lineView.bottom + 12, 160, 160)];
         _ringChartView = [[StatisticsRingChartView alloc] initWithFrame:CGRectMake(0, self.lineView.bottom + 12, self.width, 240)];
        _ringChartView.centerX = self.width/2;
//        _ringChartView.layer.borderColor = [UIColor blackColor].CGColor;
//        _ringChartView.layer.borderWidth = 1;
        _ringChartView.redius = (160-24*2)/2;
        _ringChartView.ringWidth = 24;
        
    }
    return _ringChartView;
}

- (RingInstructionsListCollectionView *)ringInstructionsListCollectionView
{
    if (!_ringInstructionsListCollectionView) {
        CGFloat height = 0;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _ringInstructionsListCollectionView = [[RingInstructionsListCollectionView alloc] initWithFrame:CGRectMake(12, self.ringChartView.bottom + 24, self.width - 2*12, height) collectionViewLayout:layout];
    }
    return _ringInstructionsListCollectionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
