#!/bin/bash

EMOJIS_PLIST=/System/Library/Input\ Methods/CharacterPalette.app/Contents/Resources/Category-Emoji.plist
EMOJIS=`/usr/libexec/PlistBuddy "$EMOJIS_PLIST" -c Print | grep " Data " | tr -s " " "\0" | cut -d "=" -f 2 | tr "\n" "\0" | tr "," "\0"`

FILENAME="NSCharacterSet+NGRValidator"
FILEPATH="./NGRValidator/NGRValidator/Categories"

CONTENTS="\n// GENERATED AUTOMATICALLY - DO NOT MODIFY\n//\n//  $FILENAME.m\n//  NGRValidator\n//\n//\n\n#import \"$FILENAME.h\"\n\n@implementation NSCharacterSet (NGRValidator)\n\n+ (NSCharacterSet *)emojisCharacterSet {\n\tNSString *allEmojisString = @\"$EMOJIS\";\n\n\treturn [NSCharacterSet characterSetWithCharactersInString:allEmojisString];\n}\n\n@end\n"

echo -e $CONTENTS > $FILEPATH/$FILENAME.m
