//
//  JKSHoedownRendererTest.m
//  CocoaHoedown
//
//  Created by Sørensen, Johan on 05.01.14.
//  Copyright (c) 2014 Frosthaus AS. All rights reserved.
//

#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import "Expecta.h"
#import "JKSHoedownRenderer.h"

@interface JKSHoedownRendererTest : XCTestCase

@end

@implementation JKSHoedownRendererTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithString
{
    JKSHoedownRenderer *r2 = [[JKSHoedownRenderer alloc] initWithString:@"foo"];
    expect([r2 valueForKey:@"markdownData"]).to.equal([@"foo" dataUsingEncoding:NSUTF8StringEncoding]);
}


- (void)testRenderingEmptyString {
    JKSHoedownRenderer *renderer = [[JKSHoedownRenderer alloc] initWithString:nil];
    expect([renderer renderedHTML]).to.beNil();

    renderer = [[JKSHoedownRenderer alloc] initWithString:@""];
    expect([renderer renderedHTML]).to.beNil();
}


- (void)testSimpleRendering {
    JKSHoedownRenderer *renderer = [[JKSHoedownRenderer alloc] initWithString:@"foo _bar_ **baz**"];
    expect([renderer renderedHTML]).to.equal(@"<p>foo <em>bar</em> <strong>baz</strong></p>\n");
}

@end
