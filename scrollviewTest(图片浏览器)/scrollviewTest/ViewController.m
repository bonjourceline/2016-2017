//
//  ViewController.m
//  scrollviewTest
//
//  Created by aocheng on 16/7/14.
//  Copyright © 2016年 aocheng. All rights reserved.
//

#import "ViewController.h"
#import "scrollCollectionViewCell.h"
#import "smallScrollCollectionViewCell.h"
#import "testCollectionViewCell.h"
#define selfwidth self.view.frame.size.width
#define selfheight self.view.frame.size.height
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{

    UIImageView *_imageview;
  
}
@property (strong, nonatomic)NSArray *array;
@property (strong, nonatomic)UICollectionView *collectionView;
@property (strong, nonatomic)UICollectionView *smallCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.array=@[@"001.png",@"002.png",@"003.png",@"004.png",@"005.png"];
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    flow.itemSize=CGSizeMake(screen_width,screen_height);
    flow.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing=0.0f;
    flow.minimumLineSpacing=0.0f;

      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flow];
//    [self.collectionView registerClass:[scrollCollectionViewCell class] forCellWithReuseIdentifier:@"cellIde"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"testCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.pagingEnabled=YES;
    self.collectionView.userInteractionEnabled=YES;
    self.collectionView.backgroundColor=[UIColor grayColor];
    self.collectionView.showsHorizontalScrollIndicator=NO;
   
    [self.view addSubview:self.collectionView];
    [self creatSmallCollecitonview];

}
-(void)dealloc{
  [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==self.collectionView) {
    
    testCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
            cell.iconImageView.image=[UIImage imageNamed:self.array[indexPath.row]];
        cell.height.constant=screen_height;
        cell.width.constant=screen_width;
//        cell.iconImageView.frame=self.view.bounds;
        NSLog(@"hello");
        [cell getifhide:^(BOOL returnif) {
            if(self.smallCollectionView.hidden==YES){
                
                 self.smallCollectionView.hidden=NO;
                [UIView animateWithDuration:0.5 animations:^{
                    self.smallCollectionView.alpha=1;
                } completion:^(BOOL finished) {
                   
                }];
                
            }else{
                self.smallCollectionView.alpha=1;
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.smallCollectionView.alpha=0;
                } completion:^(BOOL finished) {
                    self.smallCollectionView.hidden=YES;
                }];
                
            }
            
            
        }];

    return cell;
    }else{
        scrollCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"smallScrollCollectionViewCell" forIndexPath:indexPath];
        cell.iconIamgeView.image=[UIImage imageNamed:self.array[indexPath.row]];

        return cell;
    }
}
-(void)onDeviceOrientationChange
{
    CGPoint point=self.collectionView.contentOffset;
    NSLog(@"%lf-----%lf",point.x,point.y);
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    //    CGRect screenBounds = [UIScreen mainScreen].bounds;
#define kAnimationDuration 0.35f
    if (UIDeviceOrientationIsLandscape(orientation)) {
        
        
            
            
            //                [self hiddentNav];
            self.collectionView.frame=self.view.bounds;
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
            [self.collectionView reloadData];
            
            self.collectionView.contentOffset=CGPointMake((point.x/screen_height)*screen_width, 0);
        
    }else if (orientation==UIDeviceOrientationPortrait){
       
            
            //                [self showNav];
            self.collectionView.frame=self.view.bounds;
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
            
            [self.collectionView reloadData];
            self.collectionView.contentOffset=CGPointMake((point.x/screen_height)*screen_width,0);
        
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==self.collectionView) {
        
    return CGSizeMake(screen_width , screen_height);
    }else{
    
        return CGSizeMake((screen_width-60)/4,self.smallCollectionView.frame.size.height-24);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 0, 0);

}
//- (CGFloat) collectionView:(UICollectionView *)collectionView
//                    layout:(UICollectionViewLayout *)collectionViewLayout
//minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==self.smallCollectionView) {
        self.collectionView.contentOffset=CGPointMake(screen_width*indexPath.row, 0);
    }

}
-(void)creatSmallCollecitonview{

    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    flow.itemSize=CGSizeMake((screen_width-60)/4,self.smallCollectionView.frame.size.height-24);
    flow.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    
    self.smallCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, screen_height*(0.8) , screen_width, screen_height*0.2) collectionViewLayout:flow];
    [self.smallCollectionView registerClass:[smallScrollCollectionViewCell class] forCellWithReuseIdentifier:@"smallScrollCollectionViewCell"];
    self.smallCollectionView.delegate=self;
    self.smallCollectionView.dataSource=self;

    self.smallCollectionView.userInteractionEnabled=YES;
    self.smallCollectionView.backgroundColor=[UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
    self.smallCollectionView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.smallCollectionView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
