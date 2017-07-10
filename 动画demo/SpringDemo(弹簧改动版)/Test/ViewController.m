//
//  ViewController.m
//  Test
//
//  Created by aocheng on 16/8/13.
//  Copyright © 2016年 aocheng. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
#import <QuartzCore/CADisplayLink.h>
@interface ViewController ()
{
    CADisplayLink * displayLink;
    MyView *view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(creatView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)creatView{
    if (view) {
        view.restCenter = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
      
    }else{
        view=[[MyView alloc]initWithFrame:CGRectMake(0, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        view.backgroundColor=[UIColor greenColor];
        [self.view addSubview:view];
        displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:(id)kCFRunLoopDefaultMode];

    }
  
    
}
- (void)displayLinkTick:(CADisplayLink *)link {
    [view simulateSpringWithDisplayLink:link];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
