//
//  NGRConstants.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 10/04/15.
//
//

#import "NGRConstants.h"

@implementation NGRMsgKey @end

//NGRPropertyValidator + NSObject
NGRMsgKey *const MSGNil = (NGRMsgKey *)@"NGRNilMessage";

//NGRPropertyValidator + NSString
NGRMsgKey *const MSGTooLong = (NGRMsgKey *)@"NGRTooLongMessage";
NGRMsgKey *const MSGTooShort = (NGRMsgKey *)@"NGRTooShortMessage";
NGRMsgKey *const MSGNotDecimal = (NGRMsgKey *)@"NGRNotDecimalMessage";
NGRMsgKey *const MSGNotExactLength = (NGRMsgKey *)@"NGRNotExactLengthMessage";
NGRMsgKey *const MSGNotMatch = (NGRMsgKey *)@"NGRNotMatchMessage";
NGRMsgKey *const MSGNotDiffer = (NGRMsgKey *)@"NGRNotDifferMessage";

//NGRPropertyValidator + NSNumber
NGRMsgKey *const MSGTooSmall = (NGRMsgKey *)@"NGRTooSmallMessage";
NGRMsgKey *const MSGTooBig = (NGRMsgKey *)@"NGRTooBigMessage";
NGRMsgKey *const MSGNotExact = (NGRMsgKey *)@"NGRNotExactMessage";
NGRMsgKey *const MSGNotFalse = (NGRMsgKey *)@"NGRNotFalseMessage";
NGRMsgKey *const MSGNotTrue = (NGRMsgKey *)@"NGRNotTrueMessage";

//NGRPropertyValidator + Syntax
NGRMsgKey *const MSGNotEmail = (NGRMsgKey *)@"NGRNotEmailMessage";
NGRMsgKey *const MSGNotName = (NGRMsgKey *)@"NGRNotNameMessage";
NGRMsgKey *const MSGNotHTTP = (NGRMsgKey *)@"NGRNotHttpMessage";
NGRMsgKey *const MSGWrongRegex = (NGRMsgKey *)@"NGRWrongRegexMessage";

//NGRPropertyValidator + NSDate
NGRMsgKey *const MSGNotEarlierThan = (NGRMsgKey *)@"NGRNotEarlierThanMessage";
NGRMsgKey *const MSGNotLaterThan = (NGRMsgKey *)@"NGRNotLaterThanMessage";
NGRMsgKey *const MSGNotEarlierThanOrEqualTo = (NGRMsgKey *)@"NGRNotEarlierThanOrEqualToMessage";
NGRMsgKey *const MSGNotLaterThanOrEqualTo = (NGRMsgKey *)@"NGRNotLaterThanOrEqualToMessage";
NGRMsgKey *const MSGNotBetweenDates = (NGRMsgKey *)@"NGRNotBetweenDatesMessage";

//NGRPropertyValidator + NSArray
NGRMsgKey *const MSGNotIncludes = (NGRMsgKey *)@"MSGNotIncludes";
NGRMsgKey *const MSGNotExcludes = (NGRMsgKey *)@"MSGNotExcludes";

NGRMsgKey *const MSGNotIncludedIn = (NGRMsgKey *)@"MSGNotIncludedIn";
NGRMsgKey *const MSGNotExcludedFrom = (NGRMsgKey *)@"MSGNotExcludedFrom";
