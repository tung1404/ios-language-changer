//
//  LanguageManager.h
//  Language Changer
//
//  Created by Alan Chung on 25/11/2014.
//  Copyright (c) 2014 Alan Chung. All rights reserved.
//
//  Singleton that manages the language selection and translations for strings in the app.
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
