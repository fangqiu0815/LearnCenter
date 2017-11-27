//
//  ChooseCityViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 8/20/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "ChooseCityViewController.h"
#import "XDHeader.h"
#import "XDTools.h"

@interface ChooseCityViewController ()

@end

@implementation ChooseCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = self.titleString;
    
    dataArray = [[NSMutableArray alloc] init];
    [self createSeachViews];
    if([self.titleString isEqualToString:@"城市名称"]){
        [self createHotCityViews];
    }
}

#pragma mark
#pragma mark create UI
-(void)createSeachViews
{
    UIView * seachView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, UI_SCREEN_WIDTH, 40)];
    seachView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:seachView];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    line.backgroundColor =  UIColorFromRGB(0xcbcbcb);
    [seachView addSubview:line];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xcbcbcb);
    [seachView addSubview:line2];
    
    UIImageView * biaoshiImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 16.5, 16.5)];
    biaoshiImg.image = [UIImage imageNamed:@"search_ic"];
    [seachView addSubview:biaoshiImg];
    
    seachTF = [[UITextField alloc] initWithFrame:CGRectMake(36, 0, UI_SCREEN_WIDTH-36, 40)];
    seachTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    seachTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if ([self.titleString isEqualToString:@"城市名称"]){
        seachTF.placeholder = @"请输入城市名";
    }else{
        seachTF.placeholder = @"请输入学校名";
    }
    
    seachTF.font = [UIFont systemFontOfSize:14.5];
    seachTF.returnKeyType = UIReturnKeyDone;
    seachTF.delegate = self;
    [seachTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];

    [seachView addSubview:seachTF];
}

-(void)createHotCityViews
{
    hotCityView = [[UIView alloc] initWithFrame:CGRectMake(0,10+40, 320, 110+32)];
    hotCityView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:hotCityView];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    view.backgroundColor =BGCOLOR;
    [hotCityView addSubview:view];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 32)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = UIColorFromRGB(0x666666);
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"热门城市";
    [hotCityView addSubview:label];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,height_y(view), 320, 0.5)];
    line.backgroundColor =  UIColorFromRGB(0xcbcbcb);
    [hotCityView addSubview:line];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 109.5+32, 320, 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xcbcbcb);
    [hotCityView addSubview:line2];
    
    textArray = @[@[@{@"name":@"北京市",@"id":@"1001"},
                      @{@"name":@"天津市",@"id":@"2001"},
                      @{@"name":@"济南市",@"id":@"15001"},
                      @{@"name":@"日照市",@"id":@"15014"}
                      ],
                    @[@{@"name":@"上海市",@"id":@"9001"},
                      @{@"name":@"广州市",@"id":@"19001"},
                      @{@"name":@"深圳市",@"id":@"19004"},
                      @{@"name":@"成都市",@"id":@"24001"},
                      ],
                    @[@{@"name":@"西安市",@"id":@"4012"},
                      @{@"name":@"武汉市",@"id":@"17001"},
                      @{@"name":@"杭州市",@"id":@"11001"},
                      @{@"name":@"南京市",@"id":@"10001"},
                      ]
                    ];
    for (int i =0;i<3;i++){
        for (int j=0;j<4;j++){
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame= CGRectMake(16+(52.5+15)*j, height_y(line)+ 10+(23+10)*i, 52.5, 23);
            NSString * name =[[[textArray objectAtIndex:i] objectAtIndex:j] valueForKey:@"name"];
            
            [button setTitle:[name stringByReplacingOccurrencesOfString:@"市" withString:@""] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.5];
            button.tag = 1000+ i*10 +j;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColorFromRGB(0xcbcbcb) CGColor];
            [button setTitleColor:UIColorFromRGB(0x656565) forState:UIControlStateNormal];
            [button setTitleColor:UIColorFromRGB(0xef8b02) forState:UIControlStateDisabled];
            [button addTarget:self action:@selector(chooseHotCity:) forControlEvents:UIControlEventTouchUpInside];
            [hotCityView addSubview:button];
        }
    }
}

-(void)createTableViews
{
    myTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 10+40, UI_SCREEN_HEIGHT, self.contentView.frame.size.height-50) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [self.contentView addSubview:myTableView];
}

-(void)createNoDataViews
{
    DDLOG_CURRENT_METHOD;
    noDataViews = [[UIView alloc] initWithFrame:CGRectMake(0, 10+40, 320, 33)];
    noDataViews.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:noDataViews];
    UILabel * label = [[UILabel alloc] initWithFrame:noDataViews.bounds];
    label.textColor = UIColorFromRGB(0x666666);
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    if ([_titleString isEqualToString:@"城市名称"]){
        label.text = @"抱歉，没有找到相关城市";
    }else{
        label.text = @"抱歉,当地没有找到相关学校";
    }
    [noDataViews addSubview:label];
}

#pragma mark
#pragma mark UITextFeild Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [seachTF resignFirstResponder];
    return YES;
}

-(void)textFieldChange:(UITextField *)textField
{
    //匹配城市
    if (noDataViews){
        DDLOG(@"xy_textfield.text = %@",textField.text);
        noDataViews.hidden = YES;
    }
    if(IS_NOT_EMPTY(textField.text)){
        hotCityView.hidden = YES;
        if(myTableView == nil){
            [self createTableViews];
        }else{
            myTableView.hidden = NO;
        }
        //从数据库检索城市
        if ([self.titleString isEqualToString:@"城市名称"]){
            [self performSelector:@selector(matchingCity:) withObject:textField.text afterDelay:0.2f];
        }else{
            [self performSelector:@selector(matchingSchool:) withObject:textField.text afterDelay:0.2f];
        }
    }else{
        hotCityView.hidden = NO;
        if (myTableView){
            myTableView.hidden = YES;
            [dataArray removeAllObjects];
            [myTableView reloadData];
        }
    }
    
}

#pragma mark
#pragma mark UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.backgroundColor = [UIColor clearColor];
    }
    if ([dataArray count]==0){
        return nil;
    }
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DDLOG(@"cityName = %@ cityId = %@",[[dataArray objectAtIndex:indexPath.row] valueForKey:@"name"],[[dataArray objectAtIndex:indexPath.row] valueForKey:@"id"]);
    [_delegate chooseCityOrScholl:[dataArray objectAtIndex:indexPath.row] andTitle:_titleString];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark UIScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [seachTF resignFirstResponder];
}

//匹配城市
-(void)matchingCity:(NSString *)aCity
{
    [dataArray removeAllObjects];
    FMDatabase * db = [XDTools getDb];
    if (![db open]){
        DDLOG(@"open fail!");
        return;
    }
    NSString *queryString = @"SELECT * FROM T_P_CITY";

    FMResultSet * rs = [db executeQuery:queryString];
    while ([rs next]) {
        NSString * cityName = [rs objectForColumnName:@"CITY_NAME"];
        NSRange range = [cityName rangeOfString:aCity];
        if(range.location != NSNotFound){
            NSDictionary * dict = @{@"name":cityName,
                                    @"id":[rs objectForColumnName:@"CITY_ID"]};
            [dataArray addObject:dict];
        }
    }
    [db close];
    [myTableView reloadData];
    
    if([dataArray count]==0){
        myTableView.hidden = YES;
        
        if (noDataViews == nil){
            [self createNoDataViews];
        }
        noDataViews.hidden =NO;
    }
}

//匹配学校
-(void)matchingSchool:(NSString *)aSchool
{
    [dataArray removeAllObjects];
    FMDatabase * db = [XDTools getDb];
    if (![db open]){
        DDLOG(@"open fail!");
        return;
    }
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM T_P_COLLAGE WHERE CITY_CODE = %@",_cityId];
    
    FMResultSet * rs = [db executeQuery:queryString];
    while ([rs next]) {
        NSString * collageName = [rs objectForColumnName:@"COLLAGE_NAME"];
        NSRange range = [collageName rangeOfString:aSchool];
        if(range.location != NSNotFound){
            NSDictionary * dict = @{@"name":collageName,
                                    @"id":[rs objectForColumnName:@"COLLAGE_ID"]};
            [dataArray addObject:dict];
        }
    }
    [db close];
    [myTableView reloadData];
    
    if([dataArray count]==0){
        myTableView.hidden = YES;
        
        if (noDataViews == nil){
            [self createNoDataViews];
        }
        noDataViews.hidden =NO;
    }
}

-(void)chooseHotCity:(UIButton *)button
{
    for (UIButton * view in hotCityView.subviews){
        if ([view isKindOfClass:[UIButton class]]){
            if (button.tag == view.tag){
                button.enabled = NO;
                button.layer.borderColor = [UIColorFromRGB(0xef8b02) CGColor];
            }else{
                view.enabled = YES;
                view.layer.borderColor = [UIColorFromRGB(0xcbcbcb) CGColor];
            }
        }
    }
    
    int i = (button.tag -1000)/10;
    int j = (button.tag -1000)%10;
    [_delegate chooseCityOrScholl:[[textArray objectAtIndex:i] objectAtIndex:j] andTitle:@"城市名称"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
