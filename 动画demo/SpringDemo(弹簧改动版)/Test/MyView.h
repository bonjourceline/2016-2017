//
//  MyView.h
//  SpringDemo
//
//  Created by shanghui on 13-6-4.
//  Copyright (c) 2013年 shanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UIView{
    CGPoint velocity;
    UIPanGestureRecognizer * panGestureRecognizer;
}

@property (nonatomic, assign) BOOL springEnabled;
@property (nonatomic, assign) CGFloat springConstant;
@property (nonatomic, assign) CGFloat dampingCoefficient;
@property (nonatomic, assign) CGPoint restCenter;
@property (nonatomic, assign) CGFloat mass;
@property (nonatomic, assign) UIEdgeInsets panDistanceLimits;
@property (nonatomic, assign) CGFloat panDragCoefficient;
@property (nonatomic, readonly) BOOL panning;

- (void)simulateSpringWithDisplayLink:(CADisplayLink *)displayLink;
@end
