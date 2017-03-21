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

- (NGRPropertyValidator *(^)(NGRMimeType *))mimeType {
    return ^(NGRMimeType *mimeType) {
        [self validateDataWithName:@"MIME type" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_hasMimeType:mimeType] ? nil : MSGWrongMIMEType;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())image {
    return ^(NGRMimeType *mimeType) {
        [self validateDataWithName:@"image" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_isImage] ? nil : MSGWrongMediaType;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())video {
    return ^(NGRMimeType *mimeType) {
        [self validateDataWithName:@"video" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_isVideo] ? nil : MSGWrongMediaType;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())audio {
    return ^(NGRMimeType *mimeType) {
        [self validateDataWithName:@"audio" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_isAudio] ? nil : MSGWrongMediaType;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())archive {
    return ^(NGRMimeType *mimeType) {
        [self validateDataWithName:@"archive" block:^NGRMsgKey *(NSData *data) {
            return [data ngr_isArchive] ? nil : MSGWrongMediaType;
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

- (NGRPropertyValidator *(^)(NSString *))msgWrongMediaType {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGWrongMediaType];
        return self;
    };
}

@end
