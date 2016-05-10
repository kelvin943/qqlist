//
//  contactsCell.m
//  qqList
//
//  Created by MAX-TECH on 16/4/1.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "contactsCell.h"
#import "authorsModel.h"
#import "UIImageView+WebCache.h"

@implementation contactsCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void) setContentDetail :(authorsModel *) authorsInfo
{
    [self.heanImage sd_setImageWithURL:[NSURL URLWithString:authorsInfo.avatar] placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    self.nickname.text =authorsInfo.nickname;
    self.followStatus.text =authorsInfo.followStatus? @"[在线]":@"[离线]";
    self.intro.text =authorsInfo.intro;
    
    switch (authorsInfo.netType) {
        case netTypeWifi:
            self.typeLabel .text = @"Wifi";
            break;
        case netTypePhone:
            self.typeLabel .text = @"手机";
            break;
        case netTypePC:
            self.typeLabel .text = @"PC";
            break;
        case netType2G:
            self.typeLabel .text = @"2G";
            break;
        case netType3G:
            self.typeLabel .text = @"3G";
            break;
        case netType4G:
            self.typeLabel .text = @"4G";
            break;
    }
    if (authorsInfo.followStatus) {
        self.isOnLineView.alpha =0;
        self.isOnLineView.userInteractionEnabled =NO;
    }
    else{
        self.isOnLineView.alpha =0.4;
        self.isOnLineView.userInteractionEnabled =NO;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
