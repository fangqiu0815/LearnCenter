//
//  XWJokeCommentCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/9.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWJokeCommentCell.h"
#import "XWJokeCell.h"
static NSString *cellID = @"XWJokeCommentCell";
#define iconH 100
#define iconW 100
#define padding 10

@interface XWJokeCommentCell ()
{
    MASConstraint *constraint_content;/**<内容上边距为5的约束,没内容时将边距设置为0 */
    MASConstraint *constraint_comment;
}

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UILabel *originLab;

@property (nonatomic, strong) UILabel *commentLab;



@end

@implementation XWJokeCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.originLab];
        [self.contentView addSubview:self.commentLab];
        
        [self setupUI];
    }
    return self;
}

//- (CGFloat)contentH
//{
//    if (!_contentH) {
//        CGSize textSize = [self sizeWithString:self.dataModel.content font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(ScreenW - padding, MAXFLOAT)];
//        
//        _contentH = textSize.height;
//    }
//    return _contentH;
//}
//
//- (CGFloat)commentH
//{
//    if (!_commentH) {
//        
//        CGSize textSize = [self sizeWithString:self.dataModel.pcont font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(ScreenW - 1.5*padding , MAXFLOAT)];
//        
//        _commentH = textSize.height;
//    }
//    return _commentH;
//}


- (void)setDataModel:(JokeData *)dataModel
{
    _dataModel = dataModel;
    [self.iconImageView setCircleHeader:[NSString stringWithFormat:@"http:%@",dataModel.img]];
    self.nameLab.text = dataModel.uname;
    self.contentLab.text = [NSString stringWithFormat:@"%@  \n    %@  %@",dataModel.content,dataModel.pname,dataModel.pcont];
    self.originLab.text = dataModel.origin;
//    self.commentLab.text = [NSString stringWithFormat:@"%@  %@",dataModel.pname,dataModel.pcont];
    
}

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}


- (void)setupUI
{
    WeakType(self);
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(padding*0.5);
        make.width.height.mas_equalTo(40);
        
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(padding);
        make.centerY.mas_equalTo(weakself.iconImageView.mas_centerY);
        make.right.mas_equalTo(weakself).offset(-padding);
        make.height.mas_equalTo(35);
    }];
    
    [_originLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself).offset(-0.5*padding);
        make.centerY.mas_equalTo(weakself.nameLab.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
//    [_commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakself.mas_right).offset(1.5*padding);
//        make.right.mas_equalTo(-1.5*padding);
//        make.bottom.mas_equalTo(-padding);
//    }];
//    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(padding);
        make.bottom.mas_equalTo(weakself).offset(-padding);
    }];
    
    
    
    
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += self.iconImageView.yj_height;
    totalHeight += [self.contentLab sizeThatFits:size].height;
    totalHeight += [self.commentLab sizeThatFits:size].height;
    totalHeight += 6*padding;
    return CGSizeMake(size.width, totalHeight);
}


- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        // _iconImageView.image = MyImage(@"czym");
        
    }
    return _iconImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        // _nameLab.text = @"haohaohaohao";
        _nameLab.textColor = BlackColor;
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        
    }
    return _nameLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        //  _contentLab.text = @"haohaohaohaohaoahaidahdkajbjkxzuhjkqnjkzhicuhqncjkzhciuahkcjnzjkxchiua";
        _contentLab.textColor = BlackColor;
        _contentLab.numberOfLines = 0;
        _contentLab.textAlignment = NSTextAlignmentLeft;
        _contentLab.font = [UIFont systemFontOfSize:15];
    }
    return _contentLab;
}

- (UILabel *)originLab
{
    if (!_originLab) {
        _originLab = [[UILabel alloc]init];
        _originLab.textColor = MainTextColor;
        _originLab.textAlignment = NSTextAlignmentRight;
        _originLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        
    }
    return _originLab;
}

- (UILabel *)commentLab
{
    if (!_commentLab) {
        _commentLab = [[UILabel alloc]init];
        _commentLab.textColor = BlackColor;
        _commentLab.numberOfLines = 0;
        _commentLab.textAlignment = NSTextAlignmentLeft;
        _commentLab.font = [UIFont systemFontOfSize:13];
        
    }
    return _commentLab;
}


@end

