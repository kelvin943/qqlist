//
//  contactsCell.h
//  qqList
//
//  Created by MAX-TECH on 16/4/1.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  authorsModel;
@interface contactsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *heanImage;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *followStatus;
@property (strong, nonatomic) IBOutlet UILabel *intro;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UIView *isOnLineView;

- (void) setContentDetail :(authorsModel *) authorsInfo;

@end
