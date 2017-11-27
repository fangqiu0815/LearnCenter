// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

#import "Common.pb.h"
// @@protoc_insertion_point(imports)

@class auth_ctx_msg;
@class auth_ctx_msgBuilder;
@class auth_kick_user_msg;
@class auth_kick_user_msgBuilder;
@class auth_user_info_rep_msg;
@class auth_user_info_rep_msgBuilder;
@class auth_user_info_req_msg;
@class auth_user_info_req_msgBuilder;
@class auth_user_offline_msg;
@class auth_user_offline_msgBuilder;
@class client_login_msg;
@class client_login_msgBuilder;
@class client_login_result_msg;
@class client_login_result_msgBuilder;
@class combo_private_msg;
@class combo_private_msgBuilder;
@class common_reply_error_msg;
@class common_reply_error_msgBuilder;
@class common_update_notice_msg;
@class common_update_notice_msgBuilder;
@class count_offset_selector;
@class count_offset_selectorBuilder;
@class data_selector;
@class data_selectorBuilder;
@class ext_key_info;
@class ext_key_infoBuilder;
@class load_dector_msg;
@class load_dector_msgBuilder;
@class notify_ack_msg;
@class notify_ack_msgBuilder;
@class push_notify_msg;
@class push_notify_msgBuilder;
@class rpc_msg_root;
@class rpc_msg_rootBuilder;
@class server_login_msg;
@class server_login_msgBuilder;
@class server_login_result_msg;
@class server_login_result_msgBuilder;
@class subcribe_msg;
@class subcribe_msgBuilder;
@class sync_notify_msg;
@class sync_notify_msgBuilder;
@class time_offset_selector;
@class time_offset_selectorBuilder;
@class time_range_selector;
@class time_range_selectorBuilder;



@interface AuthRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define auth_kick_user_msg_sid @"sid"
#define auth_kick_user_msg_cid @"cid"
#define auth_kick_user_msg_name @"name"
@interface auth_kick_user_msg : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasName_:1;
  BOOL hasSid_:1;
  BOOL hasCid_:1;
  NSString* name;
  UInt32 sid;
  UInt32 cid;
}
- (BOOL) hasSid;
- (BOOL) hasCid;
- (BOOL) hasName;
@property (readonly) UInt32 sid;
@property (readonly) UInt32 cid;
@property (readonly, strong) NSString* name;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (auth_kick_user_msgBuilder*) builder;
+ (auth_kick_user_msgBuilder*) builder;
+ (auth_kick_user_msgBuilder*) builderWithPrototype:(auth_kick_user_msg*) prototype;
- (auth_kick_user_msgBuilder*) toBuilder;

+ (auth_kick_user_msg*) parseFromData:(NSData*) data;
+ (auth_kick_user_msg*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (auth_kick_user_msg*) parseFromInputStream:(NSInputStream*) input;
+ (auth_kick_user_msg*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (auth_kick_user_msg*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (auth_kick_user_msg*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface auth_kick_user_msgBuilder : PBGeneratedMessageBuilder {
@private
  auth_kick_user_msg* resultAuthKickUserMsg;
}

- (auth_kick_user_msg*) defaultInstance;

- (auth_kick_user_msgBuilder*) clear;
- (auth_kick_user_msgBuilder*) clone;

- (auth_kick_user_msg*) build;
- (auth_kick_user_msg*) buildPartial;

- (auth_kick_user_msgBuilder*) mergeFrom:(auth_kick_user_msg*) other;
- (auth_kick_user_msgBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (auth_kick_user_msgBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasSid;
- (UInt32) sid;
- (auth_kick_user_msgBuilder*) setSid:(UInt32) value;
- (auth_kick_user_msgBuilder*) clearSid;

- (BOOL) hasCid;
- (UInt32) cid;
- (auth_kick_user_msgBuilder*) setCid:(UInt32) value;
- (auth_kick_user_msgBuilder*) clearCid;

- (BOOL) hasName;
- (NSString*) name;
- (auth_kick_user_msgBuilder*) setName:(NSString*) value;
- (auth_kick_user_msgBuilder*) clearName;
@end

#define auth_user_offline_msg_sid @"sid"
#define auth_user_offline_msg_cid @"cid"
#define auth_user_offline_msg_name @"name"
#define auth_user_offline_msg_ltype @"ltype"
@interface auth_user_offline_msg : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasName_:1;
  BOOL hasSid_:1;
  BOOL hasCid_:1;
  BOOL hasLtype_:1;
  NSString* name;
  UInt32 sid;
  UInt32 cid;
  client_login_msglogin_type ltype;
}
- (BOOL) hasSid;
- (BOOL) hasCid;
- (BOOL) hasName;
- (BOOL) hasLtype;
@property (readonly) UInt32 sid;
@property (readonly) UInt32 cid;
@property (readonly, strong) NSString* name;
@property (readonly) client_login_msglogin_type ltype;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (auth_user_offline_msgBuilder*) builder;
+ (auth_user_offline_msgBuilder*) builder;
+ (auth_user_offline_msgBuilder*) builderWithPrototype:(auth_user_offline_msg*) prototype;
- (auth_user_offline_msgBuilder*) toBuilder;

+ (auth_user_offline_msg*) parseFromData:(NSData*) data;
+ (auth_user_offline_msg*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (auth_user_offline_msg*) parseFromInputStream:(NSInputStream*) input;
+ (auth_user_offline_msg*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (auth_user_offline_msg*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (auth_user_offline_msg*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface auth_user_offline_msgBuilder : PBGeneratedMessageBuilder {
@private
  auth_user_offline_msg* resultAuthUserOfflineMsg;
}

- (auth_user_offline_msg*) defaultInstance;

- (auth_user_offline_msgBuilder*) clear;
- (auth_user_offline_msgBuilder*) clone;

- (auth_user_offline_msg*) build;
- (auth_user_offline_msg*) buildPartial;

- (auth_user_offline_msgBuilder*) mergeFrom:(auth_user_offline_msg*) other;
- (auth_user_offline_msgBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (auth_user_offline_msgBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasSid;
- (UInt32) sid;
- (auth_user_offline_msgBuilder*) setSid:(UInt32) value;
- (auth_user_offline_msgBuilder*) clearSid;

- (BOOL) hasCid;
- (UInt32) cid;
- (auth_user_offline_msgBuilder*) setCid:(UInt32) value;
- (auth_user_offline_msgBuilder*) clearCid;

- (BOOL) hasName;
- (NSString*) name;
- (auth_user_offline_msgBuilder*) setName:(NSString*) value;
- (auth_user_offline_msgBuilder*) clearName;

- (BOOL) hasLtype;
- (client_login_msglogin_type) ltype;
- (auth_user_offline_msgBuilder*) setLtype:(client_login_msglogin_type) value;
- (auth_user_offline_msgBuilder*) clearLtype;
@end

#define auth_user_info_req_msg_ltype @"ltype"
#define auth_user_info_req_msg_user_name @"userName"
@interface auth_user_info_req_msg : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasUserName_:1;
  BOOL hasLtype_:1;
  NSString* userName;
  client_login_msglogin_type ltype;
}
- (BOOL) hasLtype;
- (BOOL) hasUserName;
@property (readonly) client_login_msglogin_type ltype;
@property (readonly, strong) NSString* userName;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (auth_user_info_req_msgBuilder*) builder;
+ (auth_user_info_req_msgBuilder*) builder;
+ (auth_user_info_req_msgBuilder*) builderWithPrototype:(auth_user_info_req_msg*) prototype;
- (auth_user_info_req_msgBuilder*) toBuilder;

+ (auth_user_info_req_msg*) parseFromData:(NSData*) data;
+ (auth_user_info_req_msg*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (auth_user_info_req_msg*) parseFromInputStream:(NSInputStream*) input;
+ (auth_user_info_req_msg*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (auth_user_info_req_msg*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (auth_user_info_req_msg*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface auth_user_info_req_msgBuilder : PBGeneratedMessageBuilder {
@private
  auth_user_info_req_msg* resultAuthUserInfoReqMsg;
}

- (auth_user_info_req_msg*) defaultInstance;

- (auth_user_info_req_msgBuilder*) clear;
- (auth_user_info_req_msgBuilder*) clone;

- (auth_user_info_req_msg*) build;
- (auth_user_info_req_msg*) buildPartial;

- (auth_user_info_req_msgBuilder*) mergeFrom:(auth_user_info_req_msg*) other;
- (auth_user_info_req_msgBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (auth_user_info_req_msgBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasLtype;
- (client_login_msglogin_type) ltype;
- (auth_user_info_req_msgBuilder*) setLtype:(client_login_msglogin_type) value;
- (auth_user_info_req_msgBuilder*) clearLtype;

- (BOOL) hasUserName;
- (NSString*) userName;
- (auth_user_info_req_msgBuilder*) setUserName:(NSString*) value;
- (auth_user_info_req_msgBuilder*) clearUserName;
@end

#define auth_user_info_rep_msg_user_name @"userName"
#define auth_user_info_rep_msg_product_name @"productName"
#define auth_user_info_rep_msg_vaild_date @"vaildDate"
#define auth_user_info_rep_msg_ext @"ext"
@interface auth_user_info_rep_msg : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasUserName_:1;
  BOOL hasProductName_:1;
  BOOL hasVaildDate_:1;
  NSString* userName;
  NSString* productName;
  NSString* vaildDate;
  NSMutableArray * extArray;
}
- (BOOL) hasUserName;
- (BOOL) hasProductName;
- (BOOL) hasVaildDate;
@property (readonly, strong) NSString* userName;
@property (readonly, strong) NSString* productName;
@property (readonly, strong) NSString* vaildDate;
@property (readonly, strong) NSArray * ext;
- (ext_key_info*)extAtIndex:(NSUInteger)index;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (auth_user_info_rep_msgBuilder*) builder;
+ (auth_user_info_rep_msgBuilder*) builder;
+ (auth_user_info_rep_msgBuilder*) builderWithPrototype:(auth_user_info_rep_msg*) prototype;
- (auth_user_info_rep_msgBuilder*) toBuilder;

+ (auth_user_info_rep_msg*) parseFromData:(NSData*) data;
+ (auth_user_info_rep_msg*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (auth_user_info_rep_msg*) parseFromInputStream:(NSInputStream*) input;
+ (auth_user_info_rep_msg*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (auth_user_info_rep_msg*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (auth_user_info_rep_msg*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface auth_user_info_rep_msgBuilder : PBGeneratedMessageBuilder {
@private
  auth_user_info_rep_msg* resultAuthUserInfoRepMsg;
}

- (auth_user_info_rep_msg*) defaultInstance;

- (auth_user_info_rep_msgBuilder*) clear;
- (auth_user_info_rep_msgBuilder*) clone;

- (auth_user_info_rep_msg*) build;
- (auth_user_info_rep_msg*) buildPartial;

- (auth_user_info_rep_msgBuilder*) mergeFrom:(auth_user_info_rep_msg*) other;
- (auth_user_info_rep_msgBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (auth_user_info_rep_msgBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserName;
- (NSString*) userName;
- (auth_user_info_rep_msgBuilder*) setUserName:(NSString*) value;
- (auth_user_info_rep_msgBuilder*) clearUserName;

- (BOOL) hasProductName;
- (NSString*) productName;
- (auth_user_info_rep_msgBuilder*) setProductName:(NSString*) value;
- (auth_user_info_rep_msgBuilder*) clearProductName;

- (BOOL) hasVaildDate;
- (NSString*) vaildDate;
- (auth_user_info_rep_msgBuilder*) setVaildDate:(NSString*) value;
- (auth_user_info_rep_msgBuilder*) clearVaildDate;

- (NSMutableArray *)ext;
- (ext_key_info*)extAtIndex:(NSUInteger)index;
- (auth_user_info_rep_msgBuilder *)addExt:(ext_key_info*)value;
- (auth_user_info_rep_msgBuilder *)setExtArray:(NSArray *)array;
- (auth_user_info_rep_msgBuilder *)clearExt;
@end


// @@protoc_insertion_point(global_scope)
