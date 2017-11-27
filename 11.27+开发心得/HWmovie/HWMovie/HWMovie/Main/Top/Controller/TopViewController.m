//
//  TopViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "TopViewController.h"
#import "TopModal.h"
#import "DataService.h"
#import "TopCollectionViewCell.h"
#import "common.h"
#import "TopMovieDetailViewController.h"
#import "HttpDataService.h"

@interface TopViewController ()

@end

@implementation TopViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"TOP250";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createCollectionView];
//    [self _loadTopData];
    [self _loadTopDataHttp];
}

- (void)_loadTopData {
    _topMessageArray = [NSMutableArray array];
    NSDictionary *dic = [DataService getJsonDataFromFile:@"top250.json"];
    NSArray *subjects = dic[@"subjects"];
    for (NSDictionary *dict in subjects) {
        TopModal *modal = [[TopModal alloc] init];
        [modal setValuesForKeysWithDictionary:dict];
        modal.average = [dict[@"rating"][@"average"] floatValue];
        [_topMessageArray addObject:modal];
    }
//    NSLog(@"%@",_topMessageArray);
}

- (void)_loadTopDataHttp {
    
    __block TopViewController *this = self;
    [HttpDataService requestAFUrl:TOP250 httpMethod:@"GET" params:nil data:nil block:^(id result) {
        
        this->_topMessageArray = [NSMutableArray array];
        NSDictionary *dic = result;
        NSArray *subjects = dic[@"subjects"];
        for (NSDictionary *dict in subjects) {
            TopModal *modal = [[TopModal alloc] init];
            [modal setValuesForKeysWithDictionary:dict];
            modal.average = [dict[@"rating"][@"average"] floatValue];
            [this->_topMessageArray addObject:modal];
        }
//         NSLog(@"%@",_topMessageArray);
        [this->_topCollectionView reloadData];
        
    }];
    
}

- (void)_createCollectionView {
    UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc] init];
    lay.minimumLineSpacing = 0; // 最小行间距
    lay.minimumInteritemSpacing = 0;
    _topCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:lay];
    _topCollectionView.dataSource = self;
    _topCollectionView.delegate = self;
    [self.view addSubview:_topCollectionView];
     _topCollectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    
    // 注册单元项
    UINib *nib = [UINib nibWithNibName:@"TopCollectionViewCell" bundle:[NSBundle mainBundle]];
    [_topCollectionView registerNib:nib forCellWithReuseIdentifier:@"topCollection"];
}

#pragma mark - collectionViewDataSourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"%ld",_topMessageArray.count);
    return _topMessageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCollection" forIndexPath:indexPath];
    cell.topMessage = _topMessageArray[indexPath.row];
    
    return cell;
}

#pragma mark - collectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize laySize = CGSizeMake(kWidth/3.5, 165);
    return laySize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TopMovieDetailViewController *vc2 = [[TopMovieDetailViewController alloc] init];
    
    [self.navigationController pushViewController:vc2 animated:YES];
    
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.tabBarController.tabBar.hidden = NO;
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
