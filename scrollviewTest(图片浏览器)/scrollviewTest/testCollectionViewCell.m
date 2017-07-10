//
//  testCollectionViewCell.m
//  scrollviewTest
//
//  Created by aocheng on 16/10/6.
//  Copyright © 2016年 aocheng. All rights reserved.
//

#import "testCollectionViewCell.h"
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@implementation testCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
//    NSLog(@"大家好");
    [self initUI];
}
-(void)initUI{
    
 
    self.scrollView.clipsToBounds = YES;
    self.scrollView.delegate = self;
//    self.scrollView.frame=CGRectMake(0, 0,self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.userInteractionEnabled=YES;
//    self.scrollView.contentSize=CGSizeMake(self.contentView.frame.size.width, 0);
    self.scrollView.decelerationRate /= 2;
    self.scrollView.bouncesZoom = YES; //缩放反弹，其实默认就是YES
    self.scrollView.userInteractionEnabled=YES;
    self.scrollView.minimumZoomScale=1.0f;
    self.scrollView.maximumZoomScale =2.0f;
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    [self.contentView addSubview:self.scrollView];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.contentView addGestureRecognizer:singleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
//    self.iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.center=self.scrollView.center;
    self.iconImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    [self.scrollView addSubview:self.iconImageView];
    
}
#pragma mark - tap
- (void)handleDoubleTap:(UITapGestureRecognizer *)tap
{
    CGPoint touchPoint = [tap locationInView:self];
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) { //除去最小的时候双击最大，其他时候都还原成最小
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    } else {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES]; //还原
    }
}
-(void)hide{
    NSLog(@"1");
    self.returnHide(YES);
}
-(void)getifhide:(ifhide)block{
    self.returnHide=block;
    
}
-(void)prepareForReuse{
    [super prepareForReuse];
    
    self.scrollView.zoomScale = 1.0f;
    
    
}
- (void)resetZoomScale
{
    self.scrollView.minimumZoomScale = 1.0f;;
    self.scrollView.maximumZoomScale = self.scrollView.minimumZoomScale;
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.iconImageView;
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    self.iconImageView.center=[self centerOfScrollView:scrollView];
    
    
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    [UIView animateWithDuration:0.25f animations:^{
        view.center=[self centerOfScrollView:scrollView];
    }];
    
}
- (CGPoint)centerOfScrollView:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    return CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                       scrollView.contentSize.height * 0.5 + offsetY);
}

@end
