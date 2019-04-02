//
//  CSUnlocker.m
//  CSUnlocker
//
//  Created by h4ck on 2019/4/2.
//  Copyright (c) 2019年 猿码工作室（https://ymlab.net）. All rights reserved.
//

#import "CSUnlocker.h"
#import <CaptainHook/CaptainHook.h>

// 高级版
CHDeclareClass(CSDataCenter)
CHClassMethod0(NSInteger,CSDataCenter, accountType){
    return 2; // 1：下载试用版本，2：高级订阅版本
}

// 去掉分享时需要登录的提示
CHDeclareClass(ISTSAPI)
CHMethod0(BOOL ,ISTSAPI, isLoggedIn){
    return YES;
}

// 去掉检测余额的逻辑
CHDeclareClass(CSLoggedinViewController)
CHMethod0(void, CSLoggedinViewController, sendCheckBalanceRequest){
    
}

// 去掉进入登录时提示检查失败的弹窗
CHMethod0(NSInteger, CSLoggedinViewController, balance){
    return 0;
}

CHConstructor // code block that runs immediately upon load
{
    NSLog(@"++++++++ CSUnlocker loaded ++++++++");
    CHLoadLateClass(CSDataCenter);
    CHClassHook0(CSDataCenter, accountType);
    
    CHLoadLateClass(ISTSAPI);
    CHHook0(ISTSAPI, isLoggedIn);
    
    CHLoadLateClass(CSLoggedinViewController);
    CHHook0(CSLoggedinViewController, sendCheckBalanceRequest);
    CHHook0(CSLoggedinViewController, balance);
}
