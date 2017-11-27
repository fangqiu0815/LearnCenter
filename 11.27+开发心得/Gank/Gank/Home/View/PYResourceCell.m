//
//  PYResourceCell.m
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYResourceCell.h"
#import <PYPhotoBrowser/PYPhotoBrowser.h>
#import "PYResource.h"
#import "PYImage.h"
@implementation PYResourceCell

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.py_y = 20;
        titleLabel.py_x = 20;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (PYPhotosView *)photosView
{
    if (!_photosView) {
        PYPhotosView *photosView = [[PYPhotosView alloc] init];
        [self addSubview:photosView];
        _photosView = photosView;
    }
    return _photosView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    PYResourceCell *cell = [[PYResourceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PYResourceCellID"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.py_width = tableView.py_width;
    cell.titleLabel.py_width = cell.py_width - 2 *  cell.titleLabel.py_x;
    cell.photosView.py_x = cell.titleLabel.py_x;
    cell.photosView.showDuration = 0.25;
    cell.photosView.hiddenDuration = 0.15;
    cell.photosView.autoRotateImage = NO;
    return cell;
}

- (void)setResource:(PYResource *)resource
{
    _resource = resource;
    
    // 设置标题
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (@%@)", resource.desc, resource.who];
    NSMutableArray *thumbUrlM = [NSMutableArray array]; // 缩略图
    NSMutableArray *urlM = [NSMutableArray array]; // 浏览时的图片
    for (int i = 0; i < resource.imageModels.count; i++) {
        PYImage *imageModel = resource.imageModels[i];
        if (imageModel.width > 0) { // 取到图片的宽高
            // 取出图片个数
            NSInteger imageCount = resource.imageModels.count;
            if (imageCount == 1) {
                self.photosView.py_width = (PYScreenW - 60);
                self.photosView.py_height = imageModel.height / imageModel.width * self.photosView.py_width;
            } else if (imageCount > 1) {
               self.photosView.photoHeight = self.photosView.photoWidth = (PYScreenW - 60 - (imageCount - 1) * PYPhotoMargin) / imageCount;
            }
        } else { // 未能获取图片大小。默认 宽 == 高
            self.photosView.py_height = self.photosView.py_width = (PYScreenW - 60);
        }
        [urlM addObject:imageModel.url];
        [thumbUrlM addObject:imageModel.thumbUrl];
    }
    
    // 设置图片
    self.photosView.thumbnailUrls = thumbUrlM;
    self.photosView.originalUrls = urlM;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.photosView.py_y = CGRectGetMaxY(self.titleLabel.frame) + 10;
    self.photosView.py_x = self.titleLabel.py_x;
}

@end
