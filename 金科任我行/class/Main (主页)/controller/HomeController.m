//
//  HomeController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/1/15.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self uiInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化UI
-(void)uiInit{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    //第一部分广告 第二部分功能模块view
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 145, SCREEN_WIDTH, SCREEN_WIDTH/3*2+50+1)];
    BGView.backgroundColor = LINECOLOR;
    [self.view addSubview:BGView];
    
    //第二部分的第一个view 公告板
    UIView *firstView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49.5)];
    firstView.backgroundColor = [UIColor whiteColor];
    [BGView addSubview:firstView];
    
    UIImageView *radioImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, 30, 30)];
    radioImageView.image = [UIImage imageNamed:@"公告牌"];
    [firstView addSubview:radioImageView];
    
    UILabel *radioLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 19, SCREEN_WIDTH - 100 -20, 13)];
    radioLabel.text = @"这是一条公共栏公告栏公共栏~";
    radioLabel.font = [LCFont systemFontOfSize:13];
    [firstView addSubview:radioLabel];
    
    //第二部分 需要9个按钮
    int tag = 0 ;
    for (int i = 0; i<3; i++) {
        for (int j = 0; j<2; j++) {
            
            tag ++;
           
            UIButton *functionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0 + SCREEN_WIDTH/3*i, 50 + j*SCREEN_WIDTH/3, SCREEN_WIDTH/3-0.5, SCREEN_WIDTH/3-0.5)];
            functionBtn.tag = tag;
            functionBtn.backgroundColor = [UIColor whiteColor];
            [BGView addSubview:functionBtn];
            
            UIImageView *functionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(functionBtn.width/2-40, 20, 80, 60)];
            [functionBtn addSubview:functionImageView];
            
            UILabel *functionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, functionImageView.y+70, functionBtn.width, 13)];
            functionLabel.font = [LCFont systemFontOfSize:13];
            functionLabel.textAlignment = NSTextAlignmentCenter;
            functionLabel.textColor = LCHexColor(0x889394);
            [functionBtn addSubview:functionLabel];
            
            switch (tag) {
                case 1:
                    functionLabel.text = @"社团联盟";
                    functionImageView.image = [UIImage imageNamed:@"main-1.jpg"];
                    break;
                case 2:
                    functionLabel.text = @"新生指南";
                    functionImageView.image = [UIImage imageNamed:@"main-3.jpg"];
                    break;
                case 3:
                    functionLabel.text = @"校园招聘";
                    functionImageView.image = [UIImage imageNamed:@"main-2.jpg"];
                    break;
                case 4:
                    functionLabel.text = @"私人商铺";
                    functionImageView.image = [UIImage imageNamed:@"main-6.jpg"];
                    break;
                case 5:
                    functionLabel.text = @"游玩攻略";
                    functionImageView.image = [UIImage imageNamed:@"main-5.jpg"];
                    break;
                case 6:
                    functionLabel.text = @"敬请期待";
                    functionImageView.image = [UIImage imageNamed:@"main-4.jpg"];
                    break;
                
            }
            
            
            
        }
       
        
    }
    
}

@end
