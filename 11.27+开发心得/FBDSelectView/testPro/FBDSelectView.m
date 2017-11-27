//
//  FBDSelectView.m
//  testPro
//
//  Created by 冯宝东 on 16/1/22.
//  Copyright © 2016年 冯宝东. All rights reserved.
//
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif


#import "FBDSelectView.h"
#define OneNumber   999
#define openTableViewHeight  260
#define everyItemWidthScrollAble  100

@implementation FBDSelectView
{
    NSInteger parentIndex;
    NSInteger currentIndex;
  
    UITableView*selectTableView;
    CGFloat begainHeight;
    NSMutableArray*itemArray;
    UIScrollView* bgScrollView;
    

}
@synthesize isopen=_isopen;
static NSString* indetifer;
-(instancetype)initWithFrame:(CGRect)frame  withTitles:(NSMutableArray*)titleArray withBound:(BOOL)scrollAble
{

    static NSString* indetifer=@"selectCell";
    self=[super initWithFrame:frame];
    if (self&&!scrollAble)
    {
        NSLog(@"unable");
        NSInteger number=titleArray.count;
        parentIndex=0;
        begainHeight=frame.size.height;
        float everyItemWidth =ScreenW/number;
        itemArray=[NSMutableArray array];
        
        for (int i=0; i<number; i++)
        {
            CGRect everyCGRect=CGRectMake(i*everyItemWidth, 0, everyItemWidth, frame.size.height);
            SelectItemView*everyItem=[[SelectItemView alloc] initWithFrame:everyCGRect];
            everyItem.backgroundColor=[[self class] randomColor];
            everyItem.mSelect_label.text=[titleArray objectAtIndex:i];
            everyItem.tag=OneNumber+i;
            UITapGestureRecognizer*everyTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
            [everyItem addGestureRecognizer:everyTap];
            [self addSubview:everyItem];
            [itemArray addObject:everyItem];
            
          
        }
        selectTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, frame.size.height, ScreenW, 0) style:UITableViewStylePlain];
        selectTableView.delegate=self;
        selectTableView.dataSource=self;
        [selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:indetifer];
        [self addSubview:selectTableView];
        
        _blackAlphaView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
        _blackAlphaView.backgroundColor=[UIColor blackColor];
        _blackAlphaView.alpha=0.3;
        
        UITapGestureRecognizer*tapBGGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTopBlackAlphaView:)];
        tapBGGesture.numberOfTapsRequired=1;
        [_blackAlphaView addGestureRecognizer:tapBGGesture];
        [self performSelector:@selector(moveToSuperView:) withObject:_blackAlphaView afterDelay:0.1];
        
        
        return self;
    }else if (self&&scrollAble) // 能够滑动的视图
    {
        
        
        NSLog(@"neng");
        bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
       [self addSubview:bgScrollView];

        NSInteger number=titleArray.count;
        bgScrollView.contentSize=CGSizeMake(everyItemWidthScrollAble*number, 0);
        parentIndex=0;
        begainHeight=frame.size.height;
        itemArray=[NSMutableArray array];
        
        for (int i=0; i<number; i++)
        {
            CGRect everyCGRect=CGRectMake(i*everyItemWidthScrollAble, 0, everyItemWidthScrollAble, frame.size.height);
            SelectItemView*everyItem=[[SelectItemView alloc] initWithFrame:everyCGRect];
            everyItem.backgroundColor=[[self class] randomColor];
            everyItem.mSelect_label.text=[titleArray objectAtIndex:i];
            everyItem.tag=OneNumber+i;
            UITapGestureRecognizer*everyTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
            [everyItem addGestureRecognizer:everyTap];
            [bgScrollView addSubview:everyItem];
            [itemArray addObject:everyItem];
            
            
        }
        selectTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, frame.size.height, ScreenW, 0) style:UITableViewStylePlain];
        selectTableView.delegate=self;
        selectTableView.dataSource=self;
        [selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:indetifer];
        [self addSubview:selectTableView];
        
        _blackAlphaView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
        _blackAlphaView.backgroundColor=[UIColor blackColor];
        _blackAlphaView.alpha=0.3;
        
        UITapGestureRecognizer*tapBGGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTopBlackAlphaView:)];
        tapBGGesture.numberOfTapsRequired=1;
        [_blackAlphaView addGestureRecognizer:tapBGGesture];
        [self performSelector:@selector(moveToSuperView:) withObject:_blackAlphaView afterDelay:0.1];
        

        
        
        
        
        
        
        
        
        
    }



    return self;
}

-(instancetype)initWithFrame:(CGRect)frame  withTitles:(NSMutableArray*)titleArray withBound:(BOOL)scrollAble selectItemBlock:(selectItemBlock)comeBlock
{
    self=[self initWithFrame:frame  withTitles:titleArray withBound:scrollAble];
    self.userSelectBlock=comeBlock;
    return self;
}






-(void)moveToSuperView:(UIView*)sender
{
    if (self.superview)
    {
        [self.superview insertSubview:sender belowSubview:self];
    }

}

-(void)removeTopBlackAlphaView:(UITapGestureRecognizer*)sender
{

    self.isopen=NO;

}





-(void)tapPressed:(UITapGestureRecognizer*)sender
{
 
    SelectItemView* tapSelcetView=(SelectItemView*)sender.view;
       [self  everyButtonPressed:tapSelcetView];
    currentIndex=tapSelcetView.tag-OneNumber;
    if ((tapSelcetView.tag==parentIndex))
    {
        
        self.isopen= !self.isopen;
        NSLog(@"点击了相同的item 多次了   打开的状态:%d",self.isopen);
        
        return;
    }else{
       
      parentIndex=tapSelcetView.tag;
      self.isopen=YES;
      NSLog(@"  tap 的 view的tag 值：%ld   索引是：%ld  打开的状态:%d",tapSelcetView.tag,tapSelcetView.tag-OneNumber,        self.isopen);
        
    
        //点击不同的 item  需 userSelectBlock 进行回调处理
        if (self.userSelectBlock)
        {
            self.userSelectBlock(tapSelcetView.tag-OneNumber);
        }
    
    }
    
}

-(void)setListArray:(NSMutableArray *)listArray
{
    _listArray=listArray;
    [selectTableView reloadData];
}
-(void)setIsopen:(BOOL)isopen
{
    _isopen=isopen;
    if (isopen)
    {
        
        
       
        [self openTableView];

        
        
        
    }else
    {
        [self closeTableView];
    
    }

}

-(void)openTableView
{   NSLog(@"将要 打开");

    for (SelectItemView *everyItemView in itemArray)
    {
        [everyItemView resumeBackStatus];
    }
    
    SelectItemView* currentItemView= [itemArray objectAtIndex:currentIndex];
    [currentItemView changeSelectedStatus];
    
    [UIView animateWithDuration:0.2 animations:^{
        selectTableView.frame=CGRectMake(0, begainHeight, ScreenW, openTableViewHeight);
        CGRect selfCGRect=self.frame;
        selfCGRect.size.height=openTableViewHeight;
        self.frame=selfCGRect;
        [self layoutSubviews];
        _blackAlphaView.frame=[UIScreen mainScreen].bounds;
        
    }];

}
-(void)closeTableView
{

    
    SelectItemView* currentItemView= [itemArray objectAtIndex:currentIndex];
    
    [currentItemView resumeBackStatus];
    NSLog(@"将要 关闭");
    [UIView animateWithDuration:0.5 animations:^{
        
        selectTableView.frame=CGRectMake(0, begainHeight, ScreenW, 0);
        CGRect selfCGRect=self.frame;
        selfCGRect.size.height=begainHeight;
        self.frame=selfCGRect;
        [self layoutSubviews];
        CGRect mainCGRect=[UIScreen mainScreen].bounds;
        mainCGRect.size.height=0;
        _blackAlphaView.frame=mainCGRect;
        
    }];
    
}





#pragma mark --UITableViewDelegte & UITableViewDataSourece
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    indetifer=@"selectCell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:indetifer];
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    cell.textLabel.text=[_listArray objectAtIndex:indexPath.row];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.isopen=NO;
    if (self.userSelectSamllBlock)
    {
        self.userSelectSamllBlock(indexPath.row);
    }

    
    
}


/**
 *  随即色
 *
 *  @return 颜色实例
 */
+(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}




-(void)everyButtonPressed:(UIButton*)sender
{
    NSLog(@" NSStringFromCGRect : %@",NSStringFromCGRect(sender.frame));
    CGFloat originX=sender.frame.origin.x;
    CGFloat standerOffset=originX-ScreenW/2.0+30;
    CGFloat maxOffset= bgScrollView.contentSize.width-ScreenW;
    
    CGFloat shouldOffset=standerOffset;
    if (standerOffset<0)
    {
        shouldOffset=0;
    }
    if (standerOffset>maxOffset)
    {
        shouldOffset=maxOffset;
    }
    [UIView animateWithDuration:0.2 animations:^{
    bgScrollView.contentOffset=CGPointMake(shouldOffset, 0);    
    }];

    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


#define selectImageW  10
@implementation SelectItemView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
    
    self.mSelect_label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    self.mSelect_label.text=@"待定";
    self.mSelect_label.font=[UIFont systemFontOfSize:15];
    self.mSelect_label.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_mSelect_label];
    
    self.mSelect_imageView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)-selectImageW, CGRectGetMinY(frame), selectImageW/2, selectImageW/2)];
    
    self.mSelect_imageView.center=CGPointMake(CGRectGetWidth(frame)-(selectImageW/2.0), CGRectGetMidY(frame));
        
    self.mSelect_imageView.backgroundColor=[UIColor blackColor];
        
    [self addSubview:_mSelect_imageView];
        
        
        
    }
    return self;
}

//选中的状态
-(void)changeSelectedStatus
{
    _mSelect_label.textColor=[UIColor  redColor];
    _mSelect_imageView.backgroundColor=[UIColor redColor];
    

    
}
//恢复到原始的状态
-(void)resumeBackStatus
{

    _mSelect_label.textColor=[UIColor  blackColor];
    _mSelect_imageView.backgroundColor=[UIColor blackColor];
    

}




@end







