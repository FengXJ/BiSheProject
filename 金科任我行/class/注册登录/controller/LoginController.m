//
//  LoginController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/1/18.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "LoginController.h"
#import "HomeController.h"
#import "registerController.h"
#import "UserInformationViewController.h"
#import "EaseMob.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate.h"

#import "UMComUMengLoginHandler.h"
#import "UMComUserAccount.h"
#import "UMComPushRequest.h"
#import "UserZhangHu.h"




@interface LoginController ()<UITextFieldDelegate,LoginSuccesEnterHome>{
    MyAlertView *alertView;
    AppDelegate *app;
}

@property (strong,nonatomic)NSString *userLoginStr;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg4.jpg"]];
    
    self.loginBtn.enabled = NO;
    [self.loginBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
    //验证码按钮可用时的颜色
    app = [UIApplication sharedApplication].delegate;
    alertView = [[MyAlertView alloc]init];
    [self isLogin];
//    [self enterHomeVC];
}
-(void)isLogin{

  
//        UMComLoginManager *uMComLoginManager = [[UMComLoginManager alloc]init];
//        uMComLoginManager.loginSuccesEnterHomeDelgate = self;
////        //登录微社区
////        [self weiSheQuFromUserDefaults];
//        
    
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
        [self enterHomeVC];
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
    }
    
    
}
//获取已登录用户信息
-(void)getUserInformation{
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    NSString *userStr = [ userLogin objectForKey:@"userLogin"];
    
    AVQuery *query = [AVQuery queryWithClassName:@"UserInformation"];
    [query whereKey:@"username" equalTo:userStr];
    [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if (!object) {
            NSLog(@"getFirstObject 请求失败。");
        } else {
            UserZhangHu *userInformation = nil;
            NSArray *selectUser =  [DataTool selectModel:@"UserZhangHu" request:[NSString stringWithFormat:@"name = 13057539897"]];
            
            if (selectUser.count != 0) {
                userInformation = [selectUser firstObject];
            }else{
                userInformation = [NSEntityDescription insertNewObjectForEntityForName:@"UserZhangHu" inManagedObjectContext:app.managedObjectContext];
            }
            // 查询成功
            
            NSLog(@"对象成功返回。");
            // 检索成功
            userInformation.name = [object valueForKey:@"username"];
            userInformation.age = [object valueForKey:@"age"];
            userInformation.xueyuan = [object valueForKey:@"xueyuan"];
            userInformation.nicheng = [object valueForKey:@"nicheng"];
            userInformation.qianming = [object valueForKey:@"qianming"];
            userInformation.saveAnswer = [object valueForKey:@"saveAnswer"];
            userInformation.phone = [object valueForKey:@"phone"];
            userInformation.sex = [object valueForKey:@"sex"];
             NSError * error = nil;
            if ([app.managedObjectContext save:&error] ) {
                NSLog(@"coredata存储成功");
            }else{
                NSLog(@"coredata存储失败");
            }
            
        }
    }];
    
}
-(void)LoginSuccesEnterHomeVC{
    [self enterHomeVC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerBtn:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    registerController *registerVC = [[registerController alloc]init];
    registerVC = [storyBoard instantiateViewControllerWithIdentifier:@"register"];
    //翻转效果
    [registerVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:registerVC animated: YES completion:nil];
}

- (IBAction)loginBtn:(id)sender {
     [[UIApplication sharedApplication].keyWindow endEditing:YES];

    [AVUser logInWithUsernameInBackground:self.userNameTextField.text password:self.pwdTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [self saveUserLoginMeg];
            [self enterHomeVC];
        } else {
            NSLog(@"登录错误====%@",error);
            //用户名或密码错误
            [alertView myAlertView:self.view meg:@"用户名或密码错误"];
        }
    }];
    
}

-(void)enterHomeVC{
        [self getUserInformation];
//    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.userNameTextField.text password:@"baobei2012" completion:^(NSDictionary *loginInfo, EMError *error) {
//        if (!error && loginInfo) {
//            NSLog(@"登陆成功");
    
            self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            self.window.backgroundColor = [UIColor whiteColor];
            
            NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"tab_buddy_nor.png"],[UIImage imageNamed:@"tab_me_nor.png"],[UIImage imageNamed:@"tab_qworld_nor.png"],[UIImage imageNamed:@"tab_recent_nor.png"], nil];
            NSMutableArray * selectedArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"tab_buddy_press.png"],[UIImage imageNamed:@"tab_me_press.png"],[UIImage imageNamed:@"tab_qworld_press.png"],[UIImage imageNamed:@"tab_recent_press.png"], nil];
            NSMutableArray * titles = [[NSMutableArray alloc]initWithObjects:@"首页",@"消息",@"发现",@"个人", nil];
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            HomeController * vc1 = [[HomeController alloc]init];
            vc1 = [storyBoard instantiateViewControllerWithIdentifier:@"home"];
    
    

            UserInformationViewController *vc4 = [[UserInformationViewController alloc]init];
            vc4 = [storyBoard instantiateViewControllerWithIdentifier:@"userInformationVC"];
            
            //    XMTwoViewController * vc2 = [[XMTwoViewController alloc]init];
            //    XMThreeViewController * vc3 = [[XMThreeViewController alloc]init];
            //    XMFourViewController * vc4 = [[XMFourViewController alloc]init];
            
            //    UINavigationController * nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];
            //    UINavigationController * nav3 = [[UINavigationController alloc]initWithRootViewController:vc3];
            //
            //
            self.tabBar = [[XMTabBarController alloc]initWithTabBarSelectedImages:selectedArray normalImages:array titles:titles];
            self.tabBar.showCenterItem = YES;
            self.tabBar.centerItemImage = [UIImage imageNamed:@"btn_release.png"];
            //    self.tabBar.viewControllers = @[vc1,nav2,nav3,vc4];
            self.tabBar.viewControllers = @[vc1,vc4];
            self.tabBar.textColor = [UIColor redColor];
            [self.tabBar tabBarBadgeValue:345 item:2];
            [self.tabBar tabBarBadgeValue:3 item:1];
            
            //    self.tabBar.xm_centerViewController = [[XMTestViewController alloc] init];
            self.window.rootViewController = self.tabBar;
            [self.window makeKeyAndVisible];
            
//        }
//    } onQueue:nil];

   
}
//用NSUserDefaults存储已登录用户名
-(void)saveUserLoginMeg{
    //将NSString 对象存储到 NSUserDefaults 中
    NSString *userLoginStr = self.userNameTextField.text;
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    [userLogin setObject:userLoginStr forKey:@"userLogin"];
}



//登录微社区
-(void)weiSheQu{
//    UMComUserAccount *userAccount = [[UMComUserAccount alloc] initWithSnsType:UMComSnsTypeSelfAccount];     //使用UMComSnsTypeSelfAccount代表自定义登录，该枚举类型必须和安卓SDK保持一致，否则会出现不能对应同一用户的问题
//    userAccount.usid = self.userNameTextField.text;//必填
//    userAccount.name = self.userNameTextField.text;//必填
//    userAccount.icon_url = nil; //登录用户头像
//    // 将数据传递给友盟微社区SDK
//    
//    [UMComLoginManager loginWithLoginViewController:self userAccount:userAccount];//self表示当前登录页面
    UMComLoginManager *uMComLoginManager =[[UMComLoginManager alloc]init];
    [uMComLoginManager loginWeiShequId:self.userNameTextField.text];
}

//从UserDefaults读取已登录用户信息 登录微社区
-(void)weiSheQuFromUserDefaults{
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    self.userLoginStr = [ userLogin objectForKey:@"userLogin"];
    
    UMComLoginManager *uMComLoginManager =[[UMComLoginManager alloc]init];
    [uMComLoginManager loginWeiShequId:self.userLoginStr];

}
//限制输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.userNameTextField.text.length > 1 && self.pwdTextField.text.length > 1) {
        [self.loginBtn setBackgroundColor:LCHexColor(0xf6b725)];
        self.loginBtn.enabled = YES;
        
    } else {
        if (string.length > 1) {
            [self.loginBtn setBackgroundColor:LCHexColor(0xf6b725)];
            self.loginBtn.enabled = YES;
            
        }else{
            [self.loginBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
            self.loginBtn.enabled = NO;
        }
    }
    
    if(textField == self.userNameTextField||textField == self.pwdTextField){
        
        if (textField.text.length >= 16 && string.length > range.length) {
            return NO;
        }else{
            return YES;
        }
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField == self.pwdTextField ||textField == self.userNameTextField){
        
        if (textField.markedTextRange == nil && textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.loginBtn.enabled = NO;
    [self.loginBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
    
    return YES;
}
@end
