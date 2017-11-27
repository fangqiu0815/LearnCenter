//
//  CinemaViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "CinemaViewController.h"
#import "cinemaModal.h"
#import "districtModal.h"
#import "DataService.h"
#import "common.h"
#import "CinemaTableViewCell.h"

@interface CinemaViewController ()
{
    BOOL isOpen[20];
}

@end

@implementation CinemaViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"影院";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createTableView];
    [self _loadData];
}

- (void)_loadData {
//    _cinemaArray = [NSMutableArray array];
    _districtArray = [NSMutableArray array];
    _cinemaDictionary = [NSMutableDictionary dictionary];
    
    // 区
    NSDictionary *dic0 = [DataService getJsonDataFromFile:DistrictListFile];
    NSArray *districtList = dic0[@"districtList"];
    
    // 电影院
    NSDictionary *dic = [DataService getJsonDataFromFile:CinemaListFile];
    NSArray *cinemaList = dic[@"cinemaList"];
    
    for (NSDictionary *dict0 in districtList) {
        districtModal *modal0 = [[districtModal alloc] init];
        [modal0 setValuesForKeysWithDictionary:dict0];
        [_cinemaDictionary setValue:nil forKey:modal0.districtId];
        NSMutableArray *cArray = [NSMutableArray array];
        for (NSDictionary *dict in cinemaList) {
            cinemaModal *modal = [[cinemaModal alloc] init];
            [modal setValuesForKeysWithDictionary:dict];
            if ([modal.districtId isEqualToString:modal0.districtId]) {
                [cArray addObject:modal];
            }
            [_cinemaDictionary setValue:cArray forKey:modal0.districtId];
        }
        [_districtArray addObject:modal0];
//        NSLog(@"%@",_districtArray);
    }
//    NSLog(@"%ld",_districtArray.count);
}

- (void)_createTableView {
    _cinemaTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _cinemaTableView.delegate = self;
    _cinemaTableView.dataSource = self;
    _cinemaTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self.view addSubview:_cinemaTableView];
    
    // 注册
    UINib *nib = [UINib nibWithNibName:@"CinemaTableViewCell" bundle:[NSBundle mainBundle]];
    [_cinemaTableView registerNib:nib forCellReuseIdentifier:@"cinemaCell"];
}


#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _districtArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isOpen[section] == NO) {
        return 0;
    }
    districtModal *modal = _districtArray[section];
    NSString *str = modal.districtId;
    NSArray *array = _cinemaDictionary[str];
//    NSLog(@"%@",str);
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cinemaCell" forIndexPath:indexPath];
    districtModal *modal = _districtArray[indexPath.section];
    NSString *str = modal.districtId;
    NSArray *array = _cinemaDictionary[str];
    cell.cModal = array[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kWidth, 44)];
 //   button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hotMovieBottomImage@2x"]];
    button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginFrame@2x"]];
    [button setTitle:[_districtArray[section] name] forState:UIControlStateNormal ];
    button.tag = section;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside ];
    return button;
}

#pragma mark - Actions
- (void)buttonAction:(UIButton *)button {
    NSInteger index = button.tag;
    isOpen[index] = !isOpen[index];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
    [_cinemaTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
