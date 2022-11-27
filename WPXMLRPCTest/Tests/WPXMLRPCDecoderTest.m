#import "WPXMLRPCDecoder.h"
#import "WPStringUtils.h"
#import "Helper.h"
#import <XCTest/XCTest.h>

@interface WPXMLRPCDecoderTest : XCTestCase
@end

@implementation WPXMLRPCDecoderTest {
    NSDictionary *myTestCases;
}

- (void)setUp {
    myTestCases = [self testCases];
    XCTAssertNotNil(myTestCases);
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
}

- (void)testEventBasedParser {
    NSEnumerator *testCaseEnumerator = [myTestCases keyEnumerator];
    id testCaseName;
    
    while (testCaseName = [testCaseEnumerator nextObject]) {
        if ([testCaseName isEqualToString:@"IncompleteXmlTest"]) {
            continue;
        }
        NSString *testCase = [[NSBundle wpxmlrpc_assetsBundle] pathForResource:testCaseName ofType:@"xml"];
        NSData *testCaseData =[[NSData alloc] initWithContentsOfFile:testCase];
        WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:testCaseData];
        id testCaseResult = [myTestCases objectForKey:testCaseName];
        id parsedResult = [decoder object];

        XCTAssertEqualObjects(parsedResult, testCaseResult);
    }
}

- (void)testCTidyDataCleaner {
    // Only run if CTidy is available
    if (!NSClassFromString(@"CTidy")) {
        return;
    }
    NSString *testCaseName = @"IncompleteXmlTest";
    NSString *testCase = [[NSBundle wpxmlrpc_assetsBundle] pathForResource:testCaseName ofType:@"xml"];
    NSData *testCaseData =[[NSData alloc] initWithContentsOfFile:testCase];
    WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:testCaseData];
    id testCaseResult = [myTestCases objectForKey:testCaseName];
    id parsedResult = [decoder object];

    XCTAssertEqualObjects(parsedResult, testCaseResult);
}

- (void)testNoXmlThrowsError {
    NSString *testCase = [[NSBundle wpxmlrpc_assetsBundle] pathForResource:@"NoXmlResponseTestCase" ofType:@"xml"];
    NSData *testCaseData =[[NSData alloc] initWithContentsOfFile:testCase];
    WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:testCaseData];
    XCTAssertNil([decoder object]);
    XCTAssertNotNil([decoder error]);
    NSError *error = [decoder error];
    XCTAssertEqualObjects([error domain], WPXMLRPCErrorDomain);
    XCTAssertEqual([error code], WPXMLRPCInvalidInputError);
}

- (void)testInvalidFaultXmlThrowsError {
    NSString *testCase = [[NSBundle wpxmlrpc_assetsBundle] pathForResource:@"InvalidFault" ofType:@"xml"];
    NSData *testCaseData =[[NSData alloc] initWithContentsOfFile:testCase];
    WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:testCaseData];
    XCTAssertNotNil([decoder object]);
    XCTAssertNotNil([decoder error]);
    NSError *error = [decoder error];
    XCTAssertEqualObjects([error domain], WPXMLRPCErrorDomain);
    XCTAssertEqual([error code], WPXMLRPCInvalidInputError);
}

#pragma mark -

- (NSDictionary *)testCases {
    NSString *file = [[NSBundle wpxmlrpc_assetsBundle] pathForResource:@"TestCases" ofType:@"plist"];
    NSDictionary *testCases = [[NSDictionary alloc] initWithContentsOfFile:file];
    
    return testCases;
}

@end
