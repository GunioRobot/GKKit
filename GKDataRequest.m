//
//  CBHTTPRequest.m
//  GKKit
//
//  Created by Gaurav Khanna on 7/14/10.
//

#import "GKDataRequest.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "XPathQuery.h"
#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>
#import <libxml/HTMLtree.h>

@implementation GKDataRequest

+ (id)requestWithString:(NSString *)newStringURL {
    return [GKDataRequest requestWithURL:[NSURL URLWithString:newStringURL]];
}

- (id)initWithURL:(NSURL *)newURL {
    if((self = [super initWithURL:newURL])) {
        _completionBlock = nil;
        _xpathDoc = NULL;
        _xpathCtx = NULL;
        [self addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-US) AppleWebKit/534.2 (KHTML, like Gecko) Chrome/6.0.447.0 Safari/534.2"];
        [self setDelegate:self];
    }
    return self;
}

- (void)startAsynchronousWithCompletion:(GKDataRequestBlock)completion {
    _completionBlock = [completion copy];
    [self startAsynchronous];
}

#pragma mark -
#pragma mark ASIHTTPRequest Delegate methods

// These are the default delegate methods for request status
// You can use different ones by setting didStartSelector / didFinishSelector / didFailSelector
/*- (void)requestStarted:(ASIHTTPRequest *)request {
 DLogFunc();
 }
 
 - (void)requestReceivedResponseHeaders:(ASIHTTPRequest *)request {
 DLogFunc();
 }*/

- (void)requestFinished:(ASIHTTPRequest *)request {
    _xpathDoc = htmlReadMemory([[self responseData] bytes], [[self responseData] length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);
    if(_xpathDoc == NULL) {
        NSLog(@"Unable to parse.");
		_completionBlock(FALSE);
        return;
    }
    _xpathCtx = xmlXPathNewContext(_xpathDoc);
    if(_xpathCtx == NULL) {
        NSLog(@"Unable to create XPath context.");
		_completionBlock(FALSE);
        return;
    }
    _completionBlock(TRUE);
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    _completionBlock(FALSE);
}

// When a delegate implements this method, it is expected to process all incoming data itself
// This means that responseData / responseString / downloadDestinationPath etc are ignored
// You can have the request call a different method by setting didReceiveDataSelector
/*- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data {
 DLogFunc();
 }*/

// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request {
    DLogFunc();
}

- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request {
    DLogFunc();
}


#pragma mark -
#pragma mark XPathAdditions

xmlXPathObjectPtr xmlXPathObjectFromEvalOfQuery(NSString *query, xmlXPathContextPtr ctx) {
    xmlXPathObjectPtr xpathObj = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], ctx);
    if(xpathObj == NULL) {
        NSLog(@"Unable to evaluate XPath.");
        return NULL;
    }
    if(!xpathObj->nodesetval) {
        NSLog(@"Nodes was nil.");
        return NULL;
    }
    return xpathObj;
}

- (id)dictionaryFromXPathQuery:(NSString *)query {
    return PerformHTMLXPathQuery([self responseData], query);
}

- (id)stringFromXPathQuery:(NSString *)query {
    if(_xpathCtx != NULL) {
        xmlXPathObjectPtr xpathObj = xmlXPathObjectFromEvalOfQuery(query,_xpathCtx);
        
        if(xpathObj == NULL)
            return nil;
        
        NSString *result = nil;
        
        xmlBufferPtr dumpBfr = xmlBufferCreate();
        htmlNodeDump(dumpBfr, _xpathDoc, xpathObj->nodesetval->nodeTab[0]);
        
        if(dumpBfr->content == NULL) {
            NSLog(@"Unable to extract content");
            return nil;
        }
        
        result = [NSString stringWithUTF8String:(char const *)dumpBfr->content];
        
        xmlBufferFree(dumpBfr);
        xmlXPathFreeObject(xpathObj);

        return [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return nil;
}

- (id)contentStringFromXPathQuery:(NSString *)query {
    if(_xpathCtx != NULL) {
        xmlXPathObjectPtr xpathObj = xmlXPathObjectFromEvalOfQuery(query,_xpathCtx);
        
        if(xpathObj == NULL)
            return nil;
        
        NSString *result = nil;
        
        xmlChar *content = xmlNodeGetContent(xpathObj->nodesetval->nodeTab[0]);
        result = [NSString stringWithUTF8String:(const char *)content];
        xmlFree(content);
        
        xmlXPathFreeObject(xpathObj);
        
        return [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return nil;
    
}

- (id)attributeStringFromXPathQuery:(NSString *)query {
    if(_xpathCtx != NULL) {
        xmlXPathObjectPtr xpathObj = xmlXPathObjectFromEvalOfQuery(query,_xpathCtx);
        
        if(xpathObj == NULL)
            return nil;
        
        NSString *result = nil;
        
        xmlChar *content = xmlNodeGetContent(xpathObj->nodesetval->nodeTab[0]->children);
        result = [NSString stringWithUTF8String:(char const *)content];
        xmlFree(content);
        
        xmlXPathFreeObject(xpathObj);
        
        return [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return nil;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    xmlXPathFreeContext(_xpathCtx);
    xmlFreeDoc(_xpathDoc);
    [_completionBlock release];
    [super dealloc];
}

@end
