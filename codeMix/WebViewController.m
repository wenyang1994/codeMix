//
//  WebViewController.m
//  codeMix
//
//  Created by rf-wen on 2018/8/28.
//  Copyright © 2018年 rf-wen. All rights reserved.
//

#import "WebViewController.h"

#if TARGET_IPHONE_SIMULATOR

#define SIMULATOR_TEST
#else

#endif

@interface WebViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSDictionary *dic;
@end

@implementation WebViewController
@synthesize tableView = tableView_;
@synthesize dic = dic_;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView_ = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-108) style:UITableViewStylePlain];
    tableView_.delegate = self;
    tableView_.dataSource = self;
    tableView_.rowHeight = 100;
    [self.view addSubview:tableView_];
    
    dic_ = [self getWebInfo];
    if(dic_){
        [tableView_ reloadData];
    }
    
    // Do any additional setup after loading the view from its nib.
}



-(NSDictionary *)getWebInfo{
    
    NSURL *url;
    
    if(TARGET_IPHONE_SIMULATOR){
        url = [NSURL URLWithString:@"http://127.0.0.1/content.json"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        __block NSDictionary *result;
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            result = dic;
            
            CFRunLoopStop(CFRunLoopGetMain());
        }];
        
        [dataTask resume];
        CFRunLoopRun();
        return result;
    }else{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // 对数据进行JSON格式化并返回字典形式
        return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"webCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"webCell"];
    }
    if(dic_){
        cell.textLabel.text = dic_[@"name"];
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
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

@end
