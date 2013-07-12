BeeMessageBlock
===============

This is an category of BeeMessage, whenever a message arrives, the block of code is invoked to handle the message.

@link: <https://github.com/gavinkwoe/BeeFramework>

@example：

		[[BeeMessage sendMessage:UserController.USER_LOG_IN withBlock:^(BeeMessage * msg) {
			if ( msg.succeed )
			{
				LOG(@"main message succeed");
				
				NSNumber * userId = [msg.output numberAtPath:@"userId"];
				
				[[BeeMessage sendMessage:UserController.GET_USER_INFO withBlock:^(BeeMessage * subMsg) {
					if(subMsg.succeed)
					{
						LOG(@"sub-message succeed");
					}
				}] input:@"userId", userId, nil];
			}
			else if (msg.failed)
			{
				LOG(@"main message failed");
			}
		}] input:@"username", @"abc@xx.com", @"password", @"123456", nil];

