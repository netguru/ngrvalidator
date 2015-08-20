//
//  NGRConstants.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 10/04/15.
//
//

#import <Foundation/Foundation.h>

@interface NGRMsgKey : NSString @end

//NGRPropertyValidator + NSObject
extern NGRMsgKey *const MSGNil;

//NGRPropertyValidator + NSString
extern NGRMsgKey *const MSGTooLong;
extern NGRMsgKey *const MSGTooShort;
extern NGRMsgKey *const MSGNotDecimal;
extern NGRMsgKey *const MSGNotExactLength;
extern NGRMsgKey *const MSGNotMatch;
extern NGRMsgKey *const MSGNotDiffer;

//NGRPropertyValidator + NSNumber
extern NGRMsgKey *const MSGTooSmall;
extern NGRMsgKey *const MSGTooBig;
extern NGRMsgKey *const MSGNotExact;
extern NGRMsgKey *const MSGNotFalse;
extern NGRMsgKey *const MSGNotTrue;

//NGRPropertyValidator + Syntax
extern NGRMsgKey *const MSGNotEmail;
extern NGRMsgKey *const MSGNotName;
extern NGRMsgKey *const MSGNotHTTP;
extern NGRMsgKey *const MSGWrongRegex;

//NGRPropertyValidator + NSDate
extern NGRMsgKey *const MSGNotEarlierThan;
extern NGRMsgKey *const MSGNotLaterThan;
extern NGRMsgKey *const MSGNotEarlierThanOrEqualTo;
extern NGRMsgKey *const MSGNotLaterThanOrEqualTo;
extern NGRMsgKey *const MSGNotBetweenDates;

//NGRPropertyValidator + Collections
extern NGRMsgKey *const MSGNotIncludes;
extern NGRMsgKey *const MSGNotExcludes;

extern NGRMsgKey *const MSGNotIncludedIn;
extern NGRMsgKey *const MSGNotExcludedFrom;

typedef NGRMsgKey *(^NGRValidationBlock)(id);
typedef NSArray *(^NGRRules)();
