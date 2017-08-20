//
//  Lrc.m
//  播放声音
//
//  Created by 🍋 on 2016/11/21.
//  Copyright © 2016年 🍋. All rights reserved.
//

#import "Lrc.h"

@implementation Lrc

-(NSMutableArray*)lrcArray{
    if (!_lrcArray) {
        _lrcArray = [[NSMutableArray alloc]init];
    }
    return _lrcArray;
}

-(NSMutableArray*)timeArray{
    if (!_timeArray) {
        _timeArray = [[NSMutableArray alloc]init];
    }
    return _timeArray;
}

-(void)initLrc{
    NSString * lrcPath = [[NSBundle mainBundle] pathForResource:@"歌词" ofType:@"lrc"];
    NSString * content = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
    
    //        NSLog(@"contentStr = %@",content);
    
    NSArray *array = [content componentsSeparatedByString:@"\n"];
    for (int i = 0; i < [array count]; i++) {
        NSString * line = [array objectAtIndex:i];
        NSArray *lineArray = [line componentsSeparatedByString:@"]"];
        if ([lineArray[0] length] > 8) {
            NSString *str1 = [lineArray[0] substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [lineArray[0] substringWithRange:NSMakeRange(6, 1)];
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                NSString * lineLrc = [lineArray[1] substringFromIndex:0];
                //                NSLog(@"%@", lineLrc);
                [self.lrcArray addObject:lineLrc];
                
                
                NSString * lrcTime1 = [lineArray[0] substringWithRange:NSMakeRange(1, 2)];
                //                NSLog(@"%@", lrcTime1);
                NSString * lrcTime2 = [lineArray[0] substringWithRange:NSMakeRange(4, 2)];
                //                NSLog(@"%@", lrcTime2);
                
                NSUInteger  time = [lrcTime1 intValue]*60 + [lrcTime2 intValue];
                [self.timeArray addObject:[NSString stringWithFormat:@"%lu",(unsigned long)time]];
            }
        }
    }
}
@end
