## Messaging system

#### Overall

```objc
- rule: required()
- message key/method: MSGNil/msgNil(NSString *)
- default message: "is required."
```

#### NSString

```objc
- rule: minLength(NSUInteger)
- message key/method: MSGTooShort/msgTooShort(NSString *)
- default message: "is too short."

```
```objc
- rule: maxLength(NSUInteger)
- message key/method: MSGTooLong/msgTooLong(NSString *)
- default message: "is too long."
```
```objc
- rule: lengthRange(NSUInteger, NSUInteger)
- message key/method: MSGTooShort/msgTooShort(NSString *) and MSGTooLong/msgTooLong(NSString *)
- default message: "is" too short. or "is too long."
```
```objc
- rule: match(NSString *)
- message key/method: MSGNotMatch/msgNotMatch(NSString *)
- default message: "is not repeated exactly."
```
```objc
- rule: differ(NSString *)
- message key/method: MSGNotDiffer/msgNotDiffer(NSString *)
- default message: "does not differ."
```
```objc
- rule: decimal()
- message key/method: MSGNotDecimal/msgNotDecimal(NSString *)
- default message: "should be decimal."
```

#### Syntax 

```objc
- rule: syntax(NGRSyntaxEmail)
- message key/method: MSGNotEmail/msgWrongSyntax(NGRSyntaxEmail, NSString *)
- default message: "has invalid syntax."
```
```objc
- rule: syntax(NGRSyntaxName)
- message key/method: MSGNotName/msgWrongSyntax(NGRSyntaxName, NSString *)
- default message: "should contain only letters."
```
```objc
- rule: syntax(NGRSyntaxHTTP)
- message key/method: MSGNotHTTP/msgWrongSyntax(NGRSyntaxHTTP, NSString *)
- default message: "has invalid syntax."
```
```objc
- rule: regex(NSString *, NSRegularExpressionOptions)
- message key/method: MSGWrongRegex/msgWrongRegex(NSString *)
- default message: "do not match pattern."
```

#### NSNumber 

```objc
- rule: min(CGFloat)
- message key/method: MSGTooSmall/msgTooSmall(NSString *)
- default message: "is too small."
```
```objc
- rule: max(CGFloat)
- message key/method: MSGTooBig/msgTooBig(NSString *)
- default message: "is too big."
```
```objc
- rule: range(CGFloat, CGFloat)
- message key/method: MSGTooSmall/msgTooSmall(NSString *) and MSGTooBig/msgTooBig(NSString *)
- default message: "is too small." or "is too big."
```
```objc
- rule: exact(CGFloat)
- message key/method: MSGNotExact/msgNotExact(NSString *)
- default message: "isn't exact."
```
```objc
- rule: beFalse()
- message key/method: MSGNotFalse/msgNotFalse(NSString *)
- default message: "isn't false."
```
```objc
- rule: beTrue()
- message key/method: MSGNotTrue/msgNotTrue(NSString *)
- default message: "isn't true."
```

#### NSDate

```objc
- rule: earlierThan(NSDate *)
- message key/method: MSGNotEarlierThan/msgNotEarlierThan(NSString *)
- default message: "isn't earlier than compared date."
```
```objc
- rule: earlierThanOrEqualTo(NSDate *)
- message key/method: MSGNotEarlierThanOrEqualTo/msgNotEarlierThanOrEqualTo(NSString *)
- default message: "isn't earlier than or equal to compared date."
```
```objc
- rule: laterThan(NSDate *)
- message key/method: MSGNotLaterThan/msgNotEarlierThan(NSString *)
- default message: "isn't later than compared date."
```
```objc
- rule: laterThanOrEqualTo(NSDate *)
- message key/method: MSGNotLaterThanOrEqualTo/msgNotLaterThan(NSString *)
- default message: "isn't later than or equal to compared date."
```
```objc
- rule: betweenDates(NSDate *, NSDate *, BOOL)
- message key/method: MSGNotBetweenDates/msgNotBetweenDates(NSString *)
- default message: "isn't between given dates."
```