//
// Created by Yulong Luo on 13-7-12.
//


#import <Foundation/Foundation.h>
#import "Bee_Message.h"

@interface BeeMessage (Block)

+ (BeeMessage *)sendMessage:(NSString *)messageName withBlock:(BeeMessageBlock)callback;
+ (BeeMessage *)sendMessage:(NSString *)messageName withBlock:(BeeMessageBlock)callback timeoutSeconds:(NSTimeInterval)seconds;

@property (nonatomic, copy) BeeMessageBlock handleMessageBlock;

@end
