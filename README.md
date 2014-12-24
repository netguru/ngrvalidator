# NGRValidator

**NGRValidator** allows you to validate your data in way you want! It's easy to read (even via non-developers), centralized and complex solution to validate your model just in few lines of code. Moreover **NGRValidator** contains default error messages which you can customize as well!

## Requirements

- iOS 7.0+ SDK
- CocoaPods 0.35.0 (use `gem install cocoapods` to grab it!)

## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party. To use **NGRValidator** via CocoaPods write in your Podfile:

```rb
pod 'NGRValidator', '~> 0.1.0'
```
and run `pod update` or `pod install`

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

@end
```
Given model has to fulfill following conditions:
* `title` - obligatory. Should has at least 5 signs.
* `creatorLastName` - obligatory. Should be at least 4 signs and at moset 30 signs. Also should contains only letters cause it lastname. No digit and special signs allowed!
* `creatorEmail` - obligatory. Should has email syntax.
* `url` - optional. When not nil, should has url syntax.
* `startDate` - obligatory. Should be not earlier than now and not later than `endDate`.
* `endDate` - obligatory. Should be later than `startDate`.

and display appropriate messages when validation rules above fail:
* `title` - `Title should has at least 5 signs`.
* `creatorLastName` - `Lastname has to contain digits only.`, `Lastname should has at least 4 signs` and `Lastname should has at most 30 signs.`
* `creatorEmail` - `Email has invalid syntax.`
* `url` - `URL has invalid syntax.`
* `startDate` - `Event start date cannot be earlier than now.` and `Event start date cannot be later than it's end.`
* `endDate` - `Event end date cannot be earlier than it's start`.

Whew, all that rules and messages will generate lot of code for something so simple! Let's take a look how to implemention in **NGRValidator** looks like:

```objc
CalendarEvent *event = [[CalendarEvent alloc] init];
// set properties from user input

NSError *error = nil;
[NGRValidator validateModel:event error:&error usingRules:^NSArray *{
        return @[NGRValidate(@"title").required().minLength(5).tooLong(@"should has at least 5 signs"),
                 NGRValidate(@"creatorLastName").required().lengthRange(4, 30).syntax(NGRSyntaxName).localizedName(@"Lastname").tooShort(@"should has at least 4 signs").tooLong(@"should has at most 30 signs."),
                 NGRValidate(@"email").required().syntax(NGRSyntaxEmail),
                 NGRValidate(@"url").syntax(NGRSyntaxURL),
                 NGRValidate(@"startDate").required().laterThanOrEqualTo([NSDate date]).earlierThan(event.endDate).localizedName(@"Event start date").notLaterThanOrEqualTo(@"cannot be earlier than now.").notEarlierThan(@"cannot be later than it's end."),
                 NGRValidate(@"endDate").required().laterThan(event.startDate).localizedName(@"Event end date").notLaterThan(@"cannot be earlier than it's start")];
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

## Validation messages

## License
**NGRValidator** is available under the [MIT license](https://github.com/netguru/ngrvalidator/blob/master/LICENSE.md).

## Contribution
First, thank you for contributing!

Here a few guidelines to follow:

- we follow [Ray Wenderlich Style Guide](https://github.com/raywenderlich/objective-c-style-guide).
- write tests
- make sure the entire test suite passes

## More Info

Have a question? Please [open an issue](https://github.com/netguru/ngrvalidator/issues/new)!

##
Copyright © 2014 [Netguru](https://netguru.co)
