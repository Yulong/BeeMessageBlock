//
// Created by Yulong Luo on 13-7-12.
//


#import <objc/runtime.h>
#import "BeeMessage+Block.h"

static void * BEE_MESSAGE_CALLBACK_KEY = (void *)@"BEE_MESSAGE_CALLBACK_KEY";

@implementation BeeMessage (Block)

+ (BeeMessage *)sendMessage:(NSString *)messageName withBlock:(BeeMessageBlock)callback
{
    return [BeeMessage sendMessage:messageName withBlock:callback timeoutSeconds:0];
}

+ (BeeMessage *)sendMessage:(NSString *)messageName withBlock:(BeeMessageBlock)callback timeoutSeconds:(NSTimeInterval)seconds
{
    BeeMessage * msg = [BeeMessage new];
    msg.message = messageName;
    msg.responder = msg;
    msg.seconds = seconds > 0 ? seconds : 60.f;
    msg.handleMessageBlock = callback;
    [msg send];
    return [msg autorelease];
}

- (BeeMessageBlock)handleMessageBlock
{
    return objc_getAssociatedObject(self, BEE_MESSAGE_CALLBACK_KEY);
}

- (void)setHandleMessageBlock:(BeeMessageBlock)handleMessageBlock
{
    objc_setAssociatedObject(self, BEE_MESSAGE_CALLBACK_KEY, handleMessageBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)handleMessage:(BeeMessage *)msg
{
    BeeMessageBlock callback = msg.handleMessageBlock;
    if (callback)
    {
        callback(msg);
    }
}

- (void)dealloc
{
    if (self.handleMessageBlock)
    {
        self.handleMessageBlock = nil;
    }

    [self cancelRequests];

    [_timer invalidate];
    [_message release];
    [_input release];
    [_output release];

    [_errorDomain release];
    [_errorDesc release];

#if defined(__BEE_DEVELOPMENT__) && __BEE_DEVELOPMENT__
    [_callstack removeAllObjects];
    [_callstack release];
#endif  // #if defined(__BEE_DEVELOPMENT__) && __BEE_DEVELOPMENT__

    self.whenUpdate = nil;

    [super dealloc];
}


@end
