//
//  AppDelegate.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[QMapServices sharedServices].apiKey = @"2XCBZ-X6TR4-GI3U5-DMKKR-MCUHH-CJFVP";
	
	_mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"5UubHmSb2UT2rIPNp7OYqB4z" generalDelegate:nil];
	
	if (!ret) {
		NSLog(@"manager start failed!");
	}
	
	// Required
	if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
		//可以添加自定义categories
		[APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
													   UIUserNotificationTypeSound |
													   UIUserNotificationTypeAlert)
										   categories:nil];
	} else {
		//categories 必须为nil
		[APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
													   UIRemoteNotificationTypeSound |
													   UIRemoteNotificationTypeAlert)
										   categories:nil];
	}
	
	// Required
	[APService setupWithOption:launchOptions];
	
	
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	
	// Required
	[APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
	// Required
	[APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
	
	
	// IOS 7 Support Required
	[APService handleRemoteNotification:userInfo];
	completionHandler(UIBackgroundFetchResultNewData);
}


@end
