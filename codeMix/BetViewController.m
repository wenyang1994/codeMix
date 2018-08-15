//
//  BetViewController.m
//  codeMix
//
//  Created by rf-wen on 2018/8/15.
//  Copyright © 2018年 rf-wen. All rights reserved.
//

#import "BetViewController.h"

@interface BetViewController ()

@end

@implementation BetViewController
@synthesize firstResult = firstResult_;
@synthesize secondResult = secondResult_;
@synthesize thridResult = thridResult_;
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

- (IBAction)randomAction:(id)sender {
    //生成随机竞猜码
    
    int sum = 0;
    for(int i=0;i<99;i++){
        int betNum = arc4random() % 6;
        if(betNum!=0&&betNum!=3&&betNum!=4){
            int random = arc4random() % 2;
            if(betNum==1 && [firstResult_.text isEqualToString:@""]){
                firstResult_.text = [NSString stringWithFormat:@"%i",random];
                sum+=1;
                NSLog(@"radom%i = %i",betNum,random);
            }else if(betNum==2 && [secondResult_.text isEqualToString:@""]){
                secondResult_.text = [NSString stringWithFormat:@"%i",random];
                sum+=1;
                NSLog(@"radom%i = %i",betNum,random);
            }else if(betNum==5 && [thridResult_.text isEqualToString:@""]){
                thridResult_.text = [NSString stringWithFormat:@"%i",random];
                sum+=1;
                NSLog(@"radom%i = %i",betNum,random);
            }
            
            
        }
        if(sum==3){
            break;
        }
        
    }
}

- (IBAction)resetAction:(id)sender {
    firstResult_.text = @"";
    secondResult_.text = @"";
    thridResult_.text = @"";
}
@end
