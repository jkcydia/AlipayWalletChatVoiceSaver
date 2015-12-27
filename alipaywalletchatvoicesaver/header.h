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

@interface AFHTTPRequestOperation : NSObject

@end

@protocol AFMultipartFormData
- (void)appendPartWithFileData:(NSData *)arg1 name:(NSString *)arg2 fileName:(NSString *)arg3 mimeType:(NSString *)arg4;
@end
@interface AFHTTPRequestSerializer : NSObject
+ (id)serializer;
@end

@interface AFHTTPResponseSerializer : NSObject
+ (id)serializer;
@end

@interface AFHTTPRequestOperationManager : NSObject <NSSecureCoding, NSCopying>
+ (id)manager;

@property(retain, nonatomic) AFHTTPRequestSerializer *requestSerializer; // @synthesize requestSerializer=_requestSerializer;
@property(retain, nonatomic) AFHTTPResponseSerializer *responseSerializer; // @synthesize responseSerializer=_responseSerializer;

- (nullable AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(nullable id)parameters
       constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                         success:(nullable void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(nullable void (^)(AFHTTPRequestOperation * __nullable operation, NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
