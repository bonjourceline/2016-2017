//
//  scrollCollectionViewCell.m
//  scrollviewTest
//
//  Created by aocheng on 16/7/15.
//  Copyright © 2016年 aocheng. All rights reserved.
//

#import "scrollCollectionViewCell.h"
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@interface scrollCollectionViewCell()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;

@end
@implementation scrollCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{

    _scrollView = [[UIScrollView alloc] init];
    _scrollView.clipsToBounds = YES;
    _scrollView.delegate = self;
    _scrollView.frame=CGRectMake(0, 0,self.contentView.frame.size.width, self.contentView.frame.size.height);

    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    self.userInteractionEnabled=YES;
    _scrollView.contentSize=CGSizeMake(screen_width, 0);
    _scrollView.decelerationRate /= 2;
    _scrollView.bouncesZoom = YES; //缩放反弹，其实默认就是YES
    _scrollView.userInteractionEnabled=YES;
    self.scrollView.minimumZoomScale=1.0f;
    self.scrollView.maximumZoomScale =2.0f;
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    [self.contentView addSubview:_scrollView];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.contentView addGestureRecognizer:singleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    _iconIamgeView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    _iconIamgeView.center=_scrollView.center;
   _iconIamgeView.contentMode=UIViewContentModeScaleAspectFit;
    
    [self.scrollView addSubview:_iconIamgeView];

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

    return self.iconIamgeView;
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    self.iconIamgeView.center=[self centerOfScrollView:scrollView];


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
