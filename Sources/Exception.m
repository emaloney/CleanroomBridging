//
//  Exception.m
//  Cleanroom Project
//
//  Created by Evan Maloney on 12/23/14.
//  Copyright © 2014 Gilt Groupe. All rights reserved.
//

#import "Exception.h"

@implementation Exception

+ (BOOL) doTry:(nonnull ExceptionTryBlock)tryBlock
catchException:(nullable ExceptionCatchBlock)catchBlock
       finally:(nullable ExceptionFinallyBlock)finallyBlock
{
    BOOL succeeded = NO;
    @try {
        tryBlock();
        succeeded = YES;
    }
    @catch (NSException* ex) {
        if (catchBlock) {
            catchBlock(ex);
        }
    }
    @finally {
        if (finallyBlock) {
            finallyBlock();
        }
    }
    return succeeded;
}

+ (BOOL) doTry:(nonnull ExceptionTryBlock)tryBlock
catchException:(nullable ExceptionCatchBlock)catchBlock
{
    return [self doTry:tryBlock catchException:catchBlock finally:nil];
}


+ (BOOL) doTry:(nonnull ExceptionTryBlock)tryBlock
       finally:(nullable ExceptionFinallyBlock)finallyBlock
{
    return [self doTry:tryBlock
        catchException:^(NSException* ex) {NSLog(@"%@ caught %@: %@\n%@", self, [ex class], ex.description, [ex.callStackSymbols componentsJoinedByString:@"\n"]);}
               finally:finallyBlock];
}

+ (BOOL) doTry:(nonnull ExceptionTryBlock)tryBlock
{
    return [self doTry:tryBlock
        catchException:^(NSException* ex) {NSLog(@"%@ caught %@: %@\n%@", self, [ex class], ex.description, [ex.callStackSymbols componentsJoinedByString:@"\n"]);}
               finally:nil];
}

+ (void) throwException:(nonnull NSException*)exception
{
    // yes, strictly speaking, this would accept a nullable
    // `exception` parameter, but we want the API to describe
    // the intent, not just 'what works'
    [exception raise];
}

+ (void) throwExceptionWithName:(nonnull NSString*)exceptionName
{
    [[[NSException alloc] initWithName:exceptionName reason:nil userInfo:nil] raise];
}

+ (void) throwExceptionWithName:(NSString*)exceptionName reason:(NSString*)reason
{
    [[[NSException alloc] initWithName:exceptionName reason:reason userInfo:nil] raise];
}

+ (void) throwExceptionWithName:(NSString*)exceptionName reason:(NSString*)reason userInfo:(NSDictionary*)info
{
    [[[NSException alloc] initWithName:exceptionName reason:reason userInfo:info] raise];
}

@end
