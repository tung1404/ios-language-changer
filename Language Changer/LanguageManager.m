//
//  LanguageManager.m
//  Language Changer
//
//  Created by Alan Chung on 25/11/2014.
//  Copyright (c) 2014 Alan Chung. All rights reserved.
//
//  Singleton that manages the language selection and translations for strings in the app.
//

#import "LanguageManager.h"
#import "Localisation.h"
#import "Constants.h"

@implementation LanguageManager

#pragma mark - Object Lifecycle
+ (LanguageManager *)sharedLanguageManager {
    
    // Create a singleton.
    static dispatch_once_t once;
    static LanguageManager *languageManager;
    dispatch_once(&once, ^ { languageManager = [[LanguageManager alloc] init]; });
    return languageManager;
}

- (id)init {
    
    if (self = [super init]) {
        
        // Manually create a list of available localisations for this example project.
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

/*!
 * @function setLanguageWithLocalisation:
 *
 * @abstract
 * Sets the language code string in the user defaults, based on the given Localisation object.
 *
 * @param localisation
 * The localisation object whose language code we are storing in the user defaults.
 */
- (void)setLanguageWithLocalisation:(Localisation *)localisation {
    
    [[NSUserDefaults standardUserDefaults] setObject:localisation.languageCode forKey:DEFAULTS_KEY_LANGUAGE_CODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*!
 * @function getSelectedLocalisation
 *
 * @abstract
 * Get the localisation object from the list of available localisations that matches the language code
 * stored in the user defaults.
 *
 * @return
 * The Localisation object based on the language code stored in the user defaults.
 *
 * @discussion
 * Returns nil if a language code has not been set in the user defaults.
 */
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

/*!
 * @function getTranslationForKey:
 *
 * @abstract
 * Return a translated string for the given string key.
 *
 * @param key
 * The key of the string whose translation we want to look up.
 *
 * @return
 * The translated string for the given key.
 *
 * @discussion
 * Uses the string stored in the user defaults to determine which language to translate to. Translations for
 * keys are found in the Localisable.strings files in the relevant .lproj folder for the selected language.
 */
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
