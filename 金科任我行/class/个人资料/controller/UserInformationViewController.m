//
//  UserInformationViewController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/2/15.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "UserInformationViewController.h"

@interface UserInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *bodyTabelView;

@end

@implementation UserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bodyTabelView.estimatedRowHeight = 50.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID =@"dongtaineirong";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    UILabel *shuxing=(UILabel *)[cell viewWithTag:1];
    UILabel *value=(UILabel *)[cell viewWithTag:2];

    
    switch (indexPath.row) {
        case 0:
            shuxing.text = @"性别";
            value.text = @"1这是一段很长的签名这是一段很长的签名这是一段很长的签名这是一段很长的签名这是一段很长的签名这是一段很长的签名这是一段很长的签名";
            
            break;
        case 1:
            shuxing.text = @"年龄";
            value.text =@"2";
            
            break;
        case 2:
            shuxing.text = @"学院";
            value.text = @"";
            
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
}

@end
