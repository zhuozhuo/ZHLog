# ZHLog

ZHLog is  a printing tools for iOS!

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
ZHLog(@"zhlog"); 
ZHLogDebug(@"debug");
ZHLogInfo(@"Info");
ZHLogImportant(@"Important");
ZHLogError(@"error");
ZHLogWarning(@"warning");
ZHLogToFile(@"tofile", ZH_Log_Info);
```



