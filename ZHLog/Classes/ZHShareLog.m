//
//  ZHShareLog.m
//  iMCOBandRealTekSDK_iOS
//
//  Created by zhuo on 2015/5/24.
//  Copyright © 2015年 zhuo. All rights reserved.
//

#import "ZHShareLog.h"

@interface ZHShareLog ()
@property (nonatomic, strong) NSDateFormatter *parser;

@end
@implementation ZHShareLog

+(instancetype)shareZHShareLog
{
    static ZHShareLog *realTekCommon = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        realTekCommon = [[ZHShareLog alloc]init];
        
    });
    return realTekCommon;

}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.deBugLog = YES;
        self.parser = [[NSDateFormatter alloc] init];
        self.parser.dateStyle = NSDateFormatterNoStyle;
        self.parser.timeStyle = NSDateFormatterNoStyle;
        [self clearMonthAgoLogFile];
    }
    return self;
}




-(uint32_t )getDateValueWithYear:(uint8_t)year withMonth:(uint8_t)month withDay:(uint8_t)day withHour:(uint8_t)hour withMinute:(uint8_t)minute withSecond:(uint8_t)second
{
    uint32_t dateValue = (year << 26) + (month << 22) + (day << 17) + (hour << 12)  + (minute << 6) + second;
    return dateValue;
}



#pragma mark - Print
-(void)printLogWithBuffer:(Byte *)buffer andLength:(NSUInteger)length andLabel:(NSString *)flagStr
{
    if (self.deBugLog) {
        NSMutableString *s = [[NSMutableString alloc] initWithFormat:@"%@ %lu: [", flagStr,(unsigned long)length];
        
        for (NSUInteger i=0; i<length; i++) {
            [s appendString:[NSString stringWithFormat:@"%02x ", buffer[i]]];
        }
        [s appendString:@"]"];
        [[ZHShareLog shareZHShareLog]printDebugInfo:s withLevel:ZH_Log_Debug];
    }
    
}

-(void)printDataBytes:(NSData *)data
{
    if (self.deBugLog) {
        const char *byte = [data bytes];
        NSUInteger length = [data length];
        for (int i=0; i<length; i++) {
            char n = byte[i];
            char buffer[9];
            buffer[8] = 0; //for null
            int j = 8;
            while(j > 0)
            {
                if(n & 0x01)
                {
                    buffer[--j] = '1';
                } else
                {
                    buffer[--j] = '0';
                }
                n >>= 1;
            }
            printf("%s ",buffer);
        }

    }
}

-(void)printDebugInfo:(NSString *)info
{
     if (self.deBugLog && info) {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             [self writeLogToFile:info];
         });
     }
}

-(void)printDebugInfo:(NSString *)info withLevel:(ZH_Log_Level)level
{
    if (self.deBugLog) {
        NSString *preString = @"XYDebug*****";
        NSString *remindString = @"💧Info";
        switch (level) {
            case ZH_Log_Info:
                remindString = @"💧Info";
                break;
            case ZH_Log_Debug:
                remindString = @"✅Debug";
                break;
            case ZH_Log_Error:
                remindString = @"❌Error";
                break;
            case ZH_Log_Warning:
                remindString = @"⚠️Warning";
                break;
            case ZH_Log_Important:
                remindString = @"❗️Important";
                break;
            case ZH_Log_Verblose:
                remindString = @"🔤Verbose";
                break;
                
            default:
                break;
        }
        NSString *logString = [NSString stringWithFormat:@"%@%@ %@",preString,remindString,info];
        NSLog(@"%@",logString);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self writeLogToFile:logString];
        });
    }
}


#pragma mark - Log File

-(void)clearAllLogFile
{
    NSString *path = [self getLogPath];
    if ([self isFileExists:path]) {
        [self rmFilePath:path];
    }
}

-(void)clearMonthAgoLogFile
{
    NSString *path = [self getLogPath];
    if ([self isFileExists:path]) {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSError *error;
        NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:&error];
        if (error) {
            NSString *info = [NSString stringWithFormat:@"Clear Month ago logs error:%@",error.localizedDescription];
            NSLog(@"%@",info);
        }
        if (fileNames) {
            [fileNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger index, BOOL *stop){
                NSString *preName = [name componentsSeparatedByString:@"."].firstObject;
                NSDate *date = [self dateWithString:preName formatString:@"yyyy-MM-dd" timeZone:[NSTimeZone systemTimeZone]];
                NSDate *now = [NSDate date];
                long long timeInterval = [now timeIntervalSinceDate:date];
                if (timeInterval >= (30*24*60*60)) {
                    NSString *info = [NSString stringWithFormat:@"Will Delete log file name:%@-prename:%@",name,preName];
                    [self printDebugInfo:info withLevel:ZH_Log_Warning];
                    NSString *filePath = [self getLogFilePathWithFileName:preName];
                    if ([self isFileExists:filePath]) {
                        [self rmFilePath:filePath];
                    }
                }
                
            }];
        }
    }
}


-(void)clearTodayLog
{
    NSString *path = [self getLogPath];
    if ([self isFileExists:path]) {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSError *error;
        NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:&error];
        if (error) {
            NSString *info = [NSString stringWithFormat:@"Clear Month ago logs error:%@",error.localizedDescription];
            NSLog(@"%@",info);
        }
        if (fileNames) {
            [fileNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger index, BOOL *stop){
                NSString *preName = [name componentsSeparatedByString:@"."].firstObject;
                NSString *todayFileName = [self getTodayLogFileName];
                if ([preName isEqualToString:todayFileName]) {
                    NSString *filePath = [self getLogFilePathWithFileName:preName];
                    if ([self isFileExists:filePath]) {
                        [self rmFilePath:filePath];
                    }
                }
            }];
        }
    }

}


-(void)writeLogToFile:(NSString *)logInfo
{
    NSString *path = [self getTodayLogFilePath];
    NSDate *now = [NSDate date];
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *timeString = [self getStringWithDate:now formatString:dateFormat timeZone:[NSTimeZone systemTimeZone]];
    if (![self isFileExists:path]) {
        NSError *error;
        NSString *titleString = [NSString stringWithFormat:@"## Start Time %@",timeString];
        [titleString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSString *info = [NSString stringWithFormat:@"Write log file error:%@",error.localizedDescription];
            NSLog(@"%@",info);
        }
        [self addSkipBackupAttributeWithPath:path];
    }
    
    NSString *writeString = [NSString stringWithFormat:@"\n%@:%@",timeString,logInfo];
    @synchronized (writeString) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:path];
        [fileHandle seekToEndOfFile];//将节点跳到文件末尾
        NSData *stringData = [writeString dataUsingEncoding:NSUTF8StringEncoding];
        [fileHandle writeData:stringData];
    }
    
}


-(BOOL)isFileExists:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:path];
}



-(void)rmFilePath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:path]) {
        NSError *error;
        [fm removeItemAtPath:path error:&error];
        if (error) {
            NSString *info = [NSString stringWithFormat:@"Delete Log path error:%@",error.localizedDescription];
            NSLog(@"%@",info);
        }
    }
}

-(NSString *)getTodayLogFilePath
{
    NSString *fileName = [self getTodayLogFileName];
    NSString *filePath = [self getLogFilePathWithFileName:fileName];
    return filePath;
}


-(NSString *)getLogFilePathWithFileName:(NSString *)fileName
{
    NSString *logPath = [self getLogPath];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.txt",logPath,fileName];
    //NSLog(@"filePath:%@",filePath);
    return filePath;
}

-(NSString *)getLogPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths firstObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/Logs",documentPath];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if (![fm fileExistsAtPath:filePath isDirectory:&isDir]) {
        NSError *error = nil;
        [fm createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSString *info = [NSString stringWithFormat:@"create log dir error:%@",error.localizedDescription];
            NSLog(@"%@",info);
        }
        [self addSkipBackupAttributeWithPath:filePath];
    }
    return filePath;
}

-(NSString *)getTodayLogFileName
{
    NSDate *date = [NSDate date];
    NSString *dateFormat = @"yyyy-MM-dd";
    NSString *fileName = [self getStringWithDate:date formatString:dateFormat timeZone:[NSTimeZone systemTimeZone]];
    //NSLog(@"today fileName:%@",fileName);
    return fileName;
}


- (NSString *)getStringWithDate:(NSDate *)date formatString:(NSString *)formatString timeZone:(NSTimeZone *)timeZone {
    
    if (formatString && date) {
        @synchronized (self.parser) {
            self.parser.timeZone = timeZone;
            self.parser.dateFormat = formatString;
            return [self.parser stringFromDate:date];
        }
    }
    return nil;
}


-(NSDate *)dateWithString:(NSString *)dateString formatString:(NSString *)formatString timeZone:(NSTimeZone *)timeZone
{
    if (dateString && formatString) {
        self.parser.timeZone = timeZone;
        self.parser.dateFormat = formatString;
        return [self.parser dateFromString:dateString];
    }else{
        return nil;
    }
    
}


- (BOOL)addSkipBackupAttributeWithPath:(NSString *)filePathString
{
    NSURL *URL = [NSURL fileURLWithPath:filePathString];
    assert([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES]
                                  forKey:NSURLIsExcludedFromBackupKey
                                   error:&error];
    if (!success) {
      NSString *info = [NSString stringWithFormat:@"Error excluding %@ from backup %@", [URL lastPathComponent], error] ;
        [self printDebugInfo:info withLevel:ZH_Log_Error];
    }
    return success;
}


@end
