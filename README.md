# ZHLog

ZHLog is  a printing tools for iOS,  Simple, quick, convenient!

## Features

- [x] Support to print information in Debug mode, not print in Release mode.
- [x] Support printing method name, line.
- [x] Supports print byte stream.
- [x] The support log is saved to the local and can be exported.
- [x] Support printing information classification: warning, error, debug information, important information, etc.
- [x] Logs are saved by the day, automatically deleted a month ago.
- [x] Support for manual cleanup log.
- [x] Support for secondary development.



## Requirements

- iOS 7.0+
- ARC



## How to use

### [CocoaPods](https://cocoapods.org/) (recommended)

pod 'ZHLog'

### Getting Started

`import <ZHLog/ZHShareLog.h>`



####Example Usage

```objective-c
ZHLog(@"zhlog"); //The print information
ZHLogDebug(@"debug"); //debug the information, along with the name of the function, the line, and so on.
ZHLogInfo(@"Info");//Print the information, along with the name of the function, the line, and so on.
ZHLogImportant(@"Important");//Print important information, along with the name of the function, the line and so on.
ZHLogError(@"error");//Print the error message, along with the name of the function, the line, and so on.
ZHLogWarning(@"warning");//Print the warning message, along with the name of the function, the line, and so on.
ZHLogToFile(@"tofile", ZH_Log_Info);//Print the information, attach the name of the function, the line, and so on, and save it to the log.

[[ZHShareLog shareZHShareLog]printDebugInfo:@"Info" withLevel:ZH_Log_Error];//Print different types of information.

```

#### Log type

```c
typedef NS_ENUM(NSInteger,ZH_Log_Level)
{
    ZH_Log_Error = 0,
    ZH_Log_Info = 1,
    ZH_Log_Warning = 2,
    ZH_Log_Debug = 3,
    ZH_Log_Important = 4,
    ZH_Log_Verblose = 5,
};
```

#### Clear the log

```c
-(void)clearAllLogFile;
-(void)clearMonthAgoLogFile;
-(void)clearTodayLog;
```



####  Print binary stream data.

```objective-c
-(void)printLogWithBuffer:(Byte *)buffer andLength:(NSUInteger)length andLabel:(NSString *)flagStr;
```



#### Xcode terminal prints the screenshot

```objective-c
2018-04-21 11:42:03.260219+0800 ZHLog[75592:3057889] zhlog
2018-04-21 11:42:03.260355+0800 ZHLog[75592:3057889] ✅Debug: -[ViewController viewDidLoad] [Line 26] debug
2018-04-21 11:42:03.260438+0800 ZHLog[75592:3057889] 💧Info: -[ViewController viewDidLoad] [Line 27] Info
2018-04-21 11:42:03.260523+0800 ZHLog[75592:3057889] ❗️Important: -[ViewController viewDidLoad] [Line 28] Important
2018-04-21 11:42:03.260620+0800 ZHLog[75592:3057889] ❌Error: -[ViewController viewDidLoad] [Line 29] error
2018-04-21 11:42:03.260725+0800 ZHLog[75592:3057889] ⚠️Warning: -[ViewController viewDidLoad] [Line 30] warning
2018-04-21 11:42:03.260800+0800 ZHLog[75592:3057889] ✅Debug: -[ViewController viewDidLoad] [Line 33] tofile debug
2018-04-21 11:42:03.265322+0800 ZHLog[75592:3057889] 💧Info: -[ViewController viewDidLoad] [Line 34] tofile info
2018-04-21 11:42:03.265828+0800 ZHLog[75592:3057889] ⚠️Warning: -[ViewController viewDidLoad] [Line 35] tofile warning
2018-04-21 11:42:03.266318+0800 ZHLog[75592:3057889] ❌Error: -[ViewController viewDidLoad] [Line 36] tofile error
2018-04-21 11:42:03.266805+0800 ZHLog[75592:3057889] 💧Info: -[ViewController viewDidLoad] [Line 37] tofile important
2018-04-21 11:42:03.267331+0800 ZHLog[75592:3057889] ✅Debug: -[ViewController viewDidLoad] [Line 33] tofile debug
```



#### The log file prints the screenshot.

```
2018-04-21 11:38:06:✅Debug: -[ViewController viewDidLoad] [Line 33] tofile debug
2018-04-21 11:38:06:💧Info: -[ViewController viewDidLoad] [Line 34] tofile info
2018-04-21 11:38:06:⚠️Warning: -[ViewController viewDidLoad] [Line 35] tofile warning
2018-04-21 11:38:06:❌Error: -[ViewController viewDidLoad] [Line 36] tofile error
2018-04-21 11:38:06:❗️Important: -[ViewController viewDidLoad] [Line 37] tofile important
2018-04-21 11:38:06:✅Debug: -[ViewController viewDidLoad] [Line 33] tofile debug
2018-04-21 11:38:06:💧Info: -[ViewController viewDidLoad] [Line 34] tofile info
2018-04-21 11:38:06:⚠️Warning: -[ViewController viewDidLoad] [Line 35] tofile warning
2018-04-21 11:38:06:❌Error: -[ViewController viewDidLoad] [Line 36] tofile error
2018-04-21 11:38:06:❗️Important: -[ViewController viewDidLoad] [Line 37] tofile important
```

