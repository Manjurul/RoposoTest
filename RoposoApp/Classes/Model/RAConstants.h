//
//  RAConstants.h
//  RoposoApp
//
//  Created by Munch on 6/13/16.
//  Copyright © 2016 Roposo. All rights reserved.
//



#define VALIDATE_STRING_AND_ASSIGN(var, key) {    \
id aValue = [theDict valueForKey:key]; \
if (aValue && ![aValue isKindOfClass:[NSNull class]]) {\
var = aValue;   \
} else {    \
var = @"";  \
}   \
}


#define VALIDATE_NUMBER_AND_ASSIGN(var, key) {    \
id aValue = [theDict valueForKey:key]; \
if (aValue && ![aValue isKindOfClass:[NSNull class]]) {\
var = aValue;   \
} else {    \
var = @0;  \
}   \
}


#define VALIDATE_DATE_AND_ASSIGN(var, key) {    \
id aValue = [theDict valueForKey:key]; \
if (aValue && ![aValue isKindOfClass:[NSNull class]]) {\
var = [NSDate dateWithTimeIntervalSince1970:[aValue doubleValue]];   \
} else {    \
var = [NSDate date];  \
}   \
}