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
        configurationHash = @{@"el": @{iosMapKey: @"el", androidMapKey: @"values-el-rGR"},
                              @"he": @{iosMapKey: @"he", androidMapKey: @"values-he"},
                              @"no": @{iosMapKey: @"no", androidMapKey: @"values-nb-rNO"},
                              @"sr": @{iosMapKey: @"sr", androidMapKey: @"values-sr"},
                              @"en": @{iosMapKey: @"en", androidMapKey: @"values-en"},
                              @"hr": @{iosMapKey: @"hr", androidMapKey: @"values-hr"},
                              @"pl": @{iosMapKey: @"pl", androidMapKey: @"values-pl"},
                              @"sv-SE": @{iosMapKey: @"sv-SE", androidMapKey: @"values-sv"},
                              @"ar": @{iosMapKey: @"ar", androidMapKey: @"values-ar"},
                              @"en-GB": @{iosMapKey: @"en-GB", androidMapKey: @"values-en-rGB"},
                              @"hu": @{iosMapKey: @"hu", androidMapKey: @"values-hu"},
                              @"pt-BR": @{iosMapKey: @"pt", androidMapKey: @"values-pt-rBR"},
                              @"tr": @{iosMapKey: @"tr", androidMapKey: @"values-tr"},
                              @"bg": @{iosMapKey: @"bg", androidMapKey: @"values-bg"},
                              @"es-ES": @{iosMapKey: @"es-ES", androidMapKey: @"values-es"},
                              @"it": @{iosMapKey: @"it", androidMapKey: @"values-it"},
                              @"pt-PT": @{iosMapKey: @"pt-PT", androidMapKey: @"values-pt"},
                              @"uk": @{iosMapKey: @"uk", androidMapKey: @"values-uk"},
                              @"ca": @{iosMapKey: @"ca", androidMapKey: @"values-ca"},
                              @"fa": @{iosMapKey: @"fa", androidMapKey: @"values-fa"},
                              @"ja": @{iosMapKey: @"ja", androidMapKey: @"values-ja"},
                              @"ro": @{iosMapKey: @"ro", androidMapKey: @"values-ro"},
                              @"vi": @{iosMapKey: @"vi", androidMapKey: @"values-vi"},
                              @"cs": @{iosMapKey: @"cs", androidMapKey: @"values-cs"},
                              @"fi": @{iosMapKey: @"fi", androidMapKey: @"values-fi"},
                              @"ko": @{iosMapKey: @"ko", androidMapKey: @"values-ko-rKR"},
                              @"ru": @{iosMapKey: @"ru", androidMapKey: @"values-ru"},
                              @"zh-CN": @{iosMapKey: @"zh-Hans", androidMapKey: @"values-zh-rCN"},
                              @"da": @{iosMapKey: @"da", androidMapKey: @"values-da"},
                              @"fr": @{iosMapKey: @"fr", androidMapKey: @"values-fr"},
                              @"lt": @{iosMapKey: @"lt", androidMapKey: @"values-lt"},
                              @"sk": @{iosMapKey: @"sk", androidMapKey: @"values-sk"},
                              @"zh-TW": @{iosMapKey: @"zh-Hant", androidMapKey: @"values-zh-rHK"},
                              @"de": @{iosMapKey: @"de", androidMapKey: @"values-de"},
                              @"gl": @{iosMapKey: @"gl", androidMapKey: @"values-gl"},
                              @"nl": @{iosMapKey: @"nl", androidMapKey: @"values-nl"},
                              @"sl": @{iosMapKey: @"sl", androidMapKey: @"values-sl"}};
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
