//
//  FSCalendarDelegationProxy.h
//  FSCalendar
//
//  11/12/2016.
//  
//
//  https://github.com/WenchaoD
//
//  1. Smart proxy delegation http://petersteinberger.com/blog/2013/smart-proxy-delegation/
//  2. Manage deprecated delegation functions
//

#import <Foundation/Foundation.h>
#import "FSCalendar.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSCalendarDelegationProxy : NSProxy

@property (weak  , nonatomic) id delegation;
@property (strong, nonatomic) Protocol *protocol;
@property (strong, nonatomic) NSDictionary<NSString *,NSString *> *deprecations;

- (instancetype)init;
- (SEL)deprecatedSelectorOfSelector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END

