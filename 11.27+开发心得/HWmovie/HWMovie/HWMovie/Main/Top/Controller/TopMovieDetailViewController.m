//
//  TopMovieDetailViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "TopMovieDetailViewController.h"
#import "DataService.h"
#import "common.h"
#import "TopCommentModal.h"
#import "TopMovieDetailTableViewCell.h"
#import "UIViewExt.h"
#import "TopheadModal.h"

@interface TopMovieDetailViewController ()
{
    CGFloat heights[100];
}

@end

@implementation TopMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"电影详情";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self _createCommentTableView];
    [self _createTopheadView];
    [self _loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MoviePlay:) name:@"MoviePlayer" object:nil];
}

- (void)MoviePlay:(NSNotification *)notification {
    MPMoviePlayerViewController *ctrl = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:notification.userInfo[@"urlStr"]]];
    [self presentMoviePlayerViewControllerAnimated:ctrl];
}

- (void)_loadData {
    _commentModalArray = [NSMutableArray array];
    NSDictionary *dic = [DataService getJsonDataFromFile:MovieCommentFile];
    NSArray *array = dic[@"list"];
    for (NSDictionary *dict in array) {
        TopCommentModal *modal = [[TopCommentModal alloc] init];
        [modal setValuesForKeysWithDictionary:dict];
        [_commentModalArray addObject:modal];
    }
//    NSLog(@"%ld",_commentModalArray.count);
    

    NSDictionary *dic1 = [DataService getJsonDataFromFile:MovieDetailFile];
    _modal1 = [[TopheadModal alloc] init];
    [_modal1 setValuesForKeysWithDictionary:dic1];
    _topheadView.modal = _modal1;
}

#pragma mark - CreateSubviews

- (void)_createTopheadView {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TopheadView" owner:self options:nil];
    _topheadView = [array lastObject];
    _topheadView.frame = CGRectMake(0, 64, kWidth, 300);
    
    [self.view addSubview:_topheadView];
}

- (void)_createCommentTableView {
    _commentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStylePlain];
    _commentTableView.backgroundColor = [UIColor grayColor];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self.view addSubview:_commentTableView];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)]; // 200+100
    header.backgroundColor = [UIColor clearColor];
//    TopheadView *header = [[TopheadView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 300)];
    _commentTableView.tableHeaderView = header;
    
    // 注册单元格
    UINib *nib = [UINib nibWithNibName:@"TopMovieDetailTableViewCell" bundle:[NSBundle mainBundle]];
    [_commentTableView registerNib:nib forCellReuseIdentifier:@"topMovieCommentCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commentModalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopMovieDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topMovieCommentCell" forIndexPath:indexPath];
    cell.topCommentModal = _commentModalArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (heights[indexPath.row] != 0) {
        return heights[indexPath.row];
    } else {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TopCommentModal *modal = _commentModalArray[indexPath.row];
    // 计算评论内容所占空间
    CGFloat maxLabelWidth = 275;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    CGSize contentSize = [modal.content boundingRectWithSize:CGSizeMake(maxLabelWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    for (NSInteger i = 0; i < _commentModalArray.count; i++) {
        heights[i] = 0;
    }
    heights[indexPath.row] = 80-29+contentSize.height+20;
    [tableView reloadData];
}

// 未选中的恢复默认单元格高度  未被调用
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
//    
//    NSLog(@"hhah");
//    heights[indexPath.row] = 0;
//    [tableView reloadData];
//}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offY = scrollView.contentOffset.y;
//    NSLog(@"%f",offY);
    _topheadView.top = -offY;
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
