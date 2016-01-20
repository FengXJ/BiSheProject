//
//  NewFeatuerController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/1/15.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "NewFeatuerController.h"
#import "LoginController.h"
#define  PicCount 3

@interface NewFeatuerController ()<UIScrollViewDelegate>{
    UIWindow *window;
}

@end

@implementation NewFeatuerController

-(instancetype)init{
    self = [super init];
    if (self) {
        //初始化分页和scrollView控件
        
        self.BGscrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        CGFloat scrollW = self.BGscrollView.width;
        CGFloat scrollH = self.BGscrollView.height;
        //往scrollView里面添加图片
        for (int i = 0; i<PicCount; i++) {
            self.featuerImageView = [[UIImageView alloc]init];
            self.featuerImageView.width = scrollW;
            self.featuerImageView.height = scrollH;
            self.featuerImageView.x = i*scrollW;
            self.featuerImageView.y = 0;
            //获取新特性图片
            self.featuerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"NewFeature-%d",(i)]];
            
            if (i==(PicCount-1)) {
                [self setUpdate:self.featuerImageView];
            }
            [self.BGscrollView addSubview:self.featuerImageView];
        }
        //设置scrollView里面可以滚动的范围，如果在哪个方向不能滚动，设置为0
        self.BGscrollView.contentSize = CGSizeMake(PicCount*scrollW, 0);
        //self.BGscrollView弹簧效果
        self.BGscrollView.bounces = NO;
        //图片移动到一半，自动分页
        self.BGscrollView.pagingEnabled = YES;
        self.BGscrollView.delegate = self;
        [self.view addSubview:self.pageControl];
    }
    return self;
}

-(void)setUpdate:(UIImageView*)imageView{
    UIButton *starBtn = [[UIButton alloc]init];
    starBtn.frame=CGRectMake(SCREEN_WIDTH-180, SCREEN_HEIGHT-220, 50, 30);
    [starBtn setTitle:@"进入" forState:UIControlStateNormal];
    [starBtn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    imageView.userInteractionEnabled = YES;
    [imageView addSubview:starBtn];
    
}
-(void)enter
{
    window = [UIApplication sharedApplication].keyWindow;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginController *viewCtl = [storyBoard instantiateViewControllerWithIdentifier:@"login"];
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.rootViewController = viewCtl;
    [window makeKeyAndVisible];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.BGscrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    CGFloat scrollW = self.BGscrollView.width;
    CGFloat scrollH = self.BGscrollView.height;
    //往scrollView里面添加图片
    for (int i = 0; i<PicCount; i++) {
        self.featuerImageView = [[UIImageView alloc]init];
        self.featuerImageView.width = scrollW;
        self.featuerImageView.height = scrollH;
        self.featuerImageView.x = i*scrollW;
        self.featuerImageView.y = 0;
        //获取新特性图片
        self.featuerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"NewFeature-%d.jpg",(i)]];
        
        if (i==(PicCount-1)) {
            [self setUpdate:self.featuerImageView];
        }
        [self.BGscrollView addSubview:self.featuerImageView];
    }
    //设置scrollView里面可以滚动的范围，如果在哪个方向不能滚动，设置为0
    self.BGscrollView.contentSize = CGSizeMake(PicCount*scrollW, 0);
    //去掉弹簧效果
    self.BGscrollView.bounces = NO;
    //图片移动到一半，自动分页
    self.BGscrollView.pagingEnabled = YES;
    
    self.BGscrollView.delegate = self;
    [self.view addSubview:self.pageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // NSLog(@"%lf",_scrollView.contentOffset.x);
    //设置分页控件的页码
    double page = (self.BGscrollView.contentOffset.x +
                   self.BGscrollView.width-0.01)/self.BGscrollView.width;
    self.pageControl.currentPage = (int)page;
    
}
@end
