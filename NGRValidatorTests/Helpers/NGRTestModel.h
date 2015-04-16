//
//  NGRTestModel.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 06/04/15.
//
//

#import <Foundation/Foundation.h>

@interface NGRTestModel : NSObject <NGRMessaging>

@property (strong, nonatomic) id value;
@property (strong, nonatomic) id secondValue;

@end
