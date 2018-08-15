//
//  PDFViewController.m
//  codeMix
//
//  Created by rf-wen on 2018/8/15.
//  Copyright © 2018年 rf-wen. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()

@end

@implementation PDFViewController
@synthesize userName = userName_;
@synthesize userId = userId_;
@synthesize age = age_;
@synthesize salary = salary_;
@synthesize tel = tel_;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(NSDictionary *)getPersonInfo:(NSString *)userId{
    
    
    NSURL *url = [NSURL URLWithString:@"http://218.17.35.130:9081/dm/ddcx/1002"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    NSDictionary *bodyDic = @{@"userId":userId};
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyDic options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:bodyData];
    
    __block NSDictionary *result;
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        CFRunLoopStop(CFRunLoopGetMain());
    }];
    
    //7.执行任务
    [dataTask resume];
    CFRunLoopRun();
    NSLog(@"result = %@",result);
    return result;
}


-(NSDictionary *)getChapterInfo:(NSString *)name{
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"http://218.17.35.130:9081/dm/ddcx/1001"];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *urlString = [name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSDictionary *bodyDic = @{@"token":@"aaa",@"username":urlString,@"password":@"123456"};
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyDic options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:bodyData];
    
    __block NSDictionary *result;
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        CFRunLoopStop(CFRunLoopGetMain());
    }];
    
    //7.执行任务
    [dataTask resume];
    CFRunLoopRun();
    
    return result;
}


- (IBAction)postAction:(id)sender {
    if(![userName_.text isEqualToString:@""]){
        NSDictionary *dic = [self getChapterInfo:userName_.text];
        NSDictionary *result = [self getPersonInfo:dic[@"userId"]];
        
        userId_.text = result[@"userId"];
        age_.text = [NSString stringWithFormat:@"%@",result[@"age"]];
        salary_.text = result[@"salary"];
        tel_.text = result[@"telephone"];
    }
    
    [self.view endEditing:YES];
    
}

- (IBAction)cleanAction:(id)sender {
    userName_.text = @"";
    userId_.text = @"";
    age_.text = @"";
    salary_.text = @"";
    tel_.text = @"";
}

- (IBAction)userNameFrom:(id)sender {
    UITextField *textFiled = sender;
    userName_ = textFiled;
}
@end
