//
//  BetViewController.h
//  codeMix
//
//  Created by rf-wen on 2018/8/15.
//  Copyright © 2018年 rf-wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *firstResult;
@property (strong, nonatomic) IBOutlet UITextField *secondResult;
@property (strong, nonatomic) IBOutlet UITextField *thridResult;

- (IBAction)randomAction:(id)sender;
- (IBAction)resetAction:(id)sender;

@end
