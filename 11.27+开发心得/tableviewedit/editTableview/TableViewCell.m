//
//  TableViewCell.m
//  pod_test
//
//  Created by YY_ZYQ on 2017/6/24.
//  Copyright © 2017年 YY_ZYQ. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.label];
     

        
        
    }
    return self;
}

- (UILabel *)label{
    if (!_label) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, self.contentView.bounds.size.height)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:15];
        _label.backgroundColor = [UIColor clearColor];
        
    }
    return _label;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


//处理选中背景色问题
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (!self.editing) {
        return;
    }
    [super setSelected:selected animated:animated];
    
    if (self.editing) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.label.backgroundColor = [UIColor clearColor];
      
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    return;
}





@end
