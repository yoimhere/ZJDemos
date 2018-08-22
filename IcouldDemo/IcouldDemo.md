## Key-Value的iCloud存储

1. 获取默认实例

```
    keyStore = [NSUbiquitousKeyValueStore defaultStore]
```

2.监听

```
NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
[center addObserver:self selector:@selector(valueStoreDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:keyStore];
```

3.监听回调

```
- (void)valueStoreDidChange:(NSNotification *)notification
{
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
}
```


## Document的iCloud存储
> 文档存储主要是使用UIDocument类来完成，这个类提供了新建、修改、查询文档、打开文档、删除文档的功能。




