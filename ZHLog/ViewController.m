//
//  ViewController.m
//  ZHLog
//
//  Created by zhuo on 2018/4/20.
//  Copyright © 2018年 zhuo. All rights reserved.
//

#import "ViewController.h"
#import "ZHShareLog.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZHLog(@"zhlog");
    ZHLogDebug(@"debug");
    ZHLogInfo(@"Info");
    ZHLogImportant(@"Important");
    ZHLogError(@"error");
    ZHLogWarning(@"warning");
    ZHLogToFile(@"tofile", ZH_Log_Info);
    
    for (NSInteger i = 0; i < 100; i++) {
        ZHLogToFile(@"info", ZH_Log_Info);
        ZHLogToFile(@"warning", ZH_Log_Warning);
        ZHLogToFile(@"error", ZH_Log_Error);
        ZHLogToFile(@"important", ZH_Log_Important);
        
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
