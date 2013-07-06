//
//  main.m
//  notification
//
//  Created by Petter Rasmussen on 7/5/13.
//  Copyright (c) 2013 Petter Rasmussen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppController.h"


void printUsage(const char *appName) {
    printf("Usage:\n");
    printf("%s <message>\n", appName);
    printf("%s -t <title> -m <message>\n", appName);
    exit(EXIT_FAILURE);
}

BOOL hasKey(const char *argv[], char *key, int size) {
    for (int i = 1; i < size; i++) {
        if (strncmp(argv[i], key, 2) == 0) {
            return YES;
        }
    }
    return NO;
}

int main(int argc, const char *argv[]) {
    if (argc != 2 && argc != 5) {
        printUsage(argv[0]);
    }

    if (argc == 5) {
        if (!hasKey(argv, "-m", argc) || !hasKey(argv, "-t", argc)) {
            printUsage(argv[0]);
        }
    }

    @autoreleasepool {
        [[AppController new] run];
    }
    return 0;
}