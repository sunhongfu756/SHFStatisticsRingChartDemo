//
//  RingInstructionsCollectionViewCell.m
//  SHFStatisticsRingChartDemo
//
//  Created by sunhongfu on 2019/3/13.
//  Copyright © 2019 sunhongfu. All rights reserved.
//

#import "RingInstructionsCollectionViewCell.h"

@interface RingInstructionsCollectionViewCell ()

@property (nonatomic,strong) UIImageView *colorImgView;
@property (nonatomic,strong) UILabel *titleLabel;//显示标题(渠道名字/收入标题等)
@property (nonatomic,strong) UILabel *descriptionLabel;//显示数量或者钱
@property (nonatomic,strong) UILabel *percentageLabel;//显示百分比

@end

@implementation RingInstructionsCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#FBFDFF"];
        //        [self.contentView addSubview:self.customButton];
        [self createSubview];
    }
    return self;
}

- (void)createSubview
{
    [self.contentView addSubview:self.colorImgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.percentageLabel];
    [self.contentView addSubview:self.descriptionLabel];
}

- (void)setRingInstructionsListModel:(RingInstructionsListModel *)ringInstructionsListModel
{
    if (_ringInstructionsListModel != ringInstructionsListModel) {
        _ringInstructionsListModel = ringInstructionsListModel;
    }
    _colorImgView.backgroundColor = _ringInstructionsListModel.imgColor;
    _titleLabel.text = _ringInstructionsListModel.titleStr;
    _descriptionLabel.text = _ringInstructionsListModel.value;
    _percentageLabel.text = _ringInstructionsListModel.percentage;
    
    _titleLabel.width = [self getTextWidth:_titleLabel.font string:_titleLabel.text];
    _percentageLabel.frame = CGRectMake(self.contentView.frame.size.width - 24 - _ringInstructionsListModel.percentageWidth, _percentageLabel.top, _ringInstructionsListModel.percentageWidth, _percentageLabel.height);
    _descriptionLabel.frame = CGRectMake(self.titleLabel.right + 24, self.titleLabel.top, self.width - (self.titleLabel.right + 24) - 12 -  (self.width - _percentageLabel.left), self.titleLabel.height);
}

#pragma mark - Getter
- (UIImageView *)colorImgView
{
    if (!_colorImgView) {
        _colorImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 12, 12)];
        _colorImgView.backgroundColor = [UIColor blueColor];
    }
    return _colorImgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.colorImgView.right + 4, 0, 70, self.height)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#5D6572"];
//        _titleLabel.text = @"官网直销:";
//                _titleLabel.backgroundColor = [UIColor blueColor];
    }
    return _titleLabel;
}

- (UILabel *)percentageLabel
{
    if (!_percentageLabel) {
        _percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 24 - 38, self.titleLabel.top, 38, self.titleLabel.height)];
        _percentageLabel.textAlignment = NSTextAlignmentRight;
        _percentageLabel.font = [UIFont systemFontOfSize:12];
        _percentageLabel.textColor = [UIColor colorWithHexString:@"#5D6572"];
        _percentageLabel.text = @"0.00%";
        //        _percentageLabel.backgroundColor = [UIColor greenColor];
    }
    return _percentageLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right + 24, self.titleLabel.top, self.width - (self.titleLabel.right + 24) - 24 -  (self.width - _percentageLabel.left), self.titleLabel.height)];
        _descriptionLabel.textAlignment = NSTextAlignmentRight;
        _descriptionLabel.font = [UIFont systemFontOfSize:12];
        _descriptionLabel.textColor = [UIColor colorWithHexString:@"#5D6572"];
        _descriptionLabel.text = @"￥0.00";
        //        _descriptionLabel.backgroundColor = [UIColor yellowColor];
    }
    return _descriptionLabel;
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
@end
