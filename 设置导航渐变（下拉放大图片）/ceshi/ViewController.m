//
//  ViewController.m
//  ceshi
//
//  Created by aocheng on 16/7/7.
//  Copyright © 2016年 aocheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)NSMutableArray *infoArray;
@property (strong,nonatomic)UIImageView *iamge;
@property (strong,nonatomic)UIView *navView;
@property (strong,nonatomic)UIButton *button;
@end
#define IPHONE_W ([UIScreen mainScreen].bounds.size.width)
#define IPHONE_H ([UIScreen mainScreen].bounds.size.height)
@implementation ViewController
static CGFloat imageHight=200;
- (void)viewDidLoad {
    
    UITableView *tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundColor=[UIColor lightGrayColor];
    tableview.contentInset=UIEdgeInsetsMake(imageHight, 0, 0, 0);
     tableview.separatorInset = UIEdgeInsetsZero;
//    tableview.layoutMargins=UIEdgeInsetsZero;
    
    _iamge=[[UIImageView alloc]initWithFrame:CGRectMake(0, -imageHight,IPHONE_W , imageHight)];
    _iamge.image=[UIImage imageNamed:@"111"];
    [tableview addSubview:_iamge];
    tableview.contentInset=UIEdgeInsetsMake(imageHight, 0, 0, 0);
    
    _navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_W, 64)];
    _navView.backgroundColor=[UIColor redColor];
    _navView.alpha=0;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, IPHONE_W, 64)];
    label.text=@"hello";
    label.textAlignment=NSTextAlignmentCenter;
    _button=[[UIButton alloc]initWithFrame:CGRectMake(IPHONE_W-31, 35, 18, 18)];
    _button.backgroundColor=[UIColor greenColor];
    [_button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_navView addSubview:label];
    [self.view addSubview:tableview];
    [self.view addSubview:_navView];
    [self.view addSubview:_button];
    
}
-(void)onClick{
    NSLog(@"我被点击");

}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath{
    return 44;
}
-(NSMutableArray *)infoArray
{
    if (_infoArray == nil)
    {
        _infoArray = [[NSMutableArray alloc]init];
        for (int i=0; i<40; i++)
        {
            NSString *str=[[NSString alloc]initWithFormat:@"%d",i ];
            [_infoArray addObject:str];
        }
    }
    return _infoArray;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //捕捉y轴的偏移量
    CGFloat yOffset=scrollView.contentOffset.y;
    //设置x轴对应的量 （位移量的一半）
    CGFloat xOffset=(yOffset +imageHight)/2;
    
    if (yOffset<=-imageHight) {
        CGRect f=_iamge.frame;
        f.origin.y= yOffset;
        f.size.height= -yOffset;
        f.origin.x=xOffset;
        //int abs(int i); // 处理int类型的取绝对值
        //double fabs(double i); //处理double类型的取绝对值
        //float fabsf(float i); //处理float类型的取绝对值
        f.size.width=IPHONE_W +fabs(xOffset)*2;
        self.iamge.frame=f;
    }
    if (yOffset>(-imageHight+10)) {
        float y=(yOffset+imageHight)/(imageHight-64);
        _navView.alpha=y;
        
    }
    if (yOffset<(-imageHight+10)) {
        _navView.alpha=0;
    }
   
   }
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArray.count;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    static NSString *identify =@"MyCellIndifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text= [self.infoArray objectAtIndex:indexPath.row];
    cell.preservesSuperviewLayoutMargins=NO;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
