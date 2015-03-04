//
//  EcomapProblemDetails.m
//  EcomapFetcher
//
//  Created by Vasilii Kotsiuba on 2/3/15.
//  Copyright (c) 2015 Vasyl Kotsiuba. All rights reserved.
//

#import "EcomapProblemDetails.h"
#import "EcomapPathDefine.h"
#import "EcomapLoggedUser.h"
#import "EcomapComments.h"

@interface EcomapProblemDetails ()
@property (nonatomic, strong, readwrite) NSString *content;
@property (nonatomic, strong, readwrite) NSString *proposal;
@property (nonatomic, readwrite) NSUInteger severity;
@property (nonatomic, readwrite) NSUInteger moderation;
@property (nonatomic, readwrite) NSUInteger votes;

- (BOOL)canVote:(EcomapLoggedUser *)loggedUser;
@end

@implementation EcomapProblemDetails

#pragma mark - Overriding problem init
//Override
-(instancetype)initWithProblem:(NSDictionary *)problem
{
    self = [super initWithProblem:problem];
    if (self) {
        if (!problem) return nil;
        [self parseProblem:problem];
    }
    return self;
}

-(void)parseProblem:(NSDictionary *)problem
{
    if (problem) {
        self.content = ![[problem valueForKey:ECOMAP_PROBLEM_CONTENT] isKindOfClass:[NSNull class]] ? [problem valueForKey:ECOMAP_PROBLEM_CONTENT] : nil;
        self.proposal = ![[problem valueForKey:ECOMAP_PROBLEM_PROPOSAL] isKindOfClass:[NSNull class]] ? [problem valueForKey:ECOMAP_PROBLEM_PROPOSAL] : nil;
        self.severity = ![[problem valueForKey:ECOMAP_PROBLEM_SEVERITY] isKindOfClass:[NSNull class]] ? [[problem valueForKey:ECOMAP_PROBLEM_SEVERITY] integerValue] : 0;
        self.moderation = ![[problem valueForKey:ECOMAP_PROBLEM_MODERATION] isKindOfClass:[NSNull class]] ? [[problem valueForKey:ECOMAP_PROBLEM_MODERATION] integerValue] : 0;
        self.votes = ![[problem valueForKey:ECOMAP_PROBLEM_VOTES] isKindOfClass:[NSNull class]] ? [[problem valueForKey:ECOMAP_PROBLEM_VOTES] integerValue] : 0;
    }
}

- (BOOL)canVote:(EcomapLoggedUser *)loggedUser
{
    BOOL canVote = YES;
    if(loggedUser) {
        for(EcomapComments *comment in self.comments) {
            if (comment.activityTypes_Id == 3) { // vote activity type
                canVote &= comment.usersID != loggedUser.userID;
            }
        }
    } else {
        if([[[NSUserDefaults standardUserDefaults] arrayForKey:@"votedPosts"] containsObject:@(self.problemID)])
            canVote = NO;
    }
    return canVote;
}

@end
