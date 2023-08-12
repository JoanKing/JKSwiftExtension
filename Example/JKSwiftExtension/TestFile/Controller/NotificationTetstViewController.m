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
    self.view.backgroundColor = [UIColor greenColor];
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"RIDE_MODE_STATUS_REFRESH_GO" object:@{@"status":@(YES)}];
    NSString *string1 = @"😄😄";
    NSString *string2 = @"嘿嘿";
    NSLog(@"string1的长度：%ld string2的长度：%ld", string1.length, string2.length);
    
    UIView *testView = [[UIView alloc]initWithFrame: CGRectMake(100, 150, 200, 200)];
    // testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    CALayer *layer1 = [[CALayer alloc]init];
    layer1.frame = testView.bounds;
    layer1.backgroundColor = [UIColor colorWithRed:0.165 green:0.18 blue:0.239 alpha:0.82].CGColor;
    
    [testView.layer addSublayer:layer1];
    
    CALayer *layer2 = [[CALayer alloc]init];
    layer2.frame = testView.bounds;
    layer2.compositingFilter = @"overlayBlendMode";
    layer2.backgroundColor = [UIColor colorWithRed:0.549 green:0.549 blue:0.549 alpha:1].CGColor;
    
    [testView.layer addSublayer:layer2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JKAlertViewController *vc = [[JKAlertViewController alloc]initWithTitle:@"我是标题" message:@"我试内容" arrangementDirectionStyle: ArrangementDirectionStyleVertical textAlignment: NSTextAlignmentCenter alertStyle:JKAlertStyleCard backgroundDismissHandler: nil];
    JKAlertAction *action1 = [[JKAlertAction alloc]initWithTitle:@"确定" style: JKAlertActionStyleRed handler:^(JKAlertAction * _Nonnull action) {
        NSLog(@"点击了确定");
    }];
    [vc addAction:action1];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
