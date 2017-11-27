//
//  PhotoViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/23.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "PhotoViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createCollectionView];
    [self _createNavBarItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAction) name:@"hideNavigationBarNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setImageUrlArray:(NSArray *)imageUrlArray {
//    self.imageUrlArray = imageUrlArray;  // 错误
//    _collectionView.imageUrlArray = imageUrlArray;
//}
- (void)setImageUrlArray:(NSArray *)imageUrlArray {
    _imageUrlArray = imageUrlArray;
    _collectionView.imageUrlArray = imageUrlArray; // 将数据传递到下层,加上保险，在当前代码没用
}

#pragma mark - createSubviews

- (void)_createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.view.bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 20;
    
    _collectionView = [[PhotoCollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth+20, kHeight) collectionViewLayout:layout];
    _collectionView.imageUrlArray = self.imageUrlArray;
    // 如果在前面直接赋值，调用的是set方法，没有生成collectionView，所以_collectionView.imageUrlArray仍然是nil，_imageUrlArray有值了
    // 如果赋值前先调用了这个create方法，生成collectionView，然后赋值调用set方法后全都有值了
    _collectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_collectionView];
    
    // 显示到指定的图片
    NSIndexPath *index = [NSIndexPath indexPathForItem:_currentIndex inSection:0];
    [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionLeft  animated:YES];
}

- (void)_createNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" 取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
}

#pragma mark - Actions

- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 接受到通知后的处理方法
- (void)hideAction {
    BOOL isHide = self.navigationController.navigationBar.isHidden;
    [self.navigationController setNavigationBarHidden:!isHide animated:YES];
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
