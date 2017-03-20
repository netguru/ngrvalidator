//
//  NSData+NGRValidator.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

#import "NGRMimeType.h"

@interface NSData (NGRValidator)

NS_ASSUME_NONNULL_BEGIN

- (BOOL)ngr_hasMimeType:(NGRMimeType *)type;

NS_ASSUME_NONNULL_END

@end
