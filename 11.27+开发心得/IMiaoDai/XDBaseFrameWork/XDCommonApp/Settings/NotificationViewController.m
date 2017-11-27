//
//  NotificationViewController.m
//  XDCommonApp
//
//  Created by wanglong8889@126.com on 14-6-13.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()
{
    int count;
}
@end

@implementation NotificationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"上传文件";
    [self initNoticeViews];
    
    // Do any additional setup after loading the view.
}
-(void)initNoticeViews{
    
    
    count = 0;
    for (int i = 0; i<4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
        [imageArr addObject:image];
        
    }
    
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 50, 80, 100)];
    imageView.backgroundColor = [UIColor blueColor];
    
    
    prgressLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 170, 100, 20)];
    prgressLabel.font = [UIFont systemFontOfSize:15.0];
    prgressLabel.backgroundColor = [UIColor clearColor];
    
    prgressLabel.text = @"0/4";
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:prgressLabel];
    
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"开始上传" forState:UIControlStateNormal];
    [rightButton setTintColor:[UIColor whiteColor]];
    [rightButton setFrame:CGRectMake(520/2.0f, 13+aHeight, 60, 25)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(beginUpload) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationBarView addSubview:rightButton];
    
    
   self.circularPV = [[FFCircularProgressView alloc] initWithFrame:CGRectMake(190, 50, 80, 80)];
    
    [self.contentView addSubview:_circularPV];
    
    midProfressView = [[UIProgressView alloc]initWithFrame:CGRectMake(50, 300, 200, 15)];
    [midProfressView addObserver:self forKeyPath:@"progress" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:@"progressValueKVO"];
    
    [self.contentView addSubview:midProfressView];
    
    
    
    //set CircularProgressView delegate
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    self.circularPV.progress = midProfressView.progress;
}

-(void)beginUpload{
    [self upLoadProfiles];
}

-(void)upLoadProfiles{
     [_circularPV startSpinProgressBackgroundLayer];
    
    if (count>=[imageArr count]) {
        [_circularPV stopSpinProgressBackgroundLayer];
        return;
    }
    __weak ASIFormDataRequest *request  = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://bbs.chinapet.com/plugin.php?id=leepet_thread:api&action=newattachment"]];
   
    UIImage *image = [imageArr objectAtIndex:count];
    imageView.image = image;
    
    prgressLabel.text = [NSString stringWithFormat:@"%d/%d",count+1,imageArr.count];
    
    
    NSData *imageData = UIImageJPEGRepresentation(image,1.0);
    
    NSString *photoName=[NSString stringWithFormat:@"%@.jpeg",[self dateString]];
//
    [request addData:imageData withFileName:photoName andContentType:@"image/jpeg" forKey:@"Filedata"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:12];
    [request setRequestCookies:[XDTools productCookies]];
    [request setUseCookiePersistence:NO];
    [request setUploadProgressDelegate:midProfressView];
    
    [request setCompletionBlock:^{
        
        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
        DDLOG(@"temdic == %@",tempDic);
        if ([[tempDic objectForKey:@"result"] intValue] == 0) {
            count++;
            [_circularPV setProgress:0.0];
            [self upLoadProfiles];
        }
       
    }];
    
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}





-(NSString *)dateString
{
    return [NSString stringWithFormat:@"%d", [[NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]] intValue]];
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
