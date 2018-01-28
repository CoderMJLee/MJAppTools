//
//  MJPrintTools.m
//  MJAppTools
//
//  Created by MJ Lee on 2018/1/28.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "MJPrintTools.h"

const NSString *MJPrintColorDefault = @"\033[0m";

const NSString *MJPrintColorRed = @"\033[1;31m";
const NSString *MJPrintColorGreen = @"\033[1;32m";
const NSString *MJPrintColorBlue = @"\033[1;34m";
const NSString *MJPrintColorWhite = @"\033[1;37m";
const NSString *MJPrintColorBlack = @"\033[1;30m";
const NSString *MJPrintColorYellow = @"\033[1;33m";
const NSString *MJPrintColorCyan = @"\033[1;36m";
const NSString *MJPrintColorMagenta = @"\033[1;35m";

const NSString *MJPrintColorWarning = @"\033[1;33m";
const NSString *MJPrintColorError = @"\033[1;31m";
const NSString *MJPrintColorStrong = @"\033[1;32m";

@implementation MJPrintTools

+ (void)printError:(NSString *)format, ...
{
    if (!format) return;
    
    [self printColor:(NSString *)MJPrintColorError format:format];
}

+ (void)printWarning:(NSString *)format, ...
{
    if (!format) return;
    
    [self printColor:(NSString *)MJPrintColorWarning format:format];
}

+ (void)printStrong:(NSString *)format, ...
{
    if (!format) return;
    
    [self printColor:(NSString *)MJPrintColorStrong format:format];
}

+ (void)print:(NSString *)format, ...
{
    if (!format) return;
    
    [self printColor:nil format:format];
}

+ (void)printColor:(NSString *)color format:(NSString *)format, ...
{
    if (!format) return;
    
    va_list args;
    va_start(args, format);
    NSString *formatStr = [[NSString alloc] initWithFormat:format arguments:args];
    NSString *printStr = nil;
    
    if (color) {
        printStr = [color stringByAppendingString:formatStr];
    } else {
        printStr = [MJPrintColorDefault stringByAppendingString:formatStr];
    }
    
    printStr = [printStr stringByAppendingString:(NSString *)MJPrintColorDefault];
    
    printf("%s", printStr.UTF8String);
    va_end(args);
}

@end
