//
//  ViewController.m
//  demo
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "ViewController.h"
#import "TYAttributedLabel.h"
#import "RegexKitLite.h"
#import "SearchVC.h"
#import "SGAdvertScrollView.h"
#import "OtherVC.h"
#import "CMPopTipView.h"
#import "UIImage+CH.h"


#define RGB(r,g,b,a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ViewController ()
<TYAttributedLabelDelegate,UITableViewDelegate,UITableViewDataSource,CMPopTipViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    int _tempW;
    int _tempCZW;
}
@property (nonatomic,strong) UIButton *tempCZBtn;

@property (nonatomic,weak) TYAttributedLabel *label1;
@property (nonatomic,weak) TYAttributedLabel *label2;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) SGAdvertScrollView *advertScrollViewBottom;
@property (nonatomic,strong) UICollectionView     *collectionView;

@property (nonatomic,strong) CMPopTipView *popTipView;
@property (nonatomic,strong) NSMutableArray	      *visiblePopTipViews; //!< 可见的PopView
@property (nonatomic,strong) id				      currentPopTipViewTarget;  //!< 当前的按钮


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (IBAction)click:(id)sender {
    CMPopTipView *popView;

    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW*0.85, 150)];
    popView = [[CMPopTipView alloc] initWithCustomView:bgview];
    self.popTipView = popView;
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"不感兴趣" forState:0];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:0];
    [rightBtn setBackgroundColor:[UIColor redColor]];
    [rightBtn addTarget:self action:@selector(dismissAllPopTipViews) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = 15;
    [bgview addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"不感兴趣的理由";
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = [UIFont systemFontOfSize:15];
    [bgview addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(rightBtn.mas_centerY);
    }];
    
    NSArray *array = @[@"内容重复，旧闻",@"内容质量差",@"来源：TX新闻"];
    _tempCZW = 0;
    for (int i = 1; i <= array.count; i++) {
        int dx = 1;
        int dy = i/2-1;
        
        if(i %2 != 0){ //奇数  左边
            _tempCZW = 0;
            dx = 0;
            dy = i/2;
        }
        
        CGFloat btnX = 10 + dx*20 +_tempCZW;
        CGFloat btnY = dy*50 + 50;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btnX, btnY, (ScreenW*0.8 - 40)/2, 35);
        [button setTitle:array[i-1] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(touchClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15;
        button.layer.borderColor = CUSTOMCOLOR(226, 226, 226).CGColor;
        button.layer.borderWidth = 0.5;
        _tempCZW += button.frame.size.width;

        [bgview addSubview:button];
        
    }
    
    popView.delegate = self;
    popView.cornerRadius = 5;
    popView.backgroundColor = [UIColor whiteColor];
//    popView.textColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    // 0是Slide  1是pop  2是Fade但是有问题，用前两个就好了
    popView.animation = 1;
    popView.preferredPointDirection = PointDirectionAny;
    // 立体效果，默认是YES
    popView.has3DStyle = NO;
    popView.borderColor = [UIColor whiteColor];
    // 是否点击任意位子就影藏
    popView.dismissTapAnywhere = YES;
    // 是否自定影藏
    //[popView autoDismissAnimated:YES atTimeInterval:5.0];
//    [UIView animateWithDuration: 0.25 animations:^{
//        self.view.alpha = 0.6;
//        self.popTipView.alpha = 1;
//    }];
    
    [popView presentPointingAtView:sender inView:self.view animated:YES];
    [self.visiblePopTipViews addObject:popView];
    self.currentPopTipViewTarget = sender;
    
    
}

- (void)touchClick:(UIButton *)sender
{
//    if (sender!= self.tempCZBtn) {
//        self.tempCZBtn.selected = NO;
//        sender.selected = YES;
//        self.tempCZBtn = sender;
//        
//    }else{
//        self.tempCZBtn.selected = YES;
//        
//    }

    sender.selected = !sender.selected;
    
}


// 点击的时候取消PopView
- (void)dismissAllPopTipViews
{
    [self.popTipView dismissAnimated:YES];
    [self.visiblePopTipViews removeObjectAtIndex:0];
    
//    [UIView animateWithDuration:0.25 animations:^{
//        self.view.alpha = 1;
//    }];
}
// PopView的代理，当Pop消失的时候调用
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self dismissAllPopTipViews];
    self.currentPopTipViewTarget = nil;
    NSLog(@"消失了");
    self.popTipView = nil;
}

// 默认值
//- (id)initWithFrame:(CGRect)frame
//{
//    if ((self = [super initWithFrame:frame])) {
//        // Initialization code
//        self.opaque = NO;
//
//        _topMargin = 2.0;
//        _pointerSize = 12.0;
//        _sidePadding = 2.0;
//        _borderWidth = 1.0;
//
//        self.textFont = [UIFont boldSystemFontOfSize:14.0];
//        self.textColor = [UIColor whiteColor];
//        self.textAlignment = NSTextAlignmentCenter;
//        self.backgroundColor = [UIColor colorWithRed:62.0/255.0 green:60.0/255.0 blue:154.0/255.0 alpha:1.0];
//        self.has3DStyle = YES;
//        self.borderColor = [UIColor blackColor];
//        self.hasShadow = YES;
//        self.animation = CMPopTipAnimationSlide;
//        self.dismissTapAnywhere = NO;
//        self.preferredPointDirection = PointDirectionAny;
//        self.hasGradientBackground = YES;
//        self.cornerRadius = 10.0;
//    }
//    return self;
//}











- (void)test5{
    [self configUI];
}


- (void)configUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 180;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"QWERTY"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)test4
{
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, ScreenW, 120)];
    [self.view addSubview:centerView];
    
    NSArray *array = @[@"牛海龙：2小时前，充值了100元手机话费！",
                       @"晶晶妹：2小时前，充值了50元手机话费！",
                       @"楼广明：2小时前，充值了100元手机话费！",
                       @"花开花落：2小时前，充值了100元手机话费！",
                       @"谢诗颖：2小时前，充值了100元手机话费！",
                       @"娟：2小时前，充值了100元手机话费！"];
    NSArray *imageArr = @[@"haha",@"haha",@"haha",@"haha",@"haha",@"haha"];
    
    _advertScrollViewBottom = [[SGAdvertScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
    _advertScrollViewBottom.backgroundColor = [UIColor redColor];
    _advertScrollViewBottom.advertScrollViewStyle = SGAdvertScrollViewStyleMore;
    _advertScrollViewBottom.topTitles = array;
    _advertScrollViewBottom.bottomTitles = array;
    _advertScrollViewBottom.topSignImages = imageArr;
    _advertScrollViewBottom.bottomSignImages = imageArr;
    [centerView addSubview:_advertScrollViewBottom];

}

- (void)test3
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:@"推荐",
                               @"娱乐",
                               @"科技",
                               @"财经",
                               @"历史",
                               @"搞笑", nil];
    
    //    [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        if ([obj isEqualToString:@"推荐"]) {
    //            [tempArr removeObject:obj];
    //        }
    //    }];
    //    NSLog(@"%@",tempArr);
    
    
    
    
    NSArray *array = [NSArray arrayWithObjects:@"wendy",@"andy",@"tom",@"test", nil];
    
    NSIndexSet *se = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, tempArr.count-2)];
    
    NSArray *test = [tempArr objectsAtIndexes:se];
    NSLog(@"%@",test);

}

- (void)test2{
    NSString *str = @"13385927820",*str1,*str2,*str3;
    
    str1 = [str substringToIndex:3];
    
    str2 = [str substringWithRange:NSMakeRange(3, 4)];
    
    str3 = [str substringWithRange:NSMakeRange(7, 4)];
    //
    str = [NSString stringWithFormat:@"%@ %@ %@",str1,str2,str3];
    //    NSString *string = @"13385927820";
    //    string = [string substringToIndex:7];//截取掉下标7之后的字符串
    //    NSLog(@"截取的值为：%@",string);
    //    string = [string substringWithRange:NSMakeRange(3, 4)];//截取掉下标2之前的字符串
    
    
    
    
    NSLog(@"str = %@ ",str);
}


- (void)test1
{
    UIButton *buttom = [[UIButton alloc]initWithFrame:CGRectMake(120, 120, 100, 50)];
    
    [buttom setTitle:@"去搜索" forState:0];
    [buttom setBackgroundColor:[UIColor redColor]];
    [buttom addTarget:self action:@selector(gotoSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom];
}

- (void)gotoSearch:(id)sender
{
    SearchVC *searchVC = [[SearchVC alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}


- (void)setupTableview
{


}



//如何裁剪带二维码的公众号图片
- (void)HowToTailorOneQRCodePic
{
    UIImage *image = [UIImage imageNamed:@"1.png"];
    CGImageRef imageRef = image.CGImage;
    CGRect rect = CGRectMake(170, 170, 91, 91);
    CGImageRef image1 = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage *newImage = [[UIImage alloc] initWithCGImage:image1];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.image = newImage;
    [self.view addSubview:imageView];
}


//- (void)addScrollView
//{
//    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:scrollView];
//    _scrollView = scrollView;
//}
//
//// appendAttributedText
//- (void)addTextAttributedLabel1
//{
//    TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
//    label.delegate = self;
//    [_scrollView addSubview:label];
//    _label1 = label;
//    
//    NSString *text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。\n\t但这个过程会很痛，会很辛苦，有时候还会觉得灰心。\n\t面对着汹涌而来的现实，觉得自己渺小无力。\n\t但这，也是生命的一部分，做好现在你能做的，然后，一切都会好的。\n\t我们都将孤独地长大，不要害怕。";
//    
//    // 分割文本到数组
//    NSArray *textArray = [text componentsSeparatedByString:@"\n\t"];
//    NSArray *colorArray = @[RGB(213, 0, 0, 1),RGB(0, 155, 0, 1),RGB(103, 0, 207, 1),RGB(209, 162, 74, 1),RGB(206, 39, 206, 1)];
//    
//    NSInteger index = 0;
//    
//    // 追加 图片Url
//    TYImageStorage *imageUrlStorage = [[TYImageStorage alloc]init];
//    imageUrlStorage.imageURL = [NSURL URLWithString:@"http://imgbdb2.bendibao.com/beijing/201310/21/2013102114858726.jpg"];
//    imageUrlStorage.size = CGSizeMake(CGRectGetWidth(label.frame), 343*CGRectGetWidth(label.frame)/600);
//    [label appendTextStorage:imageUrlStorage];
//    
//    for (NSString *text in textArray) {
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
//        
//        if (index != 4) {
//            // 添加属性
//            [attributedString addAttributeTextColor:colorArray[index%5]];
//            [attributedString addAttributeFont:[UIFont systemFontOfSize:15+arc4random()%4]];
//            
//            // 追加(添加到最后)文本
//            [label appendTextAttributedString:attributedString];
//            [label appendImageWithName:@"haha"];
//            [label appendText:@"\n\t"];
//        } else {
//            [label appendImageWithName:@"avatar" size:CGSizeMake(60, 60)];
//            [label appendText:text];
//        }
//        index++;
//    }
//    //两种方法 [label appendImageWithName:@"avatar" size:CGSizeMake(60, 60)];
//    TYImageStorage *imageStorage = [[TYImageStorage alloc]init];
//    imageStorage.imageName = @"haha";
//    imageStorage.size = CGSizeMake(15, 15);
//    [label appendTextStorage:imageStorage];
//    
//    [label appendText:@"image左对齐"];
//    TYImageStorage *imageStorageAlignLeft = [[TYImageStorage alloc]init];
//    imageStorageAlignLeft.imageName = @"CYLoLi";
//    imageStorageAlignLeft.imageAlignment = TYImageAlignmentLeft;
//    imageStorageAlignLeft.size = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
//    [label appendTextStorage:imageStorageAlignLeft];
//    
//    [label appendText:@"image居中对齐"];
//    TYImageStorage *imageStorageAlignCenter = [[TYImageStorage alloc]init];
//    imageStorageAlignCenter.imageName = @"CYLoLi";
//    imageStorageAlignCenter.imageAlignment = TYImageAlignmentCenter;
//    imageStorageAlignCenter.size = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
//    [label appendTextStorage:imageStorageAlignCenter];
//    
//    [label appendText:@"image右对齐"];
//    TYImageStorage *imageStorageAlignRight = [[TYImageStorage alloc]init];
//    imageStorageAlignRight.imageName = @"CYLoLi";
//    imageStorageAlignRight.imageAlignment = TYImageAlignmentRight;
//    imageStorageAlignRight.size = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
//    [label appendTextStorage:imageStorageAlignRight];
//    
//    [label appendText:@"image铺满"];
//    TYImageStorage *imageStorageAlignFill = [[TYImageStorage alloc]init];
//    imageStorageAlignFill.imageName = @"CYLoLi";
//    imageStorageAlignFill.imageAlignment = TYImageAlignmentFill;
//    imageStorageAlignFill.size = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
//    [label appendTextStorage:imageStorageAlignFill];
//    
//    [label sizeToFit];
//}
//
//// addAttributedText
//- (void)addTextAttributedLabel2
//{
//    //使用 RegexKitLite，添加 -fno-objc-arc，同时添加 libicucore.dylib
//    //其实所有漂泊的人，不过是为了有一天能够不再漂泊，能用自己的力量撑起身后的家人和自己爱的人。
//    TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_label1.frame) + 20, CGRectGetWidth(self.view.frame), 0)];
//    [_scrollView addSubview:label];
//    label.delegate = self;
//    NSString *text = [NSString stringWithFormat:@"[CYLoLi,%d,180]其实所有漂泊的人，[haha,15,15]不过是为了有一天能够不再[CYLoLi,%d,90]漂泊，[haha,15,15]能用自己的力量撑起身后的家人和自己爱的人。[avatar,60,60]",(int)CGRectGetWidth(self.view.frame),(int)CGRectGetWidth(self.view.frame)/2];
//    
//    // 属性文本生成器
//    TYTextContainer *attStringCreater = [[TYTextContainer alloc]init];
//    attStringCreater.text = text;
//    NSMutableArray *tmpArray = [NSMutableArray array];
//    
//    // 正则匹配图片信息
//    [text enumerateStringsMatchedByRegex:@"\\[(\\w+?),(\\d+?),(\\d+?)\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//        
//        if (captureCount > 3) {
//            // 图片信息储存
//            TYImageStorage *imageStorage = [[TYImageStorage alloc]init];
//            imageStorage.imageName = capturedStrings[1];
//            imageStorage.range = capturedRanges[0];
//            imageStorage.size = CGSizeMake([capturedStrings[2]intValue], [capturedStrings[3]intValue]);
//            
//            [tmpArray addObject:imageStorage];
//        }
//    }];
//    
//    // 添加图片信息数组到label
//    [attStringCreater addTextStorageArray:tmpArray];
//    
//    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
//    textStorage.range = [text rangeOfString:@"[CYLoLi,320,180]其实所有漂泊的人，"];
//    textStorage.textColor = RGB(213, 0, 0, 1);
//    textStorage.font = [UIFont systemFontOfSize:16];
//    [attStringCreater addTextStorage:textStorage];
//    
//    textStorage = [[TYTextStorage alloc]init];
//    textStorage.range = [text rangeOfString:@"不过是为了有一天能够不再漂泊，"];
//    textStorage.textColor = RGB(0, 155, 0, 1);
//    textStorage.font = [UIFont systemFontOfSize:18];
//    [attStringCreater addTextStorage:textStorage];
//    
//    [attStringCreater createTextContainerWithTextWidth:CGRectGetWidth(self.view.frame)];
//    
//    [label setTextContainer:attStringCreater];
//    
//    [label sizeToFit];
//    
//    _label2 = label;
//    
//    [_scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(label.frame)+10)];
//}
//
//#pragma mark - deleagte
//
//- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point
//{
//    NSLog(@"textStorageClickedAtPoint");
//}
//
//- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageLongPressed:(id<TYTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
//{
//    NSLog(@"textStorageLongPressed");
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






















@end
