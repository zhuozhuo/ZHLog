//
//  ZHShareLog.h
//  iMCOBandRealTekSDK_iOS
//
//  Created by zhuo on 2015/5/24.
//  Copyright © 2015年 zhuo. All rights reserved.
//

#define ZHLogToFile(logStr,level) {\
 \
switch (level) {\
case ZH_Log_Debug:{\
ZHLogDebug(@"%@",(logStr));\
[[ZHShareLog shareZHShareLog]printDebugInfo:[NSString stringWithFormat:@"✅Debug: %s [Line %d] %@",__PRETTY_FUNCTION__, __LINE__,(logStr)]];\
}\
break;\
case ZH_Log_Info:{\
ZHLogInfo(@"%@",(logStr));\
[[ZHShareLog shareZHShareLog]printDebugInfo:[NSString stringWithFormat:@"💧Info: %s [Line %d] %@",__PRETTY_FUNCTION__, __LINE__,(logStr)]];\
}\
break;\
case ZH_Log_Error:{\
ZHLogError(@"%@",(logStr));\
[[ZHShareLog shareZHShareLog]printDebugInfo:[NSString stringWithFormat:@"❌Error: %s [Line %d] %@",__PRETTY_FUNCTION__, __LINE__,(logStr)]];\
}\
break;\
case ZH_Log_Warning:{\
ZHLogWarning(@"%@",(logStr));\
[[ZHShareLog shareZHShareLog]printDebugInfo:[NSString stringWithFormat:@"⚠️Warning: %s [Line %d] %@",__PRETTY_FUNCTION__, __LINE__,(logStr)]];\
}\
break;\
case ZH_Log_Important:{\
ZHLogInfo(@"%@",(logStr));\
[[ZHShareLog shareZHShareLog]printDebugInfo:[NSString stringWithFormat:@"❗️Important: %s [Line %d] %@",__PRETTY_FUNCTION__, __LINE__,(logStr)]];\
}\
break;\
default:\
break;\
}\
}

#ifdef DEBUG
#define ZHLog(fmt, ...) NSLog((fmt),##__VA_ARGS__);

#define ZHLogDebug(fmt, ...) NSLog((@"✅Debug: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ZHLogInfo(fmt, ...) NSLog((@"💧Info: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ZHLogWarning(fmt,...) NSLog((@"⚠️Warning: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ZHLogError(fmt,...) NSLog((@"❌Error: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ZHLogImportant(fmt,...) NSLog((@"❗️Important: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#else
#define ZHLog(fmt, ...){};

#define ZHLogDebug(fmt, ...){};
#define ZHLogInfo(fmt, ...){};
#define ZHLogWarning(fmt,...){};
#define ZHLogError(fmt,...){};
#define ZHLogImportant(fmt,...){};


#endif

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,ZH_Log_Level)
{
    ZH_Log_Error = 0,
    ZH_Log_Info = 1,
    ZH_Log_Warning = 2,
    ZH_Log_Debug = 3,
    ZH_Log_Important = 4,
    ZH_Log_Verblose = 5,
};

@interface ZHShareLog : NSObject

@property (nonatomic) BOOL deBugLog;

+(instancetype)shareZHShareLog;

-(void)printLogWithBuffer:(Byte *)buffer andLength:(NSUInteger)length andLabel:(NSString *)flagStr;
-(void)printDebugInfo:(NSString *)info withLevel:(ZH_Log_Level)level;
-(void)printDebugInfo:(NSString *)info;
-(void)clearAllLogFile;
-(void)clearMonthAgoLogFile;
-(void)clearTodayLog;
@end
