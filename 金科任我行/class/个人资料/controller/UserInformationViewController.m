//
//  UserInformationViewController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/2/15.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "UserInformationViewController.h"
#import "ChangeUserInformationViewController.h"

@interface UserInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController * imagePiker;
    int ChooseBtn;//用于判断是换头像还是换背景 1背景 2头像
}

@property (weak, nonatomic) IBOutlet UITableView *bodyTabelView;


@end

@implementation UserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    //隐藏多余cell
    [self setExtraCellLineHidden:self.bodyTabelView];
    self.bodyTabelView.scrollEnabled =NO; //设置tableview 不能滚动
    self.bodyTabelView.estimatedRowHeight = 50.0;
    
    self.touXiangImage.layer.cornerRadius = self.touXiangImage.frame.size.width / 2;
    self.touXiangImage.clipsToBounds = YES;
    
    //初始化一下
    imagePiker = [[UIImagePickerController alloc] init];
    //设置委托
    imagePiker.delegate = self;
    imagePiker.allowsEditing = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView方法
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
            shuxing.text = @"学院";
            value.text = @"1这是一段很长的签名这是一段很长的签名这是一段很长的签名这是一段很长的签名这是一段很长的签名这是一段很长的签名这是一段很长的签名";
            
            break;
        case 1:
            shuxing.text = @"邮箱";
            value.text =@"2";
            
            break;
        case 2:
            shuxing.text = @"心情";
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

// 隐藏多余cell

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 按钮事件
- (IBAction)addFriendBtn:(id)sender {
    
}

- (IBAction)sendMegBtn:(id)sender {
}

- (IBAction)escBtn:(id)sender {
}
//更换头像Btn
- (IBAction)touXiangBtn:(id)sender {
    ChooseBtn = 2;
    [self ImageChooseAlert];
}
//更换背景Btn
- (IBAction)BGbtn:(id)sender {
    ChooseBtn = 1;
    [self ImageChooseAlert];
}
//修改个人资料Btn
- (IBAction)changeInformationBtn:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChangeUserInformationViewController *changeUserVC = [[ChangeUserInformationViewController alloc]init];
    changeUserVC = [storyBoard instantiateViewControllerWithIdentifier:@"changeUserVC"];
    //翻转效果
    [changeUserVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:changeUserVC animated: YES completion:nil];
}

#pragma mark 图片处理
-(void)ImageChooseAlert{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        [self openCarame];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        [self openImage];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
}

-(void)openCarame{
    //先判断是否可以使用摄像头
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        
        //type要修改成Camera类型
        imagePiker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //设置相机捕获的模式
        imagePiker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        
        //选择默认使用 前置后置的 摄像头
        imagePiker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        
        imagePiker.allowsEditing = YES;
        
        //弹出已经修改成相机类型的 Image Picker
        [self presentViewController:imagePiker animated:YES completion:^(){
            
        }];
    }else{
        NSLog(@"设备不支持摄像头");
    }
}
-(void)openImage{
    //先判断可以使用照片库
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary ] ) {
        //设置image picker的类型为浏览照片库
        imagePiker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        //用自己controller方法弹出一个ImagePickerController
        [self presentViewController:imagePiker animated:YES completion:^(void){
            
        }];
    }else{
        NSLog(@"打开相册失败");
    }
}

//实现委托
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //委托给当前 我们自己控制逻辑 处理要不要消失，如果选择不符合，我们添加if逻辑让他不消失
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker   didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    //image 就是修改后的照片
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *ImageName = [[NSString alloc]init];
    if (ChooseBtn == 1) {
        self.userBGImageView.image = image;
//        ImageName = [NSString stringWithFormat:@"UserBeiJing%@.png",yonghu.name];
    }else{
        self.touXiangImage.image = image;
//        ImageName = [NSString stringWithFormat:@"UserTouXiang%@.png",yonghu.name];
    }
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:ImageName];   // 保存文件的名称
    [UIImagePNGRepresentation(image)writeToFile: filePath    atomically:YES];
//    NSError *error = nil;
//    if ([app.managedObjectContext save:&error] ) {
//        NSLog(@"保存成功");
//    }
//    else {
//        NSLog(@"添加youxiangpath对象到coredata出错 %@",error);
//    }
    //结束操作
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
