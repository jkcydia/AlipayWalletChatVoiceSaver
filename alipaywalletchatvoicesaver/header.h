@interface APChatMedia : NSObject
@property(retain, nonatomic) NSData *data; // @synthesize data=_data;
@property(retain, nonatomic) NSString *url; // @synthesize url=_url;
@end


@interface CTMessageCell : UITableViewCell
- (void)collectMenu:(id)arg1;
- (void)evt_alert:(id)msg;
@property(retain, nonatomic) APChatMedia *voiceObj; // @synthesize voiceObj=_voiceObj;
@end

