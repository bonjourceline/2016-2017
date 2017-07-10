//
//  MyView.m
//  SpringDemo
//
//  Created by shanghui on 13-6-4.
//  Copyright (c) 2013年 shanghui. All rights reserved.
//

#import "MyView.h"
#import <QuartzCore/CADisplayLink.h>

@implementation MyView

@synthesize mass;
@synthesize springConstant;
@synthesize dampingCoefficient;
@synthesize panDragCoefficient;
@synthesize panDistanceLimits;
@synthesize restCenter;
@synthesize springEnabled;


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
		
		springEnabled = YES;
		//固定好中间的位置
		restCenter = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
//		springConstant = 500;
        springConstant=400;//弹簧的力度
		dampingCoefficient = 15;
		mass = 1;
		velocity = CGPointZero;
		
		panDistanceLimits = UIEdgeInsetsMake(CGFLOAT_MAX, CGFLOAT_MAX, CGFLOAT_MAX, CGFLOAT_MAX);
		panDragCoefficient = 1.0;
		
		panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasPanned:)];
		[self addGestureRecognizer:panGestureRecognizer];
    }
	
    return self;

}
- (BOOL)panning {
	return (panGestureRecognizer.state == UIGestureRecognizerStateChanged);
}

- (void)simulateSpringWithDisplayLink:(CADisplayLink *)displayLink {
	
	if (springEnabled && !self.panning){
        CGPoint displacement = CGPointMake(self.center.x - restCenter.x,
                                           self.center.y - restCenter.y);
        //控件收到的力
        CGPoint kx = CGPointMake(springConstant * displacement.x, springConstant * displacement.y);
        //控件受到的阻力
        CGPoint bv = CGPointMake(dampingCoefficient	* velocity.x, dampingCoefficient * velocity.y);
        //加速度（a=s1-s2/时间）
        CGPoint acceleration = CGPointMake((kx.x + bv.x) / mass, (kx.y + bv.y) / mass);
        
        velocity.x -= (acceleration.x * displayLink.duration);
        velocity.y -= (acceleration.y * displayLink.duration);
        
        //设置控件新位置
        CGPoint newCenter = self.center;
        newCenter.x += (velocity.x * displayLink.duration);
        newCenter.y += (velocity.y * displayLink.duration);
        [self setCenter:newCenter];
	}
}

#pragma mark - Panning
- (void)viewWasPanned:(UIPanGestureRecognizer *)sender {
	
	CGPoint translation = CGPointApplyAffineTransform([sender translationInView:self.superview], CGAffineTransformMakeScale(panDragCoefficient, panDragCoefficient));
	CGPoint translatedCenter = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
	
	if (translation.x > 0 && (translatedCenter.x - restCenter.x) > panDistanceLimits.right){
		translation.x -= (translatedCenter.x - restCenter.x) - panDistanceLimits.right;
	}
	else if (translation.x < 0 && (restCenter.x - translatedCenter.x) > panDistanceLimits.left){
		translation.x += (restCenter.x - translatedCenter.x) - panDistanceLimits.left;
	}
	
	if (translation.y > 0 && (translatedCenter.y - restCenter.y) > panDistanceLimits.bottom){
		translation.y -= (translatedCenter.y - restCenter.y) - panDistanceLimits.bottom;
	}
	else if (translation.y < 0 && (restCenter.y - translatedCenter.y) > panDistanceLimits.top){
		translation.y += (restCenter.y - translatedCenter.y) - panDistanceLimits.top;
	}
	
//	[self setCenter:CGPointMake(self.center.x + translation.x, self.center.y + translation.y)];
    [self setCenter:CGPointMake(self.center.x, self.center.y + translation.y)];
    
    //    设置当前位置
	[sender setTranslation:CGPointZero inView:self.superview];
    


    if(sender.view.frame.origin.y<=-200){
    restCenter=CGPointMake(self.center.x, -[[UIScreen mainScreen] bounds].size.height/2);
//        [self removeFromSuperview];

    }
//    [sender setTranslation:CGPointZero inView:self.superview];
}


@end
