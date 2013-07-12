BeeMessageBlock
===============

This is an category of BeeMessage, whenever a message arrives, the block of code is invoked to handle the message.

@link: <https://github.com/gavinkwoe/BeeFramework>

@example：

  [[BeeMessage sendMessage:UserController.USER_LOG_IN withBlock:^(BeeMessage * msg) {
		if ( msg.succeed )
		{
			LOG(@"main message succeed");
			[TJAPIMessage sendAPIMessage:UserController.GET_ME_INFO withBlock:^(BeeMessage * subMsg) {
				if(subMsg.succeed)
				{
					LOG(@"sub-message succeed");
				}
			}];
		}
		else if (msg.failed)
		{
			LOG(@"main message failed");
		}
	}] input:@"username",@"abc@xx.com",@"password",@"123456",nil];

