//
//  DelegateInterceptor.m
//  DelegateInterceptor
//
//  Created by YLCHUN on 16/8/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "DelegateInterceptor.h"
#include <map>
#include <string>

typedef std::map<std::string, bool> DIResponds;

@implementation DelegateInterceptor
{
    DIResponds original_responds;
    DIResponds accepter_responds;
    DIResponds super_responds;
    __weak id _original;
    __weak id _accepter;
}

- (instancetype) initWithOriginal:(id)original accepter:(id)accepter
{
    self = [super init];
    if (self)
    {
        _original = original;
        _accepter = accepter?:self;
    }
    return self;
}

- (instancetype) initWithOriginal:(id)original
{
    return [self initWithOriginal:original accepter:nil];
}

static bool respondsToSelector(DIResponds &responds_map, id obj, SEL aSelector)
{
    if (obj == nil) {
        return false;
    }
    bool b = false;
    std::string sel_name = sel_getName(aSelector);
    if (responds_map.find(sel_name) == responds_map.end())
    {
        b = [obj respondsToSelector:aSelector];
        responds_map.insert(std::make_pair(sel_name, b));
    }
    else
    {
        b = responds_map.at(sel_name);
    }
    return b;
}

-(bool)originalRespondsToSelector:(SEL)aSelector
{
    return respondsToSelector(original_responds, _original, aSelector);
}

-(bool)accepterRespondsToSelector:(SEL)aSelector
{
    if (_accepter == self) {
        return [self superRespondsToSelector:aSelector];
    }
    return respondsToSelector(accepter_responds, _accepter, aSelector);
}

-(bool)superRespondsToSelector:(SEL)aSelector
{
    bool b = false;
    std::string sel_name = sel_getName(aSelector);
    if (super_responds.find(sel_name) == super_responds.end())
    {
        b = [super respondsToSelector:aSelector];
        super_responds.insert(std::make_pair(sel_name, b));
    }
    else
    {
        b = super_responds.at(sel_name);
    }
    return b;
}

- (void)dealloc
{
    accepter_responds.clear();
    original_responds.clear();
    super_responds.clear();
}


- (BOOL) respondsToSelector:(SEL)aSelector
{
    if ([self accepterRespondsToSelector:aSelector]) {
        return YES;
    }
    if ([self originalRespondsToSelector:aSelector]) {
        return YES;
    }
    return NO;
}

- (id) forwardingTargetForSelector:(SEL)aSelector
{
    if ([self accepterRespondsToSelector:aSelector]) {
        return _accepter;
    }
    if ([self originalRespondsToSelector:aSelector]) {
        return _original;
    }
    return nil;
}

- (id) original
{
    return _original;
}

- (id) accepte
{
    return _accepter;
}

-(id) mySelf
{
    return self;
}

@end
