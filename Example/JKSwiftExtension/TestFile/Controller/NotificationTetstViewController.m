//
//  NotificationTetstViewController.m
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/3/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#import "NotificationTetstViewController.h"
#import "JKSwiftExtensionDemo-Swift.h"
@interface NotificationTetstViewController ()

@end

@implementation NotificationTetstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"RIDE_MODE_STATUS_REFRESH_GO" object:@{@"status":@(YES)}];
    NSString *string1 = @"😄😄";
    NSString *string2 = @"嘿嘿";
    NSLog(@"string1的长度：%ld string2的长度：%ld", string1.length, string2.length);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JKAlertViewController *vc = [[JKAlertViewController alloc]initWithTitle:@"我是标题" message:@"我试内容" arrangementDirectionStyle: ArrangementDirectionStyleVertical textAlignment: NSTextAlignmentCenter alertStyle:JKAlertStyleCard backgroundDismissHandler: nil];
    JKAlertAction *action1 = [[JKAlertAction alloc]initWithTitle:@"确定" style: JKAlertActionStyleRed handler:^(JKAlertAction * _Nonnull) {
        NSLog(@"点击了确定");
    }];
    [vc addAction:action1];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
