//
//  ResetInfroViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/24.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ResetInfroViewController.h"
#import "TRTabBarController.h"
@interface ResetInfroViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *oldLabel;
@property (weak, nonatomic) IBOutlet UITextField *oldTextField;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;
@property (weak, nonatomic) IBOutlet UITextField *newsTextField;
@property (nonatomic) BOOL isHasUserIcon;
@property (nonatomic) NSData *imageData;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ResetInfroViewController
#pragma mark - 方法 Methods
- (void)backVC{
    id navi = [TRTabBarController defaultTabBar];
    [self.sideMenuViewController setContentViewController:navi animated:YES];
}
- (IBAction)pickImage:(UIButton *)sender {
    if (sender.tag==100) {//选择图片
        UIImagePickerController *vc = [UIImagePickerController new];
        vc.delegate = self;
        vc.allowsEditing = YES;
        vc.navigationItem.rightBarButtonItem.title = @"取消";
        [self presentViewController:vc animated:YES completion:nil];
    }else{//保存
        
        BmobUser *user = [BmobUser currentUser];
        
        
        if (self.imageData) {
            
            //上传图片 得到图片地址
            
            [BmobFile filesUploadBatchWithDataArray:@[@{@"filename":@"abc.jpg",@"data":self.imageData}] progressBlock:^(int index, float progress) {
                NSLog(@"进度：%d-%f",index,progress);
            } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    //得到上传完成的图片地址
                    BmobFile *file = [array firstObject];
                    NSString *headPath = file.url;
                    
                    //把图片地址作为用户的头像 保存
                    [user setObject:headPath forKey:@"headPath"];
                    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        
                        if (isSuccessful) {
                            [self setHUDWithTitle:@"修改成功！"];
                            [self backVC];
                        }
                    }];
                }
                
            }];
        }else{//没有头像
            //更新用户信息
            [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                if (isSuccessful) {
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
        
    }
}

- (IBAction)reset:(id)sender {
    BmobUser *user = [BmobUser currentUser];
    if ([self.oldText isEqualToString:@"修改昵称"]) {
        [user setObject:self.newsTextField.text forKey:@"name"];
        [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [self setHUDWithTitle:@"修改昵称成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self setHUDWithTitle:@"修改失败！"];
            }
        }];
    }else if ([self.oldText isEqualToString:@"修改密码"]){
        [user updateCurrentUserPasswordWithOldPassword:user.password newPassword:self.oldTextField.text block:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [self setHUDWithTitle:@"修改密码成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self setHUDWithTitle:@"修改密码失败！"];
            }
            
        }];
    }
}

#pragma mark - UIPicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *imageURLPath = [[info objectForKey:UIImagePickerControllerReferenceURL] description];
    
    if ([imageURLPath hasSuffix:@"PNG"]) {
        self.imageData = UIImagePNGRepresentation(image);
    }else{//jpg
        //后面的数字代表压缩率 0-1为不压缩
        self.imageData = UIImageJPEGRepresentation(image, .5);
        
    }
    
    self.imageView.image = image;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Back@2xpng"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    button.frame = CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    if ([self.oldText isEqualToString:@"修改昵称"]) {
        [self.oldTextField removeFromSuperview];
        self.oldLabel.text = @"";
        self.newsLabel.text = @"新昵称";
        self.newsTextField.placeholder = @"请输入新的昵称";
    }else if ([self.oldText isEqualToString:@"修改密码"]){
        self.oldTextField.placeholder = @"请输入旧密码";
        self.oldLabel.text = self.oldText;
        self.newsLabel.text = @"新密码";
        self.newsTextField.placeholder = @"请输入新密码";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSData *)imageData {
    if(_imageData == nil) {
        _imageData = [[NSData alloc] init];
    }
    return _imageData;
}

@end
