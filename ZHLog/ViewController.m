//
//  ViewController.m
//  ZHLog
//
//  Created by zhuo on 2018/4/20.
//  Copyright © 2018年 zhuo. All rights reserved.
//

#import "ViewController.h"
#import "ZHShareLog.h"
@interface ViewController (){
    NSArray *functions;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZHLog";
    self.showTableView.tableFooterView = [UIView new];
    [self initDatas];
  
    ZHLog(@"zhlog");
    ZHLogDebug(@"debug");
    ZHLogInfo(@"Info");
    ZHLogImportant(@"Important");
    ZHLogError(@"error");
    ZHLogWarning(@"warning");
    
    for (NSInteger i = 0; i<10; i++) {
        ZHLogToFile(@"tofile debug", ZH_Log_Debug);
        ZHLogToFile(@"tofile info", ZH_Log_Info);
        ZHLogToFile(@"tofile warning", ZH_Log_Warning);
        ZHLogToFile(@"tofile error", ZH_Log_Error);
        ZHLogToFile(@"tofile important", ZH_Log_Important);
    }
    
   
    
        
  
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - initDatas

-(void)initDatas
{
    functions = @[@"Clear all logs",@"Clear today‘s Logs",@"Clear the logs a month ago"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return functions.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    NSString *title = [functions objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            [[ZHShareLog shareZHShareLog]clearAllLogFile];
        }
            
            break;
        case 1:{
            [[ZHShareLog shareZHShareLog]clearTodayLog];
        }
            
            break;
        case 2:{
            [[ZHShareLog shareZHShareLog]clearMonthAgoLogFile];
        }
            
            break;
        default:
            break;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
