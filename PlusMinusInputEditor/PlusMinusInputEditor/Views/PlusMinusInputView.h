//
//  AddSubtractInputView.h
//  PlusMinusInputEditor
//
//  Created by 周飞 on 2020/6/2.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PlusMinusInputViewComplete)(NSString *text);

@interface PlusMinusInputView : UIView
@property (nonatomic, copy) PlusMinusInputViewComplete completeBlock;

+ (instancetype)plusMinusInputView;
@end

NS_ASSUME_NONNULL_END
