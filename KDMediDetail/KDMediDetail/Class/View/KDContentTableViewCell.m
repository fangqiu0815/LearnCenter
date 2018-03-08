//
//  KDContentTableViewCell.m
//  KDMediDetail
//
//  Created by apple-gaofangqiu on 2018/3/5.
//  Copyright © 2018年 apple-fangqiu. All rights reserved.
//

#import "KDContentTableViewCell.h"

@interface KDContentTableViewCell()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *showMoreButton;
// 记录button初始的frame
@property (nonatomic, assign) CGRect btnOriFrame;

@end

static const CGFloat kBlankLength = 10;

@implementation KDContentTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBlankLength, kBlankLength, SCREEN_WIDTH-kBlankLength*2, 100)];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.contentLabel];
        
        self.showMoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.showMoreButton setTitle:@"更多" forState:UIControlStateNormal];
        [self.showMoreButton addTarget:self
                                action:@selector(showMoreOrLessContent)
                      forControlEvents:UIControlEventTouchUpInside];
        [self.showMoreButton sizeToFit];
        CGFloat unFoldButtonX = SCREEN_WIDTH - kBlankLength - self.showMoreButton.yj_width;
        CGFloat unFoldButtonY = kBlankLength * 2 + self.contentLabel.yj_height;
        CGRect buttonFrame = self.showMoreButton.frame;
        buttonFrame.origin.x = unFoldButtonX;
        buttonFrame.origin.y = unFoldButtonY;
        self.showMoreButton.frame = buttonFrame;
        self.btnOriFrame = buttonFrame;
        [self.contentView addSubview:self.showMoreButton];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isShowMoreContent) {
        // 计算文本高度
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
        CGSize size = [self.mediaContentStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kBlankLength*2, 1000) options:option attributes:attribute context:nil].size;
        
        self.contentLabel.frame = CGRectMake(kBlankLength, kBlankLength, SCREEN_WIDTH-kBlankLength*2, size.height+20);
        
        CGFloat buttonMoreContentY = kBlankLength * 2 + self.contentLabel.yj_height;
        CGRect buttonMoreContentRect = self.btnOriFrame;
        buttonMoreContentRect.origin.y = buttonMoreContentY;
        self.showMoreButton.frame = buttonMoreContentRect;
        [self.showMoreButton setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        self.contentLabel.frame = CGRectMake(kBlankLength, kBlankLength, SCREEN_WIDTH-kBlankLength*2, 100);
        self.showMoreButton.frame = self.btnOriFrame;
        [self.showMoreButton setTitle:@"全文" forState:UIControlStateNormal];
    }
}

- (void)showMoreOrLessContent {
    if (self.showMoreContentBlock) {
        self.showMoreContentBlock(self.indexPath);
    }
}


- (void)setMediaContentStr:(NSString *)mediaContentStr
{
    self.contentLabel.text = mediaContentStr;
    _mediaContentStr = mediaContentStr;
}

+ (CGFloat)cellDefaultHeight {
    return 160;
}

+ (CGFloat)cellMoreHeight:(NSString *)cellStr{
    // 计算文本高度
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [cellStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kBlankLength*2, 1000) options:option attributes:attribute context:nil].size;
    return size.height + 80;
}



@end
