//
//  ImageNewsViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "ImageNewsViewController.h"
#import "common.h"
#import "ImageNewsModal.h"
#import "DataService.h"
#import "ImageNewsCollectionViewCell.h"
#import "PhotoViewController.h"
#import "BaseNavigationController.h"

@interface ImageNewsViewController ()

@end

@implementation ImageNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createCollectionView];
    [self _loadData];
    
}

- (void)_loadData {
    _imageModalArray = [NSMutableArray array];
    NSArray *array = [DataService getJsonDataFromFile:ImageListFile];
    for (NSDictionary *dict in array) {
        ImageNewsModal *modal = [[ImageNewsModal alloc] init];
        [modal setValuesForKeysWithDictionary:dict];
        [_imageModalArray addObject:modal];
//        NSLog(@"%@",modal);
    }
//    NSLog(@"%@",_imageModalArray);
}

- (void)_createCollectionView {
    UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc] init];
    lay.itemSize = CGSizeMake((kWidth-50)/4, (kWidth-50)/4*1.2);
    _imageCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:lay];
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    
    [self.view addSubview:_imageCollectionView];
    
    // 注册项目
    [_imageCollectionView registerClass:[ImageNewsCollectionViewCell class] forCellWithReuseIdentifier:@"imageNewsCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageModalArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageNewsCell" forIndexPath:indexPath];
    cell.imageModal = _imageModalArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 8, 5, 8);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoViewController *pvc = [[PhotoViewController alloc] init];

    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:pvc];
    
    // 抽离url
    NSMutableArray *imageUrlArray = [[NSMutableArray alloc] init];
    for (ImageNewsModal *modal in _imageModalArray) {
        [imageUrlArray addObject:modal.image];
    }
//    pvc.view.backgroundColor = [UIColor redColor];  //在pvc.imageUrlArray = imageUrlArray;前先调用到话，没有赋值，跳转到指定图片无法进行,会崩
    pvc.currentIndex = indexPath.row;
    pvc.imageUrlArray = imageUrlArray;
//    pvc.view.backgroundColor = [UIColor redColor];
    [self presentViewController:nav animated:YES completion:nil];
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
