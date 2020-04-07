//
//  ViewController.m
//  LQ_PostToolsBar
//
//  Created by liuhongfei on 2019/11/27.
//  Copyright © 2019 BeiJing BoRuiSiYuan Network Technology Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "LQ_PostToolsView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *titleArray = @[@"弹幕", @"@用户", @"公告消息"];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(100, 200 + i * 51, LQScreenW-200, 50);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = UIColor.orangeColor;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"弹幕"]) {
        LQ_PostToolsView *postToolsView = [LQ_PostToolsView new];
        postToolsView.barType = PostBarCurtain;
        
        postToolsView.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:postToolsView animated:NO completion:nil];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"@用户"]) {
        LQ_PostToolsView *postToolsView = [LQ_PostToolsView new];
        postToolsView.userNick = @"Leon";
        postToolsView.barType = PostBarAwaken;
        
        postToolsView.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:postToolsView animated:NO completion:nil];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"公告消息"]) {
        LQ_PostToolsView *postToolsView = [LQ_PostToolsView new];
        postToolsView.barType = PostBarNotice;
        
        postToolsView.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:postToolsView animated:NO completion:nil];
    }
}

@end
