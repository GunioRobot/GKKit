//
//  GKDataRequest.h
//  GKKit
//
//  Created by Gaurav Khanna on 7/14/10.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"

@class ASIHTTPRequest, ASIFormDataRequest;

typedef void (^GKDataRequestBlock)(BOOL completion);

@interface GKDataRequest : ASIFormDataRequest <ASIHTTPRequestDelegate> {
    GKDataRequestBlock _completionBlock;
    xmlXPathContextPtr _xpathCtx;
    xmlDocPtr _xpathDoc;
}

+ (id)requestWithString:(NSString *)newStringURL;
- (id)initWithURL:(NSURL *)newURL;
- (void)startAsynchronousWithCompletion:(GKDataRequestBlock)completion;

@end

@interface GKDataRequest (XPathAdditions)

- (id)dictionaryFromXPathQuery:(NSString *)query;
- (id)stringFromXPathQuery:(NSString *)query;
- (id)contentStringFromXPathQuery:(NSString *)query;
- (id)attributeStringFromXPathQuery:(NSString *)query;

@end