//
//  XWVideoCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWVideoCell.h"

@interface XWVideoCell ()
@property (nonatomic,strong)NSUserDefaults *userinfo;

@property (weak, nonatomic) IBOutlet UIButton *playCount;

@property (weak, nonatomic) IBOutlet UILabel *videoSource;

@end

@implementation XWVideoCell

-(NSUserDefaults *)userinfo{
    if(!_userinfo){
        _userinfo=[NSUserDefaults standardUserDefaults];
    }
    return _userinfo;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    UIColor *color = CUSTOMCOLOR(170, 170, 170);
//    self.dk_backgroundColorPicker=DKColorPickerWithColors(WhiteColor,TVCBG,RedColor);
//    self.videoContent.dk_textColorPicker=DKColorPickerWithColors(BlackColor,WhiteColor,RedColor);
//    self.playCount.dk_textColorPicker=DKColorPickerWithColors(color,WhiteColor,RedColor);
//    self.lineView.dk_backgroundColorPicker=DKColorPickerWithColors(lineColor,CELLBG,RedColor);
    //创建播放视频的按钮
    UIButton *playBtn = [[UIButton alloc] init];
    self.videoImage.userInteractionEnabled = YES;
    [playBtn setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playerVideo:) forControlEvents:UIControlEventTouchDown];
    [self.videoImage addSubview:playBtn];
    // 设置按钮的约束
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.videoImage);
    }];
    
    self.videoImage.tag = 101;

}

- (void)setModel:(XWVideoModel *)model
{
    _model=model;
    
    //图片只显示中间区域
    [self.videoImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.videoImage.contentMode =  UIViewContentModeScaleAspectFill;
    self.videoImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.videoImage.clipsToBounds  = YES;
    
    [self.videoImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.videoContent.text = model.title;
    self.videoContent.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(15, 16, 17)];
    [self.playCount setTitle:[NSString stringWithFormat:@"%ld",model.play_count] forState:0];
    self.playTime.text=[NSString stringWithFormat:@"%02ld:%02ld",model.play_time/60,model.play_time%60];


}

-(void)playerVideo:(UIButton *)sender {
    JLLog(@"playerVideo");
    if (self.readlyPlayVideo) {
        self.readlyPlayVideo(sender);
    }
}





@end
