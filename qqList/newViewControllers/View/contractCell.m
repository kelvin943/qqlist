//
//  contractCell.m
//  qqList
//
//  Created by MAX-TECH on 16/4/3.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "contractCell.h"
#import "authorsModel.h"
#import "UIImageView+WebCache.h"

@implementation contractCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void) setContentDetail :(authorsModel *) authorsInfo
{

    [self.headImage sd_setImageWithURL:[NSURL URLWithString:authorsInfo.avatar] placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    self.headImage.layer.masksToBounds =YES;
    
    self.nikName.text = authorsInfo.nickname;
    self.messageL.text =@"hionfaodf12312";
    self.timeLabel.text = [NSString stringWithFormat:@"%u:%u",arc4random()%12 +1,arc4random()%60+1];

    self.newsCountFlag.layer.borderColor=[[UIColor clearColor]CGColor];
    self.newsCountFlag.layer.cornerRadius=10;
    self.newsCountFlag.layer.masksToBounds=YES;
    
    if (authorsInfo.newsCount>0) {
        self.newsCountFlag.alpha=1;
        self.newsCountFlag.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)authorsInfo.newsCount];
        [self.newsCountFlag setTitle:[NSString stringWithFormat:@"%ld",(long)authorsInfo.newsCount] forState:UIControlStateNormal];

    }
    else{
        self.newsCountFlag.alpha=0;

    }

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
