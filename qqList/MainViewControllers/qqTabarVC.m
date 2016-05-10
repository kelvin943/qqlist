//
//  qqTabarVC.m
//  qqList
//
//  Created by MAX-TECH on 16/4/1.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "qqTabarVC.h"
#import "qqNavigationVC.h"

@interface qqTabarVC ()

@end

@implementation qqTabarVC


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //tabBar字体颜色 
    self.tabBar.tintColor = RGBACOLOR(18,183,245,1);
    for (qqNavigationVC * navCtrl in self.viewControllers) {
        //导航栏颜色
        navCtrl.navigationBar.barTintColor=RGBACOLOR(18,183,245,1);
        //导航栏按钮字体颜色
        navCtrl.navigationBar.tintColor=[UIColor whiteColor];
        //导航栏标题字体颜色
        //navCtrl.navigationBar.window =UIBarStyleBlack;
        [navCtrl.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    
    //默认选中联系tabra
    self.selectedViewController = self.viewControllers[1];

}



@end
