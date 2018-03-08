//
//  ViewController.m
//  Test
//
//  Created by apple-gaofangqiu on 2017/10/13.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "ViewController.h"
#import "KDHttpRequest.h"
#import "NSString+FCSecurity.h"


@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController




- (IBAction)Click:(id)sender {
    
    
//    [KDHttpRequest requestWithRequesturl:@"http://api.kuaileduobao.com/supermarket/aes.php" headerSign:nil httpMethod:GET paramters:@{@"name":@"alex",@"age":@(11)} blockCompletion:^(id  _Nullable responseObject) {
//
//
//    } withError:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSError *underError = error.userInfo[@"NSUnderlyingError"];
//        NSData *responseData = underError.userInfo[@"com.alamofire.serialization.response.error.data"];
//        NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",result);
//        self.label.text = [NSString stringWithFormat:@"%@",result];
//    }];

    NSString *md5Str = [NSString stringWithFormat:@"%@",[KDJiaMiObject md5:@""]];
    NSLog(@"%@",md5Str);
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *jsonResult = [@"EWWqEbI/lUONu30xyiizHTWKd+zook2ZL1Y5sC9VWF/IuD37A7fodQwaY/FoPE069M9FqUmR9RhNcAb9kaMTK1d4UetjrNP22hRDhsbkmY5828BODhmKwlVhWioyqg94K5WAgZYSCZF6ESAuWp0zNTQMtiNr22ukxHVme/NEMJphfAtG/MS0rRohz70kBOLV8diq42V1okKd5VY7HAvrUofkjWl1TuSVMU3KJwVVBmITy8P8Fm8TU9nN4U78Y2xkD+smYYv5xCh8zczrPI9I1/2Q5ijMKNcH5bKK7RB/20qOOp13l763yMRtpkLEzPdgGQmJSQayYt7XjTxwNeFQNU8KPWX/RKJ6540shtMt5Km/XoCiatdbUb93K+TtpKGQUGegQPebUu+vzNJor0O7p54FYmHaSd4tewtd5okMoaloQQlr6fa4tGEM2mqfn6lDZbmQSAJG7BU1PvNkp1spMr81WK5zONfoY1NvPeDED9WdCosP3Bcv9iw9A8xa52Sr92L4Ynit9oCrjbn5JskXG6o9kZYyVu4PNkcrkgze+AKRbJ7sJ7dZYrRfT2R8l9WjJ+J6uLc9RpHIhlyo+Uj367H4poGUC7djcDFHb7moIu0=" kd_aesDecryptWitKey:@"b87110974f750a58" andIV:@"ceb2185074c2a7d8"];
    
    id tempData = [jsonResult jsonObject];
    NSLog(@"tempData---%@",tempData);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
