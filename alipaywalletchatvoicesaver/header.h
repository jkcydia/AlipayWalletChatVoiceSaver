NS_ASSUME_NONNULL_BEGIN


@interface APChatMedia : NSObject
@property(retain, nonatomic)  NSData * data; // @synthesize data=_data;
@property(retain, nonatomic) NSString *url; // @synthesize url=_url;
@end


@interface CTMessageCell : UITableViewCell
- (void)collectMenu:(id)arg1;
- (void)evt_alert:(id)msg;
@property(retain, nonatomic) APChatMedia *voiceObj; // @synthesize voiceObj=_voiceObj;
@property(retain, nonatomic) NSDictionary *chatDataSource; // @synthesize chatDataSource=_chatDataSource;
@property(copy, nonatomic) NSString *timeLine; // @synthesize timeLine=_timeLine;

@end

@interface VoiceCache : NSObject
- (id)queryVoiceDataForKey:(id)arg1 formatType:(unsigned int)arg2;
@end

@interface APVoiceManager : NSObject
+ (id)sharedManager;
@property(retain, nonatomic) VoiceCache *voiceCache; // @synthesize voiceCache=_voiceCache;
@end


NS_ASSUME_NONNULL_END
