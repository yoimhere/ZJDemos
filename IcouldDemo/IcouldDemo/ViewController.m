//
//  ViewController.m
//  IcouldDemo
//
//  Created by admin  on 2018/8/21.
//  Copyright © 2018年 OneByte. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) NSUbiquitousKeyValueStore *keyStore;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupIcouldKetValueStore];
}

- (void)setupIcouldKetValueStore
{
    self.keyStore = [NSUbiquitousKeyValueStore defaultStore];
    //注册通知中心，当配置发生改变的时候，发生通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(ubiquitousKeyValueStoreDidChange:)
                   name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                 object:self.keyStore];
    
    self.textField.delegate = self;
    self.textLabel.text = [self.keyStore stringForKey:@"MyString"];
}

- (IBAction)changeKey
{
    [self.keyStore setString:self.textField.text forKey:@"MyString"];
    [self.keyStore synchronize];
    NSLog(@"Save key");
}

/* 监听通知，当配置发生改变的时候会调用 */
- (void)ubiquitousKeyValueStoreDidChange:(NSNotification *)notification
{
    NSLog(@"ubiquitousKeyValueStoreDidChange");
    
    //获取通知的原因
    // NSUbiquitousKeyValueStoreServerChange 0
    // NSUbiquitousKeyValueStoreInitialSyncChange
    // NSUbiquitousKeyValueStoreQuotaViolationChange
    // NSUbiquitousKeyValueStoreAccountChange
    int reason     =  [notification.userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] intValue];
    NSLog(@"reason:%d",reason);

    //获取改变的值
    NSArray *keys = notification.userInfo[NSUbiquitousKeyValueStoreChangedKeysKey];
    for (NSString *key in keys) {
        NSLog(@"key:%@",key);
    }

    //显示改变的信息
    self.textLabel.text = [self.keyStore stringForKey:@"MyString"];
}

#pragma - mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:true];
    return true;
}


@end
