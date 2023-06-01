//
//  NotificationTetstViewController.m
//  JKSwiftExtension_Example
//
//  Created by 王冲 on 2022/3/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#import "NotificationTetstViewController.h"
@interface NotificationTetstViewController ()

@end

@implementation NotificationTetstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RIDE_MODE_STATUS_REFRESH_GO" object:@{@"status":@(YES)}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RIDE_MODE_STATUS_REFRESH_GO" object:@{@"status":@(NO)}];
}

@end
