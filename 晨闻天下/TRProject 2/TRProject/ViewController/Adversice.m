//
//  Adversice.m
//  TRProject
//
//  Created by 钟至大 on 16/8/24.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "Adversice.h"
#import <BmobSDK/Bmob.h>
@interface Adversice ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) BmobObject *adversice;
@end

@implementation Adversice
- (IBAction)send:(id)sender {
    if (![self.textView.text isEqualToString:@""]) {
        [self.adversice setObject:self.textView.text forKey:@"adversice"];
        [self.adversice saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [self setHUDWithTitle:@"发送成功！"];
                self.textView.text = @"";
            }else{
                NSLog(@"%@",error);
            }
        }];

    }else{
        [self setHUDWithTitle:@"发送失败,内容不能为空!"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BmobObject *)adversice {
	if(_adversice == nil) {
		_adversice = [BmobObject objectWithClassName:@"adversices"];
	}
	return _adversice;
}

@end
