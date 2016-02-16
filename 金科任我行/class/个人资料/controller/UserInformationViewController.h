//
//  UserInformationViewController.h
//  金科任我行
//
//  Created by 冯学杰 on 16/2/15.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInformationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userBGImageView;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *userSex;

@property (weak, nonatomic) IBOutlet UILabel *userAge;

@property (weak, nonatomic) IBOutlet UIButton *touXiangBtn;

@property (weak, nonatomic) IBOutlet UIButton *addFriendBtn;

@property (weak, nonatomic) IBOutlet UIButton *sendMegBtn;

@property (weak, nonatomic) IBOutlet UIButton *escBtn;

@property (weak, nonatomic) IBOutlet UIImageView *touXiangImage;

@end
