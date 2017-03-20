//
//  NGRPropertyValidator+NSData.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

#import "NGRPropertyValidator+NSData.h"
#import "NSData+NGRValidator.h"

typedef NGRMsgKey *(^NGRDataValidationBlock)(NSData *data);

@implementation NGRPropertyValidator (NSData)

- (void)validateDataWithName:(NSString *)name block:(NGRDataValidationBlock)block {
    [self validateClass:[NSData class] withName:name validationBlock:^NGRMsgKey *(NSData *data) {
        return block(data);
    }];
}

- (NGRPropertyValidator *(^)(NGRMimeType *))mimeType {
    return ^(NGRMimeType *mimeType) {
        [self validateDataWithName:@"MIME type" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_hasMimeType:mimeType] ? nil : MSGWrongMIMEType;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgWrongMIMEType {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGWrongMIMEType];
        return self;
    };
}

@end
