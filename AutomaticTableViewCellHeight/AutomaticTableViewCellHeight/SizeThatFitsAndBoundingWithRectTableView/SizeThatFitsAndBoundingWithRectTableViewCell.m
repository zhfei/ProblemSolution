//
//  SizeThatFitsAndBoundingWithRectTableViewCell.m
//  AutomaticTableViewCellHeight
//
//  Created by zhoufei on 2020/11/18.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "SizeThatFitsAndBoundingWithRectTableViewCell.h"

@implementation SizeThatFitsAndBoundingWithRectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxWidth = widthS - 120;

    CGFloat height6 = [self.title6 sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)].height;
    CGFloat height7 = [self.title7 sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)].height;
    CGFloat height8 = [self.title8 sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)].height;

    
    //NSStringDrawingUsesLineFragmentOrigin 整体行高以每行组成的矩形为单位
    //NSStringDrawingUsesFontLeading 整体行高以字体间行距（从第一行文字底部到第二行文字底部）
    //🐥：考虑到 实际label.text的属性设置 与 实际传入的参数不一致操作的各种奇怪问题，建议改用sizeThatFits:来计算
//    [self.title7.text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:nil context:nil];
    
    return CGSizeMake(size.width, 91+height6+height7+height8);
}

@end
