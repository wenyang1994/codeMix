//
//  CustomPublicCell.m
//  codeMix
//
//  Created by rf-wen on 2018/7/18.
//  Copyright © 2018年 rf-wen. All rights reserved.
//

#import "CustomPublicCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation CustomPublicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.thumbImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 40, 30)];
    
    [self addSubview:self.thumbImage];
    [self addSubview:self.title];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
