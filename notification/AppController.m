//
//  AppController.m
//  notification
//
//  Created by Petter Rasmussen on 7/5/13.
//  Copyright (c) 2013 Petter Rasmussen. All rights reserved.
//

#import "AppController.h"
#import "NSBundle.h"


@implementation AppController

- (void)run {
    [NSApplication sharedApplication];
    [NSApp setDelegate:self];
    [NSApp run];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [NSBundle hook];

    NSArray *argumentList = [[NSProcessInfo processInfo] arguments];
    NSMutableDictionary *args = [NSMutableDictionary dictionary];

    if (argumentList.count == 2) {
        [args setValue:@"Notification" forKey:@"-t"];
        [args setValue:[argumentList objectAtIndex:1] forKey:@"-m"];
    } else {
        for (int i = 1; i < argumentList.count - 1; i += 2) {
            NSString *key = [argumentList objectAtIndex:i];
            NSString *value = [argumentList objectAtIndex:i + 1];
            [args setValue:value forKey:key];
        }
    }

    NSString *title = [args valueForKey:@"-t"];
    NSString *message = [args valueForKey:@"-m"];

    [self sendNotificationWithTitle:title message:message];
}

- (void)sendNotificationWithTitle:(NSString *)title message:(NSString *)message {
    NSUserNotification *notification = [NSUserNotification new];
    notification.title = title;
    notification.informativeText = message;
    notification.hasActionButton = NO;

    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    center.delegate = self;
    [center scheduleNotification:notification];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)userNotification {
    [NSApp terminate:nil];
}

@end
