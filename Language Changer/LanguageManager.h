//
//  LanguageManager.h
//  Language Changer
//
//  Created by Alan Chung on 25/11/2014.
//  Copyright (c) 2014 Alan Chung. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Localisation;

@interface LanguageManager : NSObject

@property (nonatomic, copy) NSArray *availableLocalisations;

+ (LanguageManager *)sharedLanguageManager;
- (void)setLanguageWithLocalisation:(Localisation *)localisation;
- (Localisation *)getSelectedLocalisation;
- (NSString *)getTranslationForKey:(NSString *)key;

@end
