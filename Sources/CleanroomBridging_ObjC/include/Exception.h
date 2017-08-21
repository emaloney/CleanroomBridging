//
//  Exception.h
//  Cleanroom Project
//
//  Created by Evan Maloney on 12/23/14.
//  Copyright © 2014 Gilt Groupe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ExceptionTryBlock)(void);
typedef void (^ExceptionCatchBlock)(NSException* __nonnull ex);
typedef void (^ExceptionFinallyBlock)(void);

@interface Exception : NSObject

+ (BOOL) doTry:(nonnull ExceptionTryBlock)tryBlock
catchException:(nullable ExceptionCatchBlock)catchBlock
       finally:(nullable ExceptionFinallyBlock)finallyBlock;

+ (BOOL) doTry:(nonnull ExceptionTryBlock)tryBlock
catchException:(nullable ExceptionCatchBlock)catchBlock;

+ (BOOL) doTry:(nonnull ExceptionTryBlock)tryBlock
       finally:(nullable ExceptionFinallyBlock)finallyBlock;

+ (BOOL) doTry:(nonnull ExceptionTryBlock)tryBlock;

+ (void) throwException:(nonnull NSException*)exception;

+ (void) throwExceptionWithName:(nonnull NSString*)exceptionName
                         reason:(nullable NSString*)reason
                       userInfo:(nullable NSDictionary*)info;

+ (void) throwExceptionWithName:(nonnull NSString*)exceptionName
                         reason:(nullable NSString*)reason;

+ (void) throwExceptionWithName:(nonnull NSString*)exceptionName;

@end
