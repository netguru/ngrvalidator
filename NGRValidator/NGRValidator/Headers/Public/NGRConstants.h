//
//  NGRConstants.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 10/04/15.
//
//

#import <Foundation/Foundation.h>

@class NGRPropertyValidator;

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
extern NGRMsgKey *const MSGHasEmoji;
extern NGRMsgKey *const MSGHasNoEmoji;

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
extern NGRMsgKey *const MSGNotFile;
extern NGRMsgKey *const MSGNotHTTPS;
extern NGRMsgKey *const MSGNotIPv4;
extern NGRMsgKey *const MSGNotIPv6;
extern NGRMsgKey *const MSGNotDomain;
extern NGRMsgKey *const MSGNotUUID;
extern NGRMsgKey *const MSGNotGeoCoord;
extern NGRMsgKey *const MSGNotPrice;
extern NGRMsgKey *const MSGNotISBN;
extern NGRMsgKey *const MSGNotHexColor;
extern NGRMsgKey *const MSGNotPhoneNumber;
extern NGRMsgKey *const MSGNotPostalCode;
extern NGRMsgKey *const MSGNotWebSocket;
extern NGRMsgKey *const MSGNotSecureWebSocket;

//NGRPropertyValidator + CreditCard
extern NGRMsgKey *const MSGNotValidCreditCardNumber;
extern NGRMsgKey *const MSGNotValidCreditCardExpirationDate;

//NGRPropertyValidator + NSDate
extern NGRMsgKey *const MSGNotEarlierThan;
extern NGRMsgKey *const MSGNotLaterThan;
extern NGRMsgKey *const MSGNotEarlierThanOrEqualTo;
extern NGRMsgKey *const MSGNotLaterThanOrEqualTo;
extern NGRMsgKey *const MSGNotBetweenDates;

//NGRPropertyValidator + NSDate
extern NGRMsgKey *const MSGWrongMIMEType;
extern NGRMsgKey *const MSGWrongMediaType;
extern NGRMsgKey *const MSGDataTooBig;
extern NGRMsgKey *const MSGDataTooSmall;

//NGRPropertyValidator + Collections
extern NGRMsgKey *const MSGNotIncludes;
extern NGRMsgKey *const MSGNotExcludes;

extern NGRMsgKey *const MSGNotIncludedIn;
extern NGRMsgKey *const MSGNotExcludedFrom;

//NGRPropertyValidator + NGRImage
extern NGRMsgKey *const MSGImageTooBig;
extern NGRMsgKey *const MSGImageTooSmall;
extern NGRMsgKey *const MSGWrongAspectRatio;

typedef NGRMsgKey *(^NGRValidationBlock)(id);
typedef NSArray<NGRPropertyValidator *> *(^NGRRules)();
