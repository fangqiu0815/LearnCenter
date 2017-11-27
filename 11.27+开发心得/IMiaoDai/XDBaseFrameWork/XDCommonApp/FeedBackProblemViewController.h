//
//  FeedBackProblemViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-15.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@interface FeedBackProblemViewController : XDBaseViewController<UIScrollViewDelegate,UITextViewDelegate,UITextViewDelegate>
{
    UIView * kindView;
    UITextView * inputView;
    BOOL isClicked;
    UIScrollView * myScrollView;
    UIView * topView;

    UILabel * placeHolderLB;
}

@end
