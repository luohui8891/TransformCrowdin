//
//  main.m
//  TransformCrowdin
//
//  Created by LuoHui on 15/3/14.
//  Copyright (c) 2015年 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSDictionary * configurationHash = nil;

static NSString * originDir = @"tapatalk-all";

static NSString * iosOriginDir = @"Tapatalk for  iPhone";
static NSString * iosFileName = @"Localizable.strings";
static NSString * iosDestDir = @"ios";

static NSString * androidOriginDir = @"Tapatalk for Android";
static NSString * androidFileName = @"strings.xml";
static NSString * androidDestDir = @"android";

#define iosMapKey  iosDestDir
#define androidMapKey androidDestDir

void createParameter(void){
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configurationHash = @{@"el": @{iosMapKey: @"el.lproj", androidMapKey: @"values-el-rGR"},
                              @"he": @{iosMapKey: @"he.lproj", androidMapKey: @"values-he"},
                              @"no": @{iosMapKey: @"no.lproj", androidMapKey: @"values-nb-rNO"},
                              @"sr": @{iosMapKey: @"sr.lproj", androidMapKey: @"values-sr"},
                              @"hr": @{iosMapKey: @"hr.lproj", androidMapKey: @"values-hr"},
                              @"pl": @{iosMapKey: @"pl.lproj", androidMapKey: @"values-pl"},
                              @"sv-SE": @{iosMapKey: @"sv.lproj", androidMapKey: @"values-sv"},
                              @"ar": @{iosMapKey: @"ar.lproj", androidMapKey: @"values-ar"},
                              @"en-GB": @{iosMapKey: @"en-GB.lproj", androidMapKey: @"values-en-rGB"},
                              @"hu": @{iosMapKey: @"hu.lproj", androidMapKey: @"values-hu"},
                              @"pt-BR": @{iosMapKey: @"pt.lproj", androidMapKey: @"values-pt-rBR"},
                              @"tr": @{iosMapKey: @"tr.lproj", androidMapKey: @"values-tr"},
                              @"bg": @{iosMapKey: @"bg.lproj", androidMapKey: @"values-bg"},
                              @"es-ES": @{iosMapKey: @"es.lproj", androidMapKey: @"values-es"},
                              @"it": @{iosMapKey: @"it.lproj", androidMapKey: @"values-it"},
                              @"pt-PT": @{iosMapKey: @"pt-PT.lproj", androidMapKey: @"values-pt"},
                              @"uk": @{iosMapKey: @"uk.lproj", androidMapKey: @"values-uk"},
                              @"ca": @{iosMapKey: @"ca.lproj", androidMapKey: @"values-ca"},
                              @"fa": @{iosMapKey: @"fa.lproj", androidMapKey: @"values-fa"},
                              @"ja": @{iosMapKey: @"ja.lproj", androidMapKey: @"values-ja"},
                              @"ro": @{iosMapKey: @"ro.lproj", androidMapKey: @"values-ro"},
                              @"vi": @{iosMapKey: @"vi.lproj", androidMapKey: @"values-vi"},
                              @"cs": @{iosMapKey: @"cs.lproj", androidMapKey: @"values-cs"},
                              @"fi": @{iosMapKey: @"fi.lproj", androidMapKey: @"values-fi"},
                              @"ko": @{iosMapKey: @"ko.lproj", androidMapKey: @"values-ko-rKR"},
                              @"ru": @{iosMapKey: @"ru.lproj", androidMapKey: @"values-ru"},
                              @"zh-CN": @{iosMapKey: @"zh-Hans.lproj", androidMapKey: @"values-zh-rCN"},
                              @"da": @{iosMapKey: @"da.lproj", androidMapKey: @"values-da"},
                              @"fr": @{iosMapKey: @"fr.lproj", androidMapKey: @"values-fr"},
                              @"lt": @{iosMapKey: @"lt.lproj", androidMapKey: @"values-lt"},
                              @"sk": @{iosMapKey: @"sk.lproj", androidMapKey: @"values-sk"},
                              @"zh-TW": @{iosMapKey: @"zh-Hant.lproj", androidMapKey: @"values-zh-rHK"},
                              @"de": @{iosMapKey: @"de.lproj", androidMapKey: @"values-de"},
                              @"gl": @{iosMapKey: @"gl.lproj", androidMapKey: @"values-gl"},
                              @"nl": @{iosMapKey: @"nl.lproj", androidMapKey: @"values-nl"},
                              @"sl": @{iosMapKey: @"sl.lproj", androidMapKey: @"values-sl"}};
    });
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        createParameter();
        NSFileManager * fm = [NSFileManager new];
        NSString * bundlePath = [[NSBundle mainBundle] bundlePath];
        NSString * dirPath = [bundlePath stringByAppendingPathComponent:originDir];
       
        if ([fm fileExistsAtPath:dirPath]) {
            NSArray * dirArray = [fm contentsOfDirectoryAtPath:dirPath error:nil];
            for (NSString * subDir in dirArray) {
                NSDictionary * map = configurationHash[subDir];
                if (map) {
                    NSString * absSubPath = [dirPath stringByAppendingPathComponent:subDir];
                    
                    NSString * iosDirPath = [absSubPath stringByAppendingPathComponent:iosOriginDir];
                    NSString * androidPath = [absSubPath stringByAppendingPathComponent:androidOriginDir];
                    
                    NSString * iosFilePath = [iosDirPath stringByAppendingPathComponent:iosFileName];
                    NSString * androidFilePath = [androidPath stringByAppendingPathComponent:androidFileName];
                    
                    // copy ios
                    NSArray * keyList = @[iosMapKey, androidMapKey];
                    NSArray * filePathList = @[iosFilePath,
                                               androidFilePath];
                    for (NSString * key in keyList) {
                        NSInteger index = [keyList indexOfObject:key];
                        NSString * langDir = map[key];
                        
                        // get origin file path
                        NSString * originFilePath = filePathList[index];
                        
                        // get dest file path
                        NSString * dirPath = [bundlePath stringByAppendingPathComponent:key];
                        NSString * destPath = [dirPath stringByAppendingPathComponent:langDir];
                        NSString * destFilePath = [destPath stringByAppendingPathComponent:[originFilePath lastPathComponent]];
                        
                        // check dest dir
                        if ([fm fileExistsAtPath:destPath] == NO) {
                            [fm createDirectoryAtPath:destPath withIntermediateDirectories:YES attributes:nil error:nil];
                        } else {
                            [fm removeItemAtPath:destFilePath error:nil];
                        }
                        
                        // copy file
                        [fm copyItemAtPath:originFilePath toPath:destFilePath error:nil];
                        
                        // additional copy
                        if ([langDir rangeOfString:@"values-zh-rHK"].location != NSNotFound) {
                            langDir = @"values-zh-rTW";
                            destPath = [dirPath stringByAppendingPathComponent:langDir];
                            NSString * destFilePath = [destPath stringByAppendingPathComponent:[originFilePath lastPathComponent]];
                            if ([fm fileExistsAtPath:destPath] == NO) {
                                [fm createDirectoryAtPath:destPath withIntermediateDirectories:YES attributes:nil error:nil];
                            } else {
                                [fm removeItemAtPath:destFilePath error:nil];
                            }
                            [fm copyItemAtPath:originFilePath toPath:destFilePath error:nil];
                        }

                    }
                    
                }
            }
        }
    }
    return 0;
}
