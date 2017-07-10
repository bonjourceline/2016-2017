//
//  testCollectionViewCell.h
//  scrollviewTest
//
//  Created by aocheng on 16/10/6.
//  Copyright © 2016年 aocheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ifhide)(BOOL);
@interface testCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//@property(nonatomic,strong)UIImageView *iconIamgeView;
@property (nonatomic,strong)ifhide returnHide;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
-(void)getifhide:(ifhide)block;
@end
