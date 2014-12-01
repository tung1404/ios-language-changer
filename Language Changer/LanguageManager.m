//
//  LanguageManager.m
//  Language Changer
//
//  Created by Alan Chung on 25/11/2014.
//  Copyright (c) 2014 Alan Chung. All rights reserved.
//

#import "LanguageManager.h"
#import "Localisation.h"
#import "Constants.h"

@implementation LanguageManager

#pragma mark - Object Lifecycle
+ (LanguageManager *)sharedLanguageManager {
    
    static dispatch_once_t once;
    static LanguageManager *languageManager;
    dispatch_once(&once, ^ { languageManager = [[LanguageManager alloc] init]; });
    return languageManager;
}

- (id)init {
    
    if (self = [super init]) {
        
        Localisation *english = [[Localisation alloc] initWithLanguageCode:@"en" countryCode:@"gb" name:@"United Kingdom"];
        Localisation *french = [[Localisation alloc] initWithLanguageCode:@"fr" countryCode:@"fr" name:@"France"];
        Localisation *german = [[Localisation alloc] initWithLanguageCode:@"de" countryCode:@"de" name:@"Deutschland"];
        Localisation *italian = [[Localisation alloc] initWithLanguageCode:@"it" countryCode:@"it" name:@"Italia"];
        Localisation *japanese = [[Localisation alloc] initWithLanguageCode:@"ja" countryCode:@"jp" name:@"日本"];
        
        self.availableLocalisations = @[english, french, german, italian, japanese];
    }
    
    return self;
}

#pragma mark - Methods

- (void)setLanguageWithLocalisation:(Localisation *)localisation {
    
    [[NSUserDefaults standardUserDefaults] setObject:localisation.languageCode forKey:DEFAULTS_KEY_LANGUAGE_CODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (Localisation *)getSelectedLocalisation {
    
    Localisation *selectedLocalisation = nil;
    
    // Get the language code.
    NSString *languageCode = [[[NSUserDefaults standardUserDefaults] stringForKey:DEFAULTS_KEY_LANGUAGE_CODE] lowercaseString];
    
    // Iterate through available localisations to find the one that matches languageCode.
    for (Localisation *localisation in self.availableLocalisations) {
        
        if ([localisation.languageCode caseInsensitiveCompare:languageCode] == NSOrderedSame) {
            
            selectedLocalisation = localisation;
            break;
        }
    }
    
    return selectedLocalisation;
}

- (NSString *)getTranslationForKey:(NSString *)key {
    
    // Get the language code.
    NSString *languageCode = [[[NSUserDefaults standardUserDefaults] stringForKey:DEFAULTS_KEY_LANGUAGE_CODE] lowercaseString];

    // Get the relevant language bundle.
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:languageCode ofType:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithPath:bundlePath];
    
    // Get the translated string using the language bundle.
    NSString *translatedString = [languageBundle localizedStringForKey:key value:@"" table:nil];
    
    if (translatedString.length < 1) {
        
        // There is no localizable strings file for the selected language.
        translatedString = NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], key, key);
    }
    
    return translatedString;
}

@end
