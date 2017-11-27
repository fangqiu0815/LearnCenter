//
//  OrderListCell.m
//  XDCommonApp
//
//  Created by xindao on 14-8-11.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "OrderListCell.h"
#import "UIImageView+WebCache.h"
@implementation OrderListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)getDataWithDict:(NSDictionary *)dict{

    if(dict){

        [self.headIv setImageWithURL:[NSURL URLWithString:dict[@"pic"]] placeholderImage:[UIImage imageNamed:@"headerPlaceholder"]];

        self.goodsTitleLB.frame = CGRectMake(78, 10, 220, 40);
        self.goodsTitleLB.text = dict[@"productName"];
        [self.goodsTitleLB sizeToFit];
        if (self.goodsTitleLB.frame.size.height > 40) {
            self.goodsTitleLB.frame = CGRectMake(78, 10, 220, 40);
        }
        self.goodsTitleLB.textColor = UIColorFromRGB(0x363636);

        self.canshuLB.text = dict[@"tag"];
        self.canshuLB.textColor = UIColorFromRGB(0x686868);

        self.bianhaoLB.text = dict[@"orderId"];
        self.bianhaoLB.textColor = UIColorFromRGB(0x686868);


        NSString * shoufu = [NSString stringWithFormat:@"%@",dict[@"payment"][@"shoufu"]];
        NSString * fenqi = [NSString stringWithFormat:@"%@",dict[@"payment"][@"paymentId"]];
        NSString * yuegong = [NSString stringWithFormat:@"%d",[dict[@"payment"][@"yuefu"] intValue]/100];
        self.fenqiLB.text = [NSString stringWithFormat:@"分期:%@首付,分%@期,月供%@元",shoufu,fenqi,yuegong];
        self.fenqiLB.textColor = UIColorFromRGB(0x686868);
        self.fenqiLB.attributedText = [XDTools getAcolorfulStringWithTextArray:@[shoufu,fenqi,yuegong] Color:UIColorFromRGB(0xfa8800) Font:[UIFont systemFontOfSize:14] AllText:self.fenqiLB.text];

        NSArray * statusArray1 = @[@"订单未审核",@"审核通过",@"审核中",@"审核中",@"",@"",@"审核中",@"审核未通过",@"",@"订单关闭"];
//        NSArray * statusArray2 = @[@"商家已发货",@"已签收",@"订单取消"];


        if ([dict[@"status"] isEqualToString:@"B"] || [dict[@"status"] isEqualToString:@"D"]) {
            self.statusLB.text = @"状态:商家已发货";
        }else if ([dict[@"status"] isEqualToString:@"E"]) {
            self.statusLB.text = @"状态:已签收";
        }else if ([dict[@"status"] isEqualToString:@"C"]) {
            self.statusLB.text = @"状态:订单取消";
        }else if ([dict[@"status"] isEqualToString:@"F"]) {
            self.statusLB.text = @"状态:退货";
        }else if ([dict[@"status"] isEqualToString:@"A"]) {
            self.statusLB.text = @"状态:审核通过";
        }else{
            if ([dict[@"status"] intValue] < 10) {
                self.statusLB.text = [NSString stringWithFormat:@"状态:%@",statusArray1[[dict[@"status"] intValue]]];
            }

        }

        [self.checkGoodsBtn.titleLabel setBackgroundColor:[UIColor clearColor]];
        if ([dict[@"status"] isEqualToString:@"B"] || [dict[@"status"] isEqualToString:@"D"]) {
            self.checkGoodsBtn.hidden = NO;
            [self.checkGoodsBtn setTitle:@"确认签收" forState:UIControlStateNormal];
        }else if ([dict[@"status"] isEqualToString:@"0"] || [dict[@"status"] isEqualToString:@"6"] || [dict[@"status"] isEqualToString:@"2"] || [dict[@"status"] isEqualToString:@"3"]) {
            self.checkGoodsBtn.hidden = NO;
            [self.checkGoodsBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        }else{
            self.checkGoodsBtn.hidden = YES;
        }

        if ([dict[@"status"] isEqualToString:@"1"] || [dict[@"status"] isEqualToString:@"B"] || [dict[@"status"] isEqualToString:@"E"] || [dict[@"status"] isEqualToString:@"A"] || [dict[@"status"] isEqualToString:@"D"]) {
            self.statusLB.textColor = UIColorFromRGB(0x079937);
        }else{
            self.statusLB.textColor = UIColorFromRGB(0xd10000);
        }
        self.statusLB.attributedText = [XDTools getAcolorfulStringWithText1:@"状态:" Color1:UIColorFromRGB(0x686868) Font1:[UIFont systemFontOfSize:14] Text2:nil Color2:nil Font2:nil AllText:self.statusLB.text];



        NSMutableString * timeStr = [NSMutableString stringWithFormat:@"%@",dict[@"createTime"]];
        [timeStr insertString:@"-" atIndex:4];
        [timeStr insertString:@"-" atIndex:7];
        [timeStr deleteCharactersInRange:NSMakeRange(10, 6)];



        self.timeLB.text = timeStr;
        //[[dict[@"createTime"] componentsSeparatedByString:@" "] firstObject];
        self.timeLB.textColor = UIColorFromRGB(0x686868);


    }

    if ([dict[@"status"] intValue] == 7) {
        self.contentView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 245);

        UIView * bg = [[UIView alloc] initWithFrame:CGRectMake(0, 205, UI_SCREEN_WIDTH, 40)];
        bg.backgroundColor = UIColorFromRGB(0xffffcd);
        [self.contentView addSubview:bg];

        UILabel * tishi = [XDTools addAlabelForAView:bg withText:@"喵，您的申请资料审核未通过，我们将派出校园代理为您解决。或请联系喵贷客服：400-096-0036" frame:CGRectMake(10,0,300,40) font:[UIFont systemFontOfSize:13] textColor:UIColorFromRGB(0xbf0905)];
        tishi.numberOfLines = 2;
    }

    self.firstLine.frame = CGRectMake(0, 0, 320, .5f);
    self.scondLine.frame = CGRectMake(0, 75, 320, .5f);
    self.thirdLine.frame = CGRectMake(0, 115, 320, .5f);
    self.fourthLine.frame = CGRectMake(0, 155, 320, .5f);
    self.fifthLine.frame = CGRectMake(0, 194.5f, 320, .5f);


}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
