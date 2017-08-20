//
//  Lrc.h
//  播放声音
//
//  Created by 🍋 on 2016/11/21.
//  Copyright © 2016年 🍋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lrc : NSObject
@property (strong,nonatomic) NSMutableArray * lrcArray;
@property (nonatomic,strong) NSMutableArray *timeArray;


-(void)initLrc;
@end
