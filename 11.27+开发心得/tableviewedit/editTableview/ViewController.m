//
//  ViewController.m
//  pod_test
//
//  Created by YY_ZYQ on 2017/5/17.
//  Copyright © 2017年 YY_ZYQ. All rights reserved.
//

#import "ViewController.h"
#import "BottomView.h"
#import "TableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;//数据源
@property (nonatomic ,strong) NSMutableArray *deleteArray;//删除的数据
@property (nonatomic ,strong) UIButton *btn;//编辑按钮
@property (nonatomic ,assign) BOOL isInsertEdit;//tableview编辑方式的判断
@property (nonatomic ,strong) BottomView *bottom_view;//底部视图

@end

@implementation ViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)deleteArray{
    if (!_deleteArray) {
        self.deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}

- (BottomView *)bottom_view{
    if (!_bottom_view) {
        self.bottom_view = [[BottomView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 50)];
        _bottom_view.backgroundColor = [UIColor yellowColor];
        [_bottom_view.deleteBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
        [_bottom_view.allBtn addTarget:self action:@selector(tapAllBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottom_view;
}


- (UIButton *)btn{
    if (!_btn) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(0, 0, 50, 44);
        [_btn setTitle:@"编辑" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;//处理tablevie下移64
    self.title = @"消息中心";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cells"];
    [self.view addSubview:self.tableView];
    _isInsertEdit = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btn];
    //获取数据
    [self getTableviewData];

}



/**
 删除数据方法
 */
- (void)deleteData{
    if (self.deleteArray.count >0) {
        [self.dataArray removeObjectsInArray:self.deleteArray];
        [self.tableView reloadData];
    }
    
}

- (void)getTableviewData{
    //拟造数据，此数据需要从服务器获取
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    //添加到数据源中
    [self.dataArray addObjectsFromArray:array];
    [self.tableView reloadData];
}

- (void)tapBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
    //点击编辑的时候清空删除数组
        [self.deleteArray removeAllObjects];
        [_btn setTitle:@"完成" forState:UIControlStateNormal];
        _isInsertEdit = YES;//这个时候是全选模式
        [_tableView setEditing:YES animated:YES];
        
        //如果在全选状态下，点击完成，再次进来的时候需要改变按钮的文字和点击状态
        if (_bottom_view.allBtn.selected) {
            _bottom_view.allBtn.selected = !_bottom_view.allBtn.selected;
            [_bottom_view.allBtn setTitle:@"全选" forState:UIControlStateNormal];
        }
        
            //添加底部视图
        CGRect frame = self.bottom_view.frame;
            frame.origin.y -= 50;
            [UIView animateWithDuration:0.5 animations:^{
                self.bottom_view.frame = frame;
                [self.view addSubview:self.bottom_view];
            }];
        
        
    }else{
        [_btn setTitle:@"编辑" forState:UIControlStateNormal];
        _isInsertEdit = NO;
        [_tableView setEditing:NO animated:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint point = self.bottom_view.center;
            point.y      += 50;
            self.bottom_view.center   = point;
            
        } completion:^(BOOL finished) {
            [self.bottom_view removeFromSuperview];
        }];
    }
}


- (void)tapAllBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;

    if (btn.selected) {
        
        for (int i = 0; i< self.dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            //全选实现方法
            [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        }
        
        //点击全选的时候需要清除deleteArray里面的数据，防止deleteArray里面的数据和列表数据不一致
        if (self.deleteArray.count >0) {
            [self.deleteArray removeAllObjects];
        }
        [self.deleteArray addObjectsFromArray:self.dataArray];
        
        [btn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        
        //取消选中
        for (int i = 0; i< self.dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [_tableView deselectRowAtIndexPath:indexPath animated:NO];
            
        }
        
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        [self.deleteArray removeAllObjects];
    }
  
  
//    NSLog(@"+++++%ld",self.deleteArray.count);
//    NSLog(@"===%@",self.deleteArray);
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
    cell.label.text = self.dataArray[indexPath.row];
    
    //处理选中背景色问题
    UIView *backGroundView = [[UIView alloc]init];
    backGroundView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = backGroundView;

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //根据不同状态返回不同编辑模式
    if (_isInsertEdit) {
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //左滑删除数据方法
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //正常状态下，点击cell进入跳转下一页
    //在编辑模式下点击cell 是选中数据
    if (self.btn.selected) {
         NSLog(@"选中");
        [self.deleteArray addObject:[self.dataArray objectAtIndex:indexPath.row]];

    }else{
        NSLog(@"跳转下一页");
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (self.btn.selected) {
        NSLog(@"撤销");
        [self.deleteArray removeObject:[self.dataArray objectAtIndex:indexPath.row]];
        
    }else{
        NSLog(@"取消跳转");
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
