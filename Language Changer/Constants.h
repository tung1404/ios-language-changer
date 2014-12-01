//
//  Constants.h
//  Language Changer
//
//  Created by Alan Chung on 25/11/2014.
//  Copyright (c) 2014 Alan Chung. All rights reserved.
//

#ifndef Language_Changer_Constants_h
#define Language_Changer_Constants_h

// NSUserDefaults keys
#define DEFAULTS_KEY_LANGUAGE_CODE @"LanguageCode"

// Localisation
#define CustomLocalisedString(key, comment) \
    [[LanguageManager sharedLanguageManager] getTranslationForKey:key]

#endif
