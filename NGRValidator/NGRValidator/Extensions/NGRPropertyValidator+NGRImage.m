//
//  NGRPropertyValidator+NGRImage.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 23.03.2017.
//
//

#import "NGRPropertyValidator+NGRImage.h"

typedef NGRMsgKey *(^NGRImageValidationBlock)(NGRImage *image);

@implementation NGRPropertyValidator (NGRImage)

- (void)validateImageWithName:(NSString *)name block:(NGRImageValidationBlock)block {
    [self validateClass:[NGRImage class] withName:name validationBlock:^NGRMsgKey *(NGRImage *image) {
        return block(image);
    }];
}

#pragma mark - Rules

- (NGRPropertyValidator *(^)(CGFloat))minRatio {
    return ^(CGFloat ratio) {
        [self validateImageWithName:@"ratio" block:^NGRMsgKey *(NGRImage *image) {
            return image.ngr_pixelRatio >= ratio ? nil : MSGWrongAspectRatio;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGFloat))maxRatio {
    return ^(CGFloat ratio) {
        [self validateImageWithName:@"ratio" block:^NGRMsgKey *(NGRImage *image) {
            return image.ngr_pixelRatio <= ratio ? nil : MSGWrongAspectRatio;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGFloat))maxHeight {
    return ^(CGFloat max) {
        [self validateImageWithName:@"max height" block:^NGRMsgKey *(NGRImage *image) {
            return image.ngr_pixelSize.height <= max ? nil : MSGImageTooBig;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGFloat))minHeight {
    return ^(CGFloat min) {
        [self validateImageWithName:@"min height" block:^NGRMsgKey *(NGRImage *image) {
            return image.ngr_pixelSize.height >= min ? nil : MSGImageTooSmall;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGFloat))maxWidth {
    return ^(CGFloat max) {
        [self validateImageWithName:@"max width" block:^NGRMsgKey *(NGRImage *image) {
            return image.ngr_pixelSize.width <= max ? nil : MSGImageTooBig;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGFloat))minWidth {
    return ^(CGFloat min) {
        [self validateImageWithName:@"min width" block:^NGRMsgKey *(NGRImage *image) {
            return image.ngr_pixelSize.width >= min ? nil : MSGImageTooSmall;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGSize))maxSize {
    return ^(CGSize max) {
        [self validateImageWithName:@"max size" block:^NGRMsgKey *(NGRImage *image) {
            return image.ngr_pixelSize.height <= max.height && image.ngr_pixelSize.width <= max.width ? nil : MSGImageTooBig;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGSize))minSize {
    return ^(CGSize min) {
        [self validateImageWithName:@"min size" block:^NGRMsgKey *(NGRImage *image) {
            return image.ngr_pixelSize.height >= min.height && image.ngr_pixelSize.width >= min.width ? nil : MSGImageTooSmall;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgWrongRatio {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGWrongAspectRatio];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgImageTooBig {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGImageTooBig];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgImageTooSmall {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGImageTooSmall];
        return self;
    };
}

@end
