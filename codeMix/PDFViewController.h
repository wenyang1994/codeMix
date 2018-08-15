//
//  PDFViewController.h
//  codeMix
//
//  Created by rf-wen on 2018/8/15.
//  Copyright © 2018年 rf-wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFViewController : UIViewController
- (IBAction)postAction:(id)sender;
- (IBAction)cleanAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userId;
@property (strong, nonatomic) IBOutlet UITextField *age;
@property (strong, nonatomic) IBOutlet UITextField *salary;
- (IBAction)userNameFrom:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *tel;

@end
