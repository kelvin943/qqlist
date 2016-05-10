//
//  contractCell.h
//  qqList
//
//  Created by MAX-TECH on 16/4/3.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  authorsModel;
@interface contractCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *newsCountFlag;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nikName;
@property (strong, nonatomic) IBOutlet UILabel *messageL;

- (void) setContentDetail :(authorsModel *) authorsInfo;

@end
