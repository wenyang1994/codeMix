//
//  ViewController.m
//  codeMix
//
//  Created by rf-wen on 2018/7/18.
//  Copyright © 2018年 rf-wen. All rights reserved.
//

#import "ViewController.h"
#import "CustomPublicCell.h"
#import "ContentViewController.h"
#import "DataModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray   *titleArray;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSTimer* timer;
@end

@implementation ViewController
@synthesize tableView = _tableView;
@synthesize dic = _dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self getNetData];
    [self getChapterInfo];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Timered) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)Timered{
    
    if(self.titleArray.count>0){
        [_tableView reloadData];
        
        [_timer invalidate];
        
    }
    
}

-(void)getNetData{
    
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"http://api.jisuapi.com/laozi/chapter?appkey=3d0847879f8b10d4"];

    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    __weak __typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){

        weakSelf.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        weakSelf.titleArray = weakSelf.dic[@"result"];
        
    }];
    
    //7.执行任务
    [dataTask resume];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
     }
    
    NSDictionary *dict = self.titleArray[indexPath.row];
    
    cell.textLabel.text = dict[@"name"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *result = [self getChapter:indexPath.row];
    
    if(result.count>0){
        ContentViewController *content = [[ContentViewController alloc]init];
        NSString *string = [NSString stringWithFormat:@"%@ \n%@",result[@"content"],result[@"translation"]];
        content.resultText = string;
        
        [self.navigationController pushViewController:content animated:YES];
        
    }
    
}

-(NSDictionary *)getChapter:(NSInteger)row{
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"http://api.jisuapi.com/laozi/detail?appkey=3d0847879f8b10d4"];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *str = [NSString stringWithFormat:@"detailid=%li&isdetailed=0",row+1];
    
    NSData *bodyData = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    
    __block NSDictionary *result;
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        result = dic[@"result"];
        CFRunLoopStop(CFRunLoopGetMain());
    }];
    
    //7.执行任务
    [dataTask resume];
    CFRunLoopRun();
    
    return result;
}


-(NSDictionary *)getChapterInfo{
    //第一步，创建URL
//    NSURL *url = [NSURL URLWithString:@"http://218.17.35.130:9081/dm/ddcx/1001"];
    NSURL *url = [NSURL URLWithString:@"http://218.17.35.130:9081/dm/ddcx/1002"];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
//    NSString *name = @"";
    NSString *userId = @"201807020956017817";
//    NSString *urlString = [name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    //之前方法
//    NSString *urlString2 = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *bodyDic = @{@"userId":userId};
//    NSDictionary *bodyDic = @{@"token":@"aaa",@"username":urlString,@"password":@"123456"};
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyDic options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:bodyData];
    
    __block NSDictionary *result;
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        CFRunLoopStop(CFRunLoopGetMain());
    }];
    
    //7.执行任务
    [dataTask resume];
    CFRunLoopRun();
    
    return result;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
