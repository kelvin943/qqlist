//
//  qqNavigationVC.m
//  qqList
//
//  Created by MAX-TECH on 16/4/1.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "qqNavigationVC.h"

@interface qqNavigationVC ()

@end

@implementation qqNavigationVC


#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - overwrite
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
