//
//  ViewController.m
//  testPro
//
//  Created by 冯宝东 on 16/1/15.
//  Copyright © 2016年 冯宝东. All rights reserved.
//

#import "ViewController.h"
#import "FBDSelectView.h"
#import "FBDItemScrollVIew.h"
#import "MJRefresh/MJRefresh.h"
#import "UIView+FBDQuickCreateUI.h"

@interface ViewController ()
{
    UIButton*btn;
    UIControl* testControl;
    UILabel*myLabel;
    UITextField*myTF;
    FBDSelectView*testSelectV;
    NSMutableArray*allListArray;
    NSInteger  user_section;
    NSInteger user_row;
    FBDItemScrollVIew*myItemScrollView;

}
@end

@implementation ViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.backgroundColor=[UIColor whiteColor];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    __weak typeof(ViewController*)weakself=self;
    testSelectV=[[FBDSelectView alloc]initWithFrame:CGRectMake(0, 20, ScreenW, 45) withTitles:[NSMutableArray arrayWithObjects:@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"花生",@"奶酪",@"大米",@"萝卜", nil] withBound:YES  selectItemBlock:^(NSInteger indexItem) {
        NSLog(@"block 的index 为：%ld",indexItem);
        [weakself selectViewOfListArrayIndex:indexItem];
    }];
   
    
    __weak typeof(FBDSelectView*)weaktestSelectV= testSelectV;
    testSelectV.userSelectSamllBlock=^(NSInteger smallIndex){
        
        NSLog(@"选中的是小项目中的  第%ld个 子项目   名字：%@",smallIndex, [weaktestSelectV.listArray objectAtIndex:smallIndex]);
    
    
    };
    
    
    
    
    allListArray=[NSMutableArray arrayWithObjects:@[@"111",@"222",@"333"],@[@"444",@"555",@"666"],@[@"777",@"88",@"999"],@[@"000",@"333",@"555"],@[@"145",@"33",@"666"],@[@"111",@"222",@"333"],@[@"444",@"555",@"666"],@[@"777",@"88",@"999"],@[@"777",@"88",@"999"],nil];
       [self.view addSubview:testSelectV];
    
    [self performSelector:@selector(fuck) withObject:nil afterDelay:20];
//    NSMutableArray*titleArray=[NSMutableArray arrayWithObjects:@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜",@"土豆",@"白菜",@"番茄",@"果冻",@"西瓜", nil];
//  
//    

//    
//    myItemScrollView=[[FBDItemScrollVIew alloc] initWithFrame:CGRectMake(0, 300, ScreenW, 700) andItemTitleArray:titleArray];
//    myItemScrollView.showsVerticalScrollIndicator=NO;
//
//    [self.view addSubview:myItemScrollView];
//


}
-(void)fuck
{
    
//    CGFloat allHeight=[self.view viewHeightByAllSubView];
//    [self.view setView_sizeHeight:allHeight];
//    NSLog(@"输出view的 X:%f Y:%f Width:%f  height %f  allHeight:%f",    [self.view view_orignX],      [self.view view_orignY],   [self.view view_sizeWidth] ,  [self.view view_sizeHeight],allHeight);
//    self.view.backgroundColor=[UIColor greenColor];

    [testSelectV removeFromSuperview];
    testSelectV=nil;
    

}
-(void)selectViewOfListArrayIndex:(NSInteger)index
{
    testSelectV.listArray=[allListArray objectAtIndex:index];


}





-(void)testUIControl
{
    testControl=[[UIControl alloc] initWithFrame:CGRectMake(100, 100, 20, 200)];
    myLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 120)];
    myLabel.backgroundColor=[UIColor grayColor];
    myLabel.text=@"这\n是\n音\n量\n条";
    myLabel.numberOfLines=0;
    [testControl addSubview:myLabel];
    testControl.backgroundColor=[UIColor redColor];
    testControl.enabled=YES;
    [testControl addTarget:self action:@selector(voicePressed:) forControlEvents:UIControlEventValueChanged];
    testControl.contentVerticalAlignment=2;
    testControl.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;;
    //    [testControl sendActionsForControlEvents:UIControlEventValueChanged];
    //   [testControl sendAction:@selector(voicePressed:) to:self forEvent:<#(nullable UIEvent *)#>];
    [self.view addSubview:testControl];

}
-(void)voicePressed:(id)sender
{

    
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{





}



//- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
//{
//    return YES;
//
//}
//- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
//{
//    return YES;
//
//}
//- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event
//{
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
