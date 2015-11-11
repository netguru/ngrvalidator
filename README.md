<p align="center" >
  <img src="https://raw.github.com/netguru/ngrvalidator/master/Documents/github_header.png" alt="NGRValidator" title="NGRValidator">
</p>

[![Circle CI](https://circleci.com/gh/netguru/ngrvalidator/tree/master.svg?style=svg)](https://circleci.com/gh/netguru/ngrvalidator/tree/master)
[![Platform](https://cocoapod-badges.herokuapp.com/p/ngrvalidator/badge.png)](http://cocoadocs.org/docsets/ngrvalidator) 
[![Version](https://cocoapod-badges.herokuapp.com/v/ngrvalidator/badge.png)](http://cocoadocs.org/docsets/ngrvalidator) 
![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)

**NGRValidator** is an Objective-C 3rd party library for iOS and OSX. It allows you to validate the data in the way that you want. It's an easy to read, centralized, and comprehensive solution to validating any Objective-C model in just a few lines of code.

## Why use NGRValidator?

Typically every project which handles user account requires email validation. Let's take a look how to do this: 

```objc
NSString *email = <#your string email address#>;
NSError *error = [NGRValidator validateValue:email named:@"E-mail address" rules:^(NGRPropertyValidator *validator) {
    // 'is', 'to', 'have' are syntactic sugar and can be safely omitted
    validator.is.required().to.have.syntax(NGRSyntaxEmail);
}];
```

Too much code? There are better ways to achieve this? And, what if you want to validate passwords as well? You can use a similar method to the one above. Nevertheless, in order to keep the MVC pattern, it would be much better to create a simple model with validation functionality:

```objc
@interface UserAccount : NSObject

//should have email syntax:
@property (strong, nonatomic) NSString *email;
//should have at least 5 signs:
@property (strong, nonatomic) NSString *password;

@end

@implementation  UserAccount

- (NSError *)validate {
    NSError *error = nil;
    [NGRValidator validateModel:self error:&error delegate:nil rules:^NSArray *{
        return @[NGRValidate(@"email").required().syntax(NGRSyntaxEmail),
                 NGRValidate(@"password").required().minLength(5)];
    }];
    return error;
}

@end
```
Let's take it one step further. Consider this model should be used both for login and for password change. Moreover to change password, user should provide old, new and repeated new password. Obviously new and repeated new password shouldn't be validated on login. Improved `UserAccount` model looks as follows:

```objc
@interface UserAccount : NSObject

//should have email syntax:
@property (strong, nonatomic) NSString *email;
//should have at least 5 signs:
@property (strong, nonatomic) NSString *password;
//should have at least 5 signs and be different than password. Validated only on "changePassword" scenario.
@property (strong, nonatomic) NSString *newPassword;
//should have at least 5 signs and be same as newPassword. Validated only on "changePassword" scenario.
@property (strong, nonatomic) NSString *repeatedNewPassword;

@end

@implementation  UserAccount

- (NSError *)validateWithScenario:(NSString *)scenario {
     NSError *error = nil;
    [NGRValidator validateModel:self error:&error scenario:scenario delegate:nil rules:^NSArray *{
        return @[NGRValidate(@"email").required().syntax(NGRSyntaxEmail),
                 NGRValidate(@"password").required().minLength(5),
                 NGRValidate(@"newPassword").required().minLength(5).differ(self.password).onScenarios(@[@"changePassword"]),
                 NGRValidate(@"repeatedNewPassword").required().match(self.newPassword).onScenarios(@[@"changePassword"])];
    }];
    return error;
}

@end
```

That's it! All validation requirements in one place. 
Continue reading to learn more about [rules](https://github.com/netguru/ngrvalidator#validation-rules), [scenarios](https://github.com/netguru/ngrvalidator#scenarios) and [messaging](https://github.com/netguru/ngrvalidator#validation-messages).

## Requirements

- iOS 7.0+ SDK
- OSX 10.7+ SDK
- CocoaPods 0.39.0 (use `gem install cocoapods` to grab it!)

## Installation:
#### Installation with CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party. To use **NGRValidator** via CocoaPods write in your Podfile:

```rb
pod 'ngrvalidator', '~> 1.3.0'
```
and run `pod update` or `pod install`

#### Submodule
In your projects git folder type:

```
git submodule init
git submodule add --copy link to the repo--
git submodule update
```

#### Just download & attach
This is strongly misadvised as you won't be able to see code updates. Clone or download the source, copy all files from  **NGRValidator** folder.

## Configuration

Use `#import "NGRValidator"` whenever you want to use it.

As many other libraries, **NGRValidator** offers handy `VALIDATOR_SHORTHAND` which allows to omit prefixes in some methods. To use it, write **before** `#import`:

```
#define VALIDATOR_SHORTHAND
```
and feel free to use `validate(...)` instead of `NGRValidate(...)`


## Invoking validation

There are 3 general methods of validation:

* single value validation:

```objc
+ (NSError *)validateValue:(NSObject *)value 
					 named:(NSString *)name 
					 rules:(void (^)(NGRPropertyValidator *validator))rules;
```
* model validation till first error. **NGRValidator** will break validation when any error will appear:

```objc
+ (BOOL)validateModel:(NSObject *)model 
			    error:(NSError **)error 
			 delegate:(id<NGRMessaging>)delegate
			    rules:(NSArray *(^)())rules;

// with scenario counterpart:
+ (BOOL)validateModel:(NSObject *)model 
			    error:(NSError **)error 
			 scenario:(NSString *)scenario
			 delegate:(id<NGRMessaging>)delegate
			    rules:(NSArray *(^)())rules;
```
* entire model validation. **NGRValidator** will validate entire model and return an array populated with errors (if validation failed). Otherwise nil:

```objc
+ (NSArray *)validateModel:(NSObject *)model 
                  delegate:(id<NGRMessaging>)delegate 
                     rules:(NSArray *(^)())rules;
                     
// with scenario counterpart:                
+ (NSArray *)validateModel:(NSObject *)model 
                  scenario:(NSString *)scenario
                  delegate:(id<NGRMessaging>)delegate 
                     rules:(NSArray *(^)())rules;
```

**Psst hey!** if any error did appear you can determine which property did not validate just by checking `error.userInfo[NGRValidatorPropertyNameKey]`.

## Validation rules

**NGRValidator** offers many ready to use rules:

* `required()` - validates if property is nil or not. If is not required and has any other validation rule attached, like `.decimal()`, property will be validated only when is not nil.

* `allowEmpty()` - validates if property can be empty (means it's length or count is equal to 0). By default cannot be empty. When is allowed to be empty, validator will pass validation when property will be empty. Works for both required and non-required rules. **NOTE:** Refers to `NSString`, `NSAttributedString`, `NSData`, `NSArray`, `NSSet`, `NSDictionary` (and their mutable counterparts).

* `order(NSUInteger)` - changes priority of `NGRPropertyValidator`. By default all property validators have same priority and will be invoked in order of NSArray order returned in `rules:` block.

**NSString**:
 
* `minLength(NSUInteger)` - validates minimum length of NSString (inclusive).
* `maxLength(NSUInteger)` - validates maximum length of NSString (inclusive).
* `lengthRange(NSUInteger, NSUInteger)` - validates minimum and maximum length of NSString (inclusive).
* `exactLength(NSUInteger)` - validates exact length of NSString.
* `match(NSString *)` - validates that the NSString match another NSString.
* `differ(NSString *)` - validates that the NSString is different than another NSString.
* `decimal()` - validates that the NSString contains only decimal signs.

**Syntax**: 

* `syntax(NGRSyntax)` - validates that the NSString has given syntax. There are 3 default syntax to choose:
    - `NGRSyntaxEmail` - validates email syntax.
    - `NGRSyntaxName` - validates if given string contains only alphabetic signs.
    - `NGRSyntaxHTTP` - validates syntax of HTTP URL.
* `regex(NSString *, NSRegularExpressionOptions)` - validates that the NSString match given regex pattern with options.

**NSNumber**: 

* `min(float)` - validates lower limit of NSNumber (inclusive).
* `max(float)` - validates upper limit of NSNumber (inclusive).
* `range(float, float)` - validates minimum and maximum value of NSSNumber (inclusive).
* `exact(float)` - validates exact value of NSNumber.
* `beFalse()` - validates if NSNumber represents false status.
* `beTrue()` - validates if NSNumber represents true status.

**NSDate**:

* `earlierThan(NSDate *)` - validates if NSDate property is earlier than given date (inclusive).
* `earlierThanOrEqualTo(NSDate *)` - validates if NSDate property is earlier than or equal to given date (inclusive).
* `laterThan(NSDate *)` - validates if NSDate property is later than given date (inclusive).
* `laterThanOrEqualTo(NSDate *)` - validates if NSDate property is later than or equal to given date (inclusive).
* `betweenDates(NSDate *, NSDate *, BOOL)` - validates if NSDate property is between given dates. `BOOL` parameter specify inclusiveness of comparison.

**NSArray**:

* `includes(NSObject *)` - validates whether given object is included in validated array property or not.
* `excludes(NSObject *)` - validates whether given object is excluded from validated array property or not.
* `includedIn(NSArray *)` - validates whether validated property is included in given array. If array is empty validation will return an error.
* `excludedFrom(NSArray *)` - validates whether validated property is excluded from given array. If array is empty validation will pass.


## Scenarios

Scenarios allows to keep same model across all possible actions. Sometimes some properties should be obligatory for one action and optional for another. Scenarios makes model validation more flexible and usable without any conditional statements. If property should conform specified scenario(s), pass `NSArray` of scenarios using:

```objc
onScenarios(NSArray *)
```
Property which doesn't conform any scenario, will be validated on every scenario. Just remember to pass scenario names as `NSString`

## Validation messages

Although **NGRValidator** contains default error messages for each validation, it is possible to customize them as well. There are two way to achieve this:

##### 1. by using `msg` prefixed method in `rules` block:

```objc
NGRValidate(@"password").minLength(5).msgTooShort(@"should have at least 5 signs")
```

Notice that **NGRValidator** will use capitalized name of validated property in error description. Nevertheless there is possibility to localize it's name with:

```objc
localizedName(NSString *)
```

##### 2. by conforming `NGRMessaging` delegate and returning error key - messages dictionary for appropriate property key:

```objc
- (NSDictionary *)validationErrorMessagesByPropertyKey {
    return @{@"password" : 
    		    @{MSGTooShort : @"Password should have at least 5 signs."}
    	    };
}
```

This two methods can be used simultaneously. Order of taking messages is defined as follows: 

> 1. If any error will be encountered by validator, it will ask delegate first for error description.
> 2. If delegate will be nil or validator will not find message for expected error-key and property name, it will search for an error description in given in rules block.
> 3. If developer didn't declare message for encoutered error, validator will use default one prepared by library.

For more info please refer to [messaging system](https://github.com/netguru/ngrvalidator/blob/master/MD/Messages.md).

## Sugar syntax

**NGRValidator** contains sugar syntax to improve readbility and introduce natural speech to code. To sugar syntax belongs:

```objc
is, are, on, has, have, to, toNot, notTo, be, with, should
```

Note difference between sugar syntax and regular validation method:

```
                          validation method has to be invoked always with parentheses (even if do not take any parameter).
                           v
 validate(@"password").is.required()
                       ^
                      sugar syntax is always invoked without parentheses.
```

##Demo
Contains 4 examples:

* UI examples on 3 levels: simple, medium and complex. Every level has been eplained more on less in this readme. 
* coded

UI example will be automatically fired when you hit `⌘+R`. To enable coded example please change `logStory` flag from `NO` to `YES` in `AppDelegate`. To improve `story` readability and understandability, set brakepoint at the beginning of `story` method and follow debugger line by line.

## License
**NGRValidator** is available under the [MIT license](https://github.com/netguru/ngrvalidator/blob/master/MD/LICENSE.md).

## Contribution
First, thank you for contributing! Here a few guidelines to follow:

- follow [Ray Wenderlich Style Guide](https://github.com/raywenderlich/objective-c-style-guide).
- write tests
- make sure the entire test suite passes

## More Info

Changelog available [here](https://github.com/netguru/ngrvalidator/blob/master/MD/Changelog.md).

Feel free to contribute, comment, ask, and share your ideas by [opening an issue](https://github.com/netguru/ngrvalidator/issues/new).


You can also read our blog post [introducing: Open Source NGRValidator](https://netguru.co/blog/open-source-validator).


## Author
 Created and maintained by [Patryk Kaczmarek](https://github.com/PatrykKaczmarek).

##
Copyright © 2014 - 2015 [Netguru](https://netguru.co)
