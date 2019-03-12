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
static NSString * iosFileName = @"TKLocalizable.strings";
static NSString * iosDestDir = @"ios";

static NSString * androidOriginDir = @"Tapatalk for Android";
static NSString * androidFileName = @"strings.xml";
static NSString * androidDestDir = @"android";

static NSString * topifyOriginDir = @"Topify";
static NSString * topifyFileName = @"translation.json";
static NSString * topifyDestDir = @"Topify";

#define iosMapKey  iosDestDir
#define androidMapKey androidDestDir
#define topifyMapKey topifyDestDir

void createParameter(void){
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configurationHash = @{@"el": @{iosMapKey: @"el.lproj", androidMapKey: @"values-el-rGR", topifyMapKey: @"el"},
                              @"he": @{iosMapKey: @"he.lproj", androidMapKey: @"values-he", topifyMapKey: @"he"},
                              @"no": @{iosMapKey: @"no.lproj", androidMapKey: @"values-nb-rNO", topifyMapKey: @"no"},
                              @"sr": @{iosMapKey: @"sr.lproj", androidMapKey: @"values-sr", topifyMapKey: @"sr"},
                              @"hr": @{iosMapKey: @"hr.lproj", androidMapKey: @"values-hr", topifyMapKey: @"hr"},
                              @"pl": @{iosMapKey: @"pl.lproj", androidMapKey: @"values-pl", topifyMapKey: @"pl"},
                              @"sv-SE": @{iosMapKey: @"sv.lproj", androidMapKey: @"values-sv", topifyMapKey: @"sv-SE"},
                              @"ar": @{iosMapKey: @"ar.lproj", androidMapKey: @"values-ar", topifyMapKey: @"ar"},
                              @"en-GB": @{iosMapKey: @"en-GB.lproj", androidMapKey: @"values-en-rGB", topifyMapKey: @"en-GB"},
                              @"hu": @{iosMapKey: @"hu.lproj", androidMapKey: @"values-hu", topifyMapKey: @"hu"},
                              @"pt-BR": @{iosMapKey: @"pt.lproj", androidMapKey: @"values-pt-rBR", topifyMapKey: @"pt-BR"},
                              @"tr": @{iosMapKey: @"tr.lproj", androidMapKey: @"values-tr", topifyMapKey: @"tr"},
                              @"bg": @{iosMapKey: @"bg.lproj", androidMapKey: @"values-bg", topifyMapKey: @"bg"},
                              @"es-ES": @{iosMapKey: @"es.lproj", androidMapKey: @"values-es", topifyMapKey: @"es-ES"},
                              @"it": @{iosMapKey: @"it.lproj", androidMapKey: @"values-it", topifyMapKey: @"it"},
                              @"pt-PT": @{iosMapKey: @"pt-PT.lproj", androidMapKey: @"values-pt", topifyMapKey: @"pt-PT"},
                              @"uk": @{iosMapKey: @"uk.lproj", androidMapKey: @"values-uk", topifyMapKey: @"uk"},
                              @"ca": @{iosMapKey: @"ca.lproj", androidMapKey: @"values-ca", topifyMapKey: @"ca"},
                              @"fa": @{iosMapKey: @"fa.lproj", androidMapKey: @"values-fa", topifyMapKey: @"fa"},
                              @"ja": @{iosMapKey: @"ja.lproj", androidMapKey: @"values-ja", topifyMapKey: @"ja"},
                              @"ro": @{iosMapKey: @"ro.lproj", androidMapKey: @"values-ro", topifyMapKey: @"ro"},
                              @"vi": @{iosMapKey: @"vi.lproj", androidMapKey: @"values-vi", topifyMapKey: @"vi"},
                              @"cs": @{iosMapKey: @"cs.lproj", androidMapKey: @"values-cs", topifyMapKey: @"cs"},
                              @"fi": @{iosMapKey: @"fi.lproj", androidMapKey: @"values-fi", topifyMapKey: @"fi"},
                              @"ko": @{iosMapKey: @"ko.lproj", androidMapKey: @"values-ko-rKR", topifyMapKey: @"ko"},
                              @"ru": @{iosMapKey: @"ru.lproj", androidMapKey: @"values-ru", topifyMapKey: @"ru"},
                              @"zh-CN": @{iosMapKey: @"zh-Hans.lproj", androidMapKey: @"values-zh-rCN", topifyMapKey: @"zh-CN"},
                              @"da": @{iosMapKey: @"da.lproj", androidMapKey: @"values-da", topifyMapKey: @"da"},
                              @"fr": @{iosMapKey: @"fr.lproj", androidMapKey: @"values-fr", topifyMapKey: @"fr"},
                              @"lt": @{iosMapKey: @"lt.lproj", androidMapKey: @"values-lt", topifyMapKey: @"lt"},
                              @"sk": @{iosMapKey: @"sk.lproj", androidMapKey: @"values-sk", topifyMapKey: @"sk"},
                              @"zh-TW": @{iosMapKey: @"zh-Hant.lproj", androidMapKey: @"values-zh-rHK", topifyMapKey: @"zh-TW"},
                              @"de": @{iosMapKey: @"de.lproj", androidMapKey: @"values-de", topifyMapKey: @"de"},
                              @"gl": @{iosMapKey: @"gl.lproj", androidMapKey: @"values-gl", topifyMapKey: @"gl"},
                              @"nl": @{iosMapKey: @"nl.lproj", androidMapKey: @"values-nl", topifyMapKey: @"nl"},
                              @"sl": @{iosMapKey: @"sl.lproj", androidMapKey: @"values-sl", topifyMapKey: @"sl"},};
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
                    NSString * topifyDirPath = [absSubPath stringByAppendingPathComponent:topifyOriginDir];
                    
                    NSString * iosFilePath = [iosDirPath stringByAppendingPathComponent:iosFileName];
                    NSString * androidFilePath = [androidPath stringByAppendingPathComponent:androidFileName];
                    NSString * topifyFilePath = [topifyDirPath stringByAppendingPathComponent:topifyFileName];

                    // copy ios
                    NSArray * keyList = @[iosMapKey, androidMapKey, topifyMapKey];
                    NSArray * filePathList = @[iosFilePath,
                                               androidFilePath,
                                               topifyFilePath];
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
