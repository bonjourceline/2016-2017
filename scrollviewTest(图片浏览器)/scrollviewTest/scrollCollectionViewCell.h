//
//  scrollCollectionViewCell.h
//  scrollviewTest
//
//  Created by aocheng on 16/7/15.
//  Copyright © 2016年 aocheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ifhide)(BOOL);
@interface scrollCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *iconIamgeView;
@property (nonatomic,strong)ifhide returnHide;
-(void)getifhide:(ifhide)block;
@end
