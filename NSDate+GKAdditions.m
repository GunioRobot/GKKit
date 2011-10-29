//
//  NSDate+GKAdditions.m
//  GKKit
//
//  Created by Gaurav Khanna on 7/7/10.
//

#import "NSDate+GKAdditions.h"

@implementation NSDate (GKAdditions)

- (BOOL)isToday {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *today = [cal dateFromComponents:[cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]]];
    NSDate *selfDay = [cal dateFromComponents:[cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self]];

    return [today isEqualToDate:selfDay];
}

@end
