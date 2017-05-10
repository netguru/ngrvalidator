## Change Log

### 2.0.0
- Support for Swift 3.0
- Support for Carthage
- Support for pure Swift `class` or `struct` validation
- Support for conditional validation with `when(condition)` syntax
- New Data validators:
	- `minByteSize/maxByteSize` - the minimal/maximal size of validated data in bytes
	- `image/video/audio/archive` - whether validated data represents image/video/audio/archive
	- `mimeType` - whether validated data has given MIMEType. For full list of supported MIMETypes go [here](../NGRValidator/NGRValidator/Headers/Public/NGRMimeType.h)
- New Date validators:
	- `earlierThanUnixTimestamp` - whether validated date is earlier than specified UNIX epoch
	- `earlierThanOrEqualToUnixTimestamp` - whether validated date is earlier than or equal to specified UNIX epoch
	- `laterThanUnixTimestamp` - whether validated date is later than specified UNIX epoch
	- `laterThanOrEqualToUnixTimestamp` - whether validated date is later than or equal to specified UNIX epoch
- New Image validators:
	- `minRatio/maxRatio` - the minimal/maximal ratio of the validated image
	- `minWidth/maxWidth` - the minimal/maximal pixel width of the validated image
	- `minHeight/maxHeight` - the minimal/maximal pixel height of the validated image
	- `minSize/maxSize` - the minimal/maximal pixel size of the validated image
- New String validators:
	- `emoji` - whether validated string contains emoji
- Validators for syntaxes:
	- http, https
	- ws, wss
	- IPv4, IPv6
	- Domains (like `example.com`)
	- UUID
	- Geographic coordinates
	- Price
	- ISBN
	- Hexadecimal color
	- Phone number
	- Postal code


### 1.3.0
- revealing `NGRValidatorDomain` as `extern` by [rad3ks](https://github.com/rad3ks)
- introducing additional `NGRValidatorPropertyNameKey` key to `error.userInfo` by [paweldudek](https://github.com/paweldudek)



### 1.2.0
- Introduced new array validators:
    - `includes` - whether given object is included in validated array property or not.
    - `excludes` - whether given object is excluded from validated array property or not.
    - `includedIn` - whether validated property is included in given array.
    - `excludedFrom` - whether validated property is excluded from given array.

### 1.1.0
- OSX 10.7+ support.

### 1.0.0

- Introduced:
	- `VALIDATOR_SHORTHAND`. Feel free to use `validate(...)` instead of `NGRValidate(...)`
	- `NGRMessaging` delegate as an alternative to inline `msg_` methods declared in `rules` block.
	- Sugar syntax like `is`, `has`, `to`, `toNot` and so on. It improves readability and makes rules to have more natural tone.
	- new `NGRValidator` logo.
	- Continuous Integration.

- Syntax changes:
	- `NGRSyntaxURL` becomes `NGRSyntaxHTTP`, because this method checks whether a string is HTTP link or not.
	- `NGRError` enum to `NGRMsgKey *` in order to `NGRMessaging` delegate introduction.

- Improved:
	- Header documenatation.
	- Tests. Migrated from Kiwi to Specta/Expecta.

- Deprecated methods in `NGRValidator` class:

|Deprecated | Replacement |
|:--------------------:|:---------------------------:|
|`validateValue:named:usingRules:`| `validateValue:named:rules:` |
|`validateModel:error:usingRules:`| `validateModel:error:delegate:rules:`|
|`validateModel:error:scenario:usingRules:`|`validateModel:error:scenario:delegate:rules:`|
|`validateModel:usingRules`|`validateModel:delegate:rules:`|
|`validateModel:scenario:usingRules`|`validateModel:scenario:delegate:rules:`|

### 0.4.2

- Fixed issue with passing error as `nil` rather than NULL reference `*error`;

### 0.4.1

- Fixed bug occurring when multiplie scenarios were given.

### 0.4.0

- Syntax changes:
	- `trueValue()` becomes `beTrue()`
	- `falseValue()`becomes `beFalse()`

### 0.3.1

- Fixed issue with passing nil to blocks.


### 0.3.0

- Make `regex()` validator accept pattern and options, not a regex object.
