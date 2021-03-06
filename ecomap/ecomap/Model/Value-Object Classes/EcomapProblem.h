//
//  EcomapProblem.h
//  EcomapFetcher
//
//  Created by Vasilii Kotsiuba on 2/3/15.
//  Copyright (c) 2015 Vasyl Kotsiuba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EcomapProblem : NSObject <NSCoding>

@property (nonatomic, readonly) NSUInteger problemID;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly) NSUInteger problemTypesID;
@property (nonatomic, strong, readonly) NSString *problemTypeTitle;
@property (nonatomic, readonly) BOOL isSolved;
@property (nonatomic, strong, readonly) NSDate *dateCreated;

//Designated initializer
- (instancetype)initWithProblem:(NSDictionary *)problem;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end

@protocol EcomapProblemHolder

- (void)setProblem:(EcomapProblem*)problem;

@end