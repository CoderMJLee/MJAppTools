//
//  main.m
//  MJAppTools-iOS
//
//  Created by MJ Lee on 2018/1/27.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "MJAppTools.h"
#import "MJMachO.h"
#import <UIKit/UIKit.h>
#import "MJPrintTools.h"

#define MJPrintNewLine printf("\n")

void list_machO(MJMachO *machO);
void list_apps(MJListAppsType type, NSString *regex);
void init_colors(void);

static NSString *MJPrintColorCount;
static NSString *MJPrintColorNo;
static NSString *MJPrintColorCrypt;
static NSString *MJPrintColorName;
static NSString *MJPrintColorPath;
static NSString *MJPrintColorId;
static NSString *MJPrintColorArch;
static NSString *MJPrintColorTip;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        init_colors();
        
        BOOL gt_ios8 = ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending);
        if (!gt_ios8) {
            [MJPrintTools printError:@"MJAppTools目前只支持iOS8以上系统（包括iOS8）\n"];
            return 0;
        }
    
        if (argc == 1) { // 参数不够
            [MJPrintTools printColor:MJPrintColorTip format:@"  -l <regex>"];
            [MJPrintTools print:@"\t列出用户安装的应用\n"];
            
            [MJPrintTools printColor:MJPrintColorTip format:@"  -le <regex>"];
            [MJPrintTools print:@"\t列出用户安装的"];
            [MJPrintTools printColor:MJPrintColorCrypt format:@"加密"];
            [MJPrintTools print:@"应用\n"];
            
            [MJPrintTools printColor:MJPrintColorTip format:@"  -ld <regex>"];
            [MJPrintTools print:@"\t列出用户安装的"];
            [MJPrintTools printColor:MJPrintColorCrypt format:@"未加密"];
            [MJPrintTools print:@"应用\n"];
            return 0;
        }
        
        const char *firstArg = argv[1];
        if (firstArg[0] == '-' && firstArg[1] == 'l') {
            NSString *regex = nil;
            if (argc > 2) {
                regex = [NSString stringWithUTF8String:argv[2]];
            }
            
            if (strcmp(firstArg, "-le") == 0) {
                list_apps(MJListAppsTypeUserEncrypted, regex);
            } else if (strcmp(firstArg, "-ld") == 0) {
                list_apps(MJListAppsTypeUserDecrypted, regex);
            } else {
                list_apps(MJListAppsTypeUser, regex);
            }
        }
    }
    return 0;
}

void init_colors()
{
    MJPrintColorCount = MJPrintColorMagenta;
    MJPrintColorNo = MJPrintColorDefault;
    MJPrintColorName = MJPrintColorRed;
    MJPrintColorPath = MJPrintColorBlue;
    MJPrintColorCrypt = MJPrintColorMagenta;
    MJPrintColorId = MJPrintColorCyan;
    MJPrintColorArch = MJPrintColorGreen;
    MJPrintColorTip = MJPrintColorCyan;
}

void list_apps(MJListAppsType type, NSString *regex)
{
    [MJAppTools listUserAppsWithType:type regex:regex operation:^(NSArray *apps) {
        [MJPrintTools print:@"# 一共"];
        [MJPrintTools printColor:MJPrintColorCount format:@"%zd", apps.count];
        [MJPrintTools print:@"个"];
        if (type == MJListAppsTypeUserDecrypted) {
            [MJPrintTools printColor:MJPrintColorCrypt format:@"未加密"];
        } else if (type == MJListAppsTypeUserEncrypted) {
            [MJPrintTools printColor:MJPrintColorCrypt format:@"加密"];
        }
        [MJPrintTools print:@"应用"];
        MJPrintNewLine;
        
        for (int i = 0; i < apps.count; i++) {
            MJApp *app = apps[i];
            MJPrintNewLine;
            [MJPrintTools print:@"# "];
            [MJPrintTools printColor:MJPrintColorNo format:@"%02d ", i +1];
            [MJPrintTools print:@"【"];
            [MJPrintTools printColor:MJPrintColorName format:@"%@", app.displayName];
            [MJPrintTools print:@"】 "];
            [MJPrintTools print:@"<"];
            [MJPrintTools printColor:MJPrintColorId format:@"%@", app.bundleIdentifier];
            [MJPrintTools print:@">"];
            
            MJPrintNewLine;
            [MJPrintTools print:@"  "];
            [MJPrintTools printColor:MJPrintColorPath format:app.bundlePath];
            
            if (app.executable.isFat) {
                MJPrintNewLine;
                [MJPrintTools print:@"  "];
                [MJPrintTools printColor:MJPrintColorArch format:@"Universal binary"];
                for (MJMachO *machO in app.executable.machOs) {
                    MJPrintNewLine;
                    printf("      ");
                    list_machO(machO);
                }
            } else {
                MJPrintNewLine;
                [MJPrintTools print:@"  "];
                list_machO(app.executable);
            }
            
            MJPrintNewLine;
        }
    }];
}

void list_machO(MJMachO *machO)
{
    [MJPrintTools printColor:MJPrintColorArch format:machO.architecture];
    if (machO.isEncrypted) {
        [MJPrintTools print:@" "];
        [MJPrintTools printColor:MJPrintColorCrypt format:@"加密"];
    }
}
