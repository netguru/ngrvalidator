# NGRValidator

**NGRValidator** allows you to validate the data in the way you want! It's easy to read (even via non-developers), centralized and complex solution to validate your model just in few lines of code. Moreover, **NGRValidator** contains default error messages which you can customize!

## Requirements

- iOS 7.0+ SDK
- CocoaPods 0.35.0 (use `gem install cocoapods` to grab it!)

## Installation:
#### Installation with CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party. To use **NGRValidator** via CocoaPods write in your Podfile:

```rb
pod 'NGRValidator', '~> 0.2.1'
```
and run `pod update` or `pod install`

#### Submodule
In your projects git folder type:
```bash
git submodule init
git submodule add --copy link to the repo--
git submodule update
```

#### Just download & attach
This is strongly misadvised as you won't be able to see code updates. Clone or download the source, copy all files from  **NGRValidator** folder.

## Configuration

Use `#import "NGRValidator"` whenever you want to use it.

## Model validation

Let's consider a typical model class used in Objective-C. Imagine you want to create a calendar event which model is defined like below:

```objc
@interface CalendarEvent : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *creatorLastName;
@property (strong, nonatomic) NSString *creatorEmail;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (assign, nonatomic) BOOL termsOfUse;

@end
```
Given model has to fulfill following conditions:
* `title` - obligatory, at least 5 signs;
* `creatorLastName` - obligatory, at least 4 signs, at most 30 signs, only letters (no digit and special signs allowed);
* `creatorEmail` - obligatory, email syntax;
* `url` - optional, url syntax;
* `startDate` - obligatory, not earlier than now, not later than `endDate`;
* `endDate` - obligatory, later than `startDate`;
* `termsOfUse` - oblligatory, should be accepted;

and display appropriate messages when validation rules above fail:
* `title` - `Title should have at least 5 signs`.
* `creatorLastName` - `Lastname has to contain digits only.`, `Lastname should have at least 4 signs` and `Lastname should have at most 30 signs.`
* `creatorEmail` - `Email has invalid syntax.`
* `url` - `URL has invalid syntax.`
* `startDate` - `Event start date cannot be earlier than now.` and `Event start date cannot be later than it's end.`
* `endDate` - `Event end date cannot be earlier than it's start.`.
* `termsOfuse` - `You have to accept terms of use.`.

Whew, all that rules and messages will generate lot of code for something so simple! Let's take a look how implemention in **NGRValidator** looks like:

```objc
CalendarEvent *event = [[CalendarEvent alloc] init];
// set properties from user input

NSError *error = nil;
[NGRValidator validateModel:event error:&error usingRules:^NSArray *{
        return @[NGRValidate(@"title").required().minLength(6).msgTooLong(@"should have at least 6 signs"),
                 NGRValidate(@"creatorLastName").required().lengthRange(4, 30).syntax(NGRSyntaxName).localizedName(@"Lastname").msgTooShort(@"should has at least 4 signs").msgTooLong(@"should have at most 30 signs.").msgWrongSyntax(NGRSyntaxName, @"has to contain digits only."),
                 NGRValidate(@"email").required().syntax(NGRSyntaxEmail),
                 NGRValidate(@"url").syntax(NGRSyntaxURL),
                 NGRValidate(@"startDate").required().laterThanOrEqualTo([NSDate date]).earlierThan(event.endDate).localizedName(@"Event start date").msgNotLaterThanOrEqualTo(@"cannot be earlier than now.").msgNotEarlierThan(@"cannot be later than it's end."),
                 NGRValidate(@"endDate").required().laterThan(event.startDate).localizedName(@"Event end date").msgNotLaterThan(@"cannot be earlier than it's start"),
                 NGRValidate(@"termsOfUse").required().trueValue().msgNotTrue(@"You have to accept terms of use.").localizedName(@"")];
    }];

error ? NSLog(@"Validation failed with error: %@", error) : NSLog(@"Validation succeed");
```
Simple as that!

## Invoking validation

There are 2 possible ways to validate model:
* till first error - validation will break when any error will appear:
```objc
+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error usingRules:(NSArray *(^)())rules;
```
* whole model validation - **NGRValidator** will validate whole model and return empty array when validation succeeded. Otherwise array will contains `NSError`'s objects.
```objc
+ (NSArray *)validateModel:(NSObject *)model usingRules:(NSArray *(^)())rules;
```

## Validation rules

**NGRValidator** offers many rules which you don't have to code. Let's take a look on them:
* `required()` - validates if property is nil or not. If isn't `required()` and has any other validation rules attached, like `.syntax(NGRSyntaxURL)` in example above, will be validated only when is not nil. This make you sure if property is not nil should pass applied rules.
* `allowEmpty()` - validates if property can be empty (means it's length or count is greater than 0) when is required. When is not allowed to be empty (the default behaviour), validator will treat empty property same as `nil`. Setting `allowEmpty` works only when property is also required. Otherwise has no effect. **NOTE:** Refers to `NSString`, `NSAttributedString`, `NSData`, `NSArray`, `NSSet`, `NSDictionary` (and their mutable counterparts).

**NSString**: 
* `minLength(NSUInteger)` - validates minimum length of NSString (inclusive).
* `maxLength(NSUInteger)` - validates maximum length of NSString (inclusive).
* `lengthRange(NSUInteger, NSUInteger)` - validates minimum and maximum length of NSString (inclusive).
* `exactLength(NSUInteger)` - validates exact length of NSString (inclusive).
* `match(NSString *)` - validates that the NSString match another string.
* `decimal()` - validates that the NSString contains only decimal signs.

**Syntax**: 
* `syntax(NGRSyntax)` - validates that the NSString has given syntax. There are 3 default syntax to choose:
    - `NGRSyntaxEmail` - validates email syntax.
    - `NGRSyntaxName` - validates if given string contains only alphabetic signs.
    - `NGRSyntaxURL` - validates syntax of URL.
* `regex(NSRegularExpression *)` - validates that the NSString match given regex.

**NSNumber**: 
* `min(float)` - validates lower limit of NSNumber (inclusive).
* `max(float)` - validates upper limit of NSNumber (inclusive).
* `range(float, float)` - validates minimum and maximum value of NSSNumber (inclusive).
* `exact(float)` - validates exact value of NSNumber.
* `falseValue()` - validates if NSNumber represents false status.
* `trueValue()` - validates if NSNumber represents true status.

**NSDate**:
* `earlierThan(NSDate *)` - validates if NSDate property is earlier than given date (inclusive).
* `earlierThanOrEqualTo(NSDate *)` - validates if NSDate property is earlier than or equal to given date (inclusive).
* `laterThan(NSDate *)` - validates if NSDate property is later than given date (inclusive).
* `laterThanOrEqualTo(NSDate *)` - validates if NSDate property is later than or equal to given date (inclusive).
* `betweenDates(NSDate *, NSDate *, BOOL)` - validates if NSDate property is between given dates. `BOOL` parameter specify inclusiveness of comparison.

## Validation messages
Although **NGRValidator** contains default error messages for each validation, it is possible to customize them as well. Any [validation rule](https://github.com/netguru/ngrvalidator#validation-rules) has its message counterpart ans starts with `msg` prefix:

| Validation rule | Counterpart message method  | Default message  |
|:--------------------:|:---------------------------:|:----------------------------:|
|`required()`|`msgNil(NSString *)`|is required.|
|`minLength(NSUInteger)`|`msgTooShort(NSString *)`|is too short.|
|`maxLength(NSUInteger)`|`msgTooLong(NSString *)`|is too long.|
|`lengthRange(NSUInteger, NSUInteger)`|`msgTooShort(NSString *)` and `msgTooLong(NSString *)` |is too short. `or` is too long.|
|`exactLength(NSUInteger)`|`msgNotExactLength(NSString *)`|is of the wrong length.|
|`match(NSString *)`|`msgNotMatch(NSString *)`|is not repeated exactly.|
|`decimal()`|`msgNotDecimal(NSString *)`|should be decimal.|
|`min(float)`|`msgTooSmall(NSString *)`|is too small.|
|`max(float)`|`msgTooBig(NSString *)`|is too big.|
|`range(float, float)`|`msgTooSmall(NSString *)` and `msgTooBig(NSString *)`|is too small. `or` is too big.|
|`exact(float)`|`msgNotExact(NSString *)`|isn't exact.|
|`falseValue()`|`msgNotFalse(NSString *)`|isn't false.|
|`trueValue()`|`msgNotTrue(NSString *)`|isn't true.|
|`syntax(NGRSyntaxEmail)`|`msgWrongSyntax(NGRSyntaxEmail, NSString *)`|has invalid syntax.|
|`syntax(NGRSyntaxName)`|`msgWrongSyntax(NGRSyntaxName, NSString *)`|should contain only letters.|
|`syntax(NGRSyntaxURL)`|`msgWrongSyntax(NGRSyntaxURL, NSString *)`|has invalid syntax.|
|`regex(NSRegularExpression *)`|`msgWrongRegex(NSString *)`|do not match pattern.|
|`earlierThan(NSDate *)`|`msgNotTrue(msgNotEarlierThan *)`|isn't earlier than compared date.|
|`earlierThanOrEqualTo(NSDate *)`|`msgNotEarlierThanOrEqualTo(NSString *)`|isn't earlier than or equal to compared date.|
|`laterThan(NSDate *)`|`msgNotLaterThan(NSString *)`|isn't later than compared date.|
|`laterThanOrEqualTo(NSDate *)`|`msgNotLaterThanOrEqualTo(NSString *)`|isn't later than or equal to compared date.|
|`betweenDates(NSDate *, NSDate *, BOOL)`|`msgNotBetweenDates(NSString *)`|isn't between given dates.|

By default **NGRValidator** will use name of validated property in error localized description. Nevertheless there is possibility to localize that name for everything you want! Just use:
```objc
localizedName(NSString *);
```
Let's take a look on following example:
```objc
NGRValidate(@"creatorLastName").required().localizedName(@"Lastname")
```
will change every error localized description applied to this property. Message `CreatorLastName is required.` will be changed to `Lastname is required.` So simple!

##Demo
Contains 2 examples:
* with UI
* coded

UI example will be automatically fired when you hit `⌘+R`. To enable coded example please change `logStory` flag from `NO` to `YES` in `AppDelegate`. To improve `story` readability and understandability, set brakepoint at the beginning of `story` method and follow debugger line by line.

## License
**NGRValidator** is available under the [MIT license](https://github.com/netguru/ngrvalidator/blob/master/LICENSE.md).

## Contribution
First, thank you for contributing!

Here a few guidelines to follow:

- follow [Ray Wenderlich Style Guide](https://github.com/raywenderlich/objective-c-style-guide).
- write tests
- make sure the entire test suite passes

## More Info

Have a question? Need to expand validation rules? Please [open an issue](https://github.com/netguru/ngrvalidator/issues/new)!

## Author
 Created and maintained by [Patryk Kaczmarek](https://github.com/PatrykKaczmarek).

##
Copyright © 2014 [Netguru](https://netguru.co)
