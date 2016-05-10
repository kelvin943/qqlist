//
//  tableHeadView.h
//  qqList
//
//  Created by MAX-TECH on 16/4/1.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunctionButton.h"

@interface tableHeadView : UIView

@property (strong, nonatomic) IBOutlet UISearchBar *qqSearchBar;
@property (strong, nonatomic) IBOutlet FunctionButton *friendBtn;
@property (strong, nonatomic) IBOutlet FunctionButton *especialBtn;
@property (strong, nonatomic) IBOutlet FunctionButton *groupBtn;
@property (strong, nonatomic) IBOutlet FunctionButton *serviceBtn;


+ (instancetype)makeItem;
@end
