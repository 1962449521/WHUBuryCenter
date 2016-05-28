//
//  main.m
//  WHUBuryCenterDemo
//
//  Created by Mitty on 16/4/16.
//  Copyright © 2016年 Mitty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHUBuryCenter.h"

@interface MyClass1 : NSObject

- (void) doSthWhenDealloc;

@end

@implementation MyClass1

- (void) doSthWhenDealloc {
    NSLog(@"%@ dealloc", self);
}

@end

@interface MyClass2 : NSObject

- (void) doSthWhenDealloc;

@end

@implementation MyClass2

- (void) doSthWhenDealloc {
    NSLog(@"%@ dealloc", self);
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        @autoreleasepool {

            MyClass1 *obj1 = [MyClass1 new];
            MyClass2 *obj2 = [MyClass2 new];
            
            [WHUBuryCenter addBuryTask:^{
                NSLog(@"obj1 dealloc task 1 executed");
            } target:obj1];
            
            [WHUBuryCenter addBuryTask:^{
                NSLog(@"obj2 dealloc task 1 executed");
            } target:obj2];
            
            __weak MyClass1 *obj1WeakRef = obj1;
            [WHUBuryCenter addBuryTask:^{
                [obj1WeakRef doSthWhenDealloc];
            } target:obj1];
            
            __weak MyClass2 *obj2WeakRef = obj2;
            [WHUBuryCenter addBuryTask:^{
                [obj2WeakRef doSthWhenDealloc];
            } target:obj2];

        }

    }
    return 0;
}
