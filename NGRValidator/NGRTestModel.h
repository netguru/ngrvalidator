//
//  NGRTestModel.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

@interface NGRTestModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) float aFloat;
@property (nonatomic, assign) BOOL aBool;

@end
