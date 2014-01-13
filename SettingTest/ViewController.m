//
//  ViewController.m
//  SettingTest
//
//  Created by SDT-1 on 2014. 1. 13..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lbl;
@end

@implementation ViewController {
    sqlite3 *db;
}
- (void)openDB {
    NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:@"db" ofType:@"sqlite"];
    int ret = sqlite3_open([dbFilePath UTF8String], &db);
    NSAssert1(SQLITE_OK == ret, @"Error on operning Database: %s", sqlite3_errmsg(db));
    NSLog(@"Success");
}

- (void)selectMessages {
    NSString *queryStr = @"SELECT * from message";
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare(db, [queryStr UTF8String], -1, &stmt, NULL);
    while (SQLITE_ROW == sqlite3_step(stmt)) {
        char *sender = (char *)sqlite3_column_text(stmt, 0);
        NSString *senderString = [NSString stringWithCString:sender encoding:NSUTF8StringEncoding];
        NSLog(@"sender : %@", senderString);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *name = [defaults objectForKey:@"name_preference"];
//    NSLog(@"%@", name);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self openDB];
    [self selectMessages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
