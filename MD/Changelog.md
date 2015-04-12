## Change Log

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