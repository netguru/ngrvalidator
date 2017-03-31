//
//  NGRPropertyValidator+NSData.m
//  NGRValidator
//
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

#pragma mark - Rules
    
- (NGRPropertyValidator *(^)(NSUInteger))maxByteSize {
    return ^(NSUInteger max) {
        [self validateDataWithName:@"max size" block:^NGRMsgKey *(NSData *data) {
            return [data length] <= max ? nil : MSGDataTooBig;
        }];
        return self;
    };
}
    
- (NGRPropertyValidator *(^)(NSUInteger))minByteSize {
    return ^(NSUInteger min) {
        [self validateDataWithName:@"min size" block:^NGRMsgKey *(NSData *data) {
            return [data length] >= min ? nil : MSGDataTooSmall;
        }];
        return self;
    };
}
    
- (NGRPropertyValidator *(^)(NGRMimeType *))mimeType {
    return ^(NGRMimeType *mimeType) {
        [self validateDataWithName:@"MIME type" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_hasMimeType:mimeType] ? nil : MSGWrongMIMEType;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())image {
    return ^() {
        [self validateDataWithName:@"image" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_isImage] ? nil : MSGWrongMediaType;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())video {
    return ^() {
        [self validateDataWithName:@"video" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_isVideo] ? nil : MSGWrongMediaType;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())audio {
    return ^() {
        [self validateDataWithName:@"audio" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_isAudio] ? nil : MSGWrongMediaType;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())archive {
    return ^() {
        [self validateDataWithName:@"archive" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_isArchive] ? nil : MSGWrongMediaType;
        }];
        return self;
    };
}
    
#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgWrongMIMEType {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGWrongMIMEType];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgWrongMediaType {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGWrongMediaType];
        return self;
    };
}
    
- (NGRPropertyValidator *(^)(NSString *))msgByteSizeTooSmall {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGDataTooSmall];
        return self;
    };
}
    
- (NGRPropertyValidator *(^)(NSString *))msgByteSizeTooBig {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGDataTooBig];
        return self;
    };
}

@end
