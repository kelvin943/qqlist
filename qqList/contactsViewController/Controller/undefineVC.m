//
//  undefineVC.m
//  qqList
//
//  Created by MAX-TECH on 16/4/3.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "undefineVC.h"
#import "UIButton+WebCache.h"

@interface undefineVC ()

@property (nonatomic,assign)NSInteger mfaf;
@end

@implementation undefineVC


  //TODO("23424");

#pragma mark - 123123

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"敬请期待";

    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn sd_setImageWithURL:@"1231" forState:UIButtonTypeCustom];


    

}

-(void) showTest
{
    
    
  
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

@end
