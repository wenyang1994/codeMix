//
//  ContentViewController.m
//  codeMix
//
//  Created by rf-wen on 2018/7/19.
//  Copyright © 2018年 rf-wen. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView = [UITextView new];
    _textView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    //设置是否可以编辑
    _textView.editable = YES;
    //设置代理
    _textView.delegate = self;
    
    //设置内容
    _textView.text = _resultText;
    
    //字体颜色
    _textView.textColor = [UIColor redColor];
    
    //设置字体
    _textView.font = [UIFont systemFontOfSize:30];
    
    //设置是否可以滚动
    //UITextView继承于UIScrollView
    _textView.scrollEnabled = YES;
    
    //UITextView 下得键盘中return 表示换行
    [self.view addSubview:_textView];
    
    // Do any additional setup after loading the view.
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
