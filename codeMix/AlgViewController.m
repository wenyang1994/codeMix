//
//  AlgViewController.m
//  codeMix
//
//  Created by rf-wen on 2018/8/31.
//  Copyright © 2018年 rf-wen. All rights reserved.
//

#import "AlgViewController.h"

@interface AlgViewController ()
@property (strong, nonatomic) IBOutlet UILabel *algName;
@property (strong, nonatomic) IBOutlet UITextField *inputText;
@property (strong, nonatomic) IBOutlet UITextView *resultValue;

@end

@implementation AlgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)nextAlgAction:(id)sender {
    
}

//计算出重复的数字

void test0(){
    int number[] = {2,5,1,6,3,1,4,3,1,5,2};
    int lenght = sizeof(number)/sizeof(int);
    
    NSMutableArray *repeatNum = [NSMutableArray array];
    
    for(int i = 0;i <= lenght - 1;i++){
        //        NSLog(@"q%i = %i",i,number[i]);
        for(int j = 0; j <= lenght - 1; j++){
            if(j != i){
                //              NSLog(@"p%i = %i",j,number[j]);
                if(number[j] == number[i]){
                    
                    if(![repeatNum containsObject:[NSNumber numberWithInt:number[i]]]){
                        [repeatNum addObject:[NSNumber numberWithInt:number[i]]];
                        printf("%d\n", number[i]);
                    }
                    
                }
            }
            
        }
        
    }
}



- (IBAction)calculateAction:(id)sender {
    

    test0();
    
    
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
