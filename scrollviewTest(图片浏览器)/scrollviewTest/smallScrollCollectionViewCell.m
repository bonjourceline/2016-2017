//
//  smallScrollCollectionViewCell.m
//  scrollviewTest
//
//  Created by aocheng on 16/7/15.
//  Copyright © 2016年 aocheng. All rights reserved.
//

#import "smallScrollCollectionViewCell.h"

@implementation smallScrollCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.contentView.backgroundColor=[UIColor blackColor];
    self.iconIamgeView=[[UIImageView alloc]initWithFrame:self.contentView.frame];
    [self.contentView addSubview:self.iconIamgeView];
    _iconIamgeView.center=self.contentView.center;
    _iconIamgeView.contentMode=UIViewContentModeScaleAspectFit;
    
    self.whiteView=[[UIView alloc]initWithFrame:self.iconIamgeView.frame];
    self.whiteView.layer.borderWidth=2;
    self.whiteView.layer.borderColor=[UIColor whiteColor].CGColor;
    [_iconIamgeView addSubview:self.whiteView];
    
    self.view=[[UIView alloc]initWithFrame:self.iconIamgeView.frame];
    self.view.layer.borderWidth=2;
    self.view.layer.borderColor=[UIColor colorWithRed:233/255.0 green:46/255.0 blue:55/255.0 alpha:1].CGColor;
    
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconIamgeView.frame)-20, self.contentView.frame.size.width, 20)];
    
    [button setTitle:@"详情" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:13];
    button.backgroundColor=[UIColor colorWithRed:233/255.0 green:46/255.0 blue:55/255.0 alpha:1];

    [button setTintColor:[UIColor whiteColor]];
//    label.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:button];
    
  
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        [self.iconIamgeView addSubview:self.view];
        
    }else{
    
        [self.view removeFromSuperview];
        
    }

}
@end
