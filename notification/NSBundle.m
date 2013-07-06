//
//  NSBundle.m
//  notification
//
//  Created by Petter Rasmussen on 7/6/13.
//  Copyright (c) 2013 Petter Rasmussen. All rights reserved.
//

#import "NSBundle.h"


@implementation NSBundle(Notification)

- (NSString *)__bundleIdentifier {
    if (self == [NSBundle mainBundle]) {
        return @"com.apple.terminal";
    } else {
        return [self __bundleIdentifier];
    }
}

+ (BOOL)hook {
    Class class = objc_getClass("NSBundle");
    if (class) {
        method_exchangeImplementations(class_getInstanceMethod(class, @selector(bundleIdentifier)),
                                       class_getInstanceMethod(class, @selector(__bundleIdentifier)));
        return YES;
    }
	return NO;
}

@end
