//
//  AssociatedObject.h
//  Cleanroom Project
//
//  Created by Evan Maloney on 4/8/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, ObjectStoragePolicy) {
    ObjectStoragePolicyWeak = OBJC_ASSOCIATION_ASSIGN,
    ObjectStoragePolicyRetainNonatomic = OBJC_ASSOCIATION_RETAIN_NONATOMIC,
    ObjectStoragePolicyCopyNonatomic = OBJC_ASSOCIATION_COPY_NONATOMIC,
    ObjectStoragePolicyRetainAtomic = OBJC_ASSOCIATION_RETAIN,
    ObjectStoragePolicyCopyAtomic = OBJC_ASSOCIATION_COPY
};

@interface NSObject (CleanroomBridgingAssociatedObject)

- (void) setAssociatedObject:(nullable id)object
                      forKey:(nonnull NSString*)key
               storagePolicy:(ObjectStoragePolicy)policy;

- (nullable id) associatedObjectForKey:(nonnull NSString*)key;

@end

