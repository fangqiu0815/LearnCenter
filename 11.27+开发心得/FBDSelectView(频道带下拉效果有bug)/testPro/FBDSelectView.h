//
//  FBDSelectView.h
//  testPro
//
//  Created by 冯宝东 on 16/1/22.
//  Copyright © 2016年 冯宝东. All rights reserved.
//  fix APP的名字


// 测试  fengbaodong  风暴送烦恼

#define ScreenW     [UIScreen mainScreen].bounds.size.width
#define ScreenH    [UIScreen mainScreen].bounds.size.height
#import <UIKit/UIKit.h>

typedef void(^selectItemBlock)(NSInteger indexItem);

@interface FBDSelectView : UIView<UITableViewDataSource,
UITableViewDelegate>
@property (nonatomic,assign) BOOL isopen;
@property (nonatomic,strong)NSMutableArray*listArray;
@property (nonatomic,copy) selectItemBlock userSelectBlock;
@property (nonatomic,copy) selectItemBlock userSelectSamllBlock;
@property (nonatomic,strong)UIView* blackAlphaView;
/**
 *  FBDSelect构造函数
 *
 *  @param frame  大小
 *  @param number item的个数
 *  @param scrollAble 能否滑动
 *  @return 返回的实例
 */
-(instancetype)initWithFrame:(CGRect)frame  withTitles:(NSMutableArray*)titleArray withBound:(BOOL)scrollAble;
/**
 *  FBDSelect构造函数
 *
 *  @param frame  大小
 *  @param number item的个数
 *  @param scrollAble 能否滑动
 *  @param comeBlock selectBlock的回调
 *
 *  @return 返回的实例
 */
-(instancetype)initWithFrame:(CGRect)frame  withTitles:(NSMutableArray*)titleArray withBound:(BOOL)scrollAble selectItemBlock:(selectItemBlock)comeBlock;



@end

@interface SelectItemView : UIView
@property (nonatomic,strong)UIImageView*mSelect_imageView;
@property (nonatomic,strong)UILabel*mSelect_label;

//选中的状态
-(void)changeSelectedStatus;


//恢复到原始的状态
-(void)resumeBackStatus;


@end




