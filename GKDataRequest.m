//
//  GKDataRequest.m
//  GKKit
//
//  Created by Matt Gallagher on 4/08/08. (XPath Query Functions)
//  Modified by Gaurav Khanna on 7/14/10 (cocoa class wrapper implementation)
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#if IPHONE_ONLY

#import "GKDataRequest.h"

#pragma mark - XPath Query Functions

NSDictionary *DictionaryForNode(xmlNodePtr currentNode, NSMutableDictionary *parentResult);
NSArray *PerformXPathQuery(xmlDocPtr doc, NSString *query);
NSArray *PerformHTMLXPathQuery(NSData *document, NSString *query);
NSArray *PerformXMLXPathQuery(NSData *document, NSString *query);
NSString *PerformHTMLXPathExtraction(NSData *document, NSString *query);

NSDictionary *DictionaryForNode(xmlNodePtr currentNode, NSMutableDictionary *parentResult) {
	NSMutableDictionary *resultForNode = [NSMutableDictionary dictionary];

	if (currentNode->name) {
		NSString *currentNodeContent =
        [NSString stringWithCString:(const char *)currentNode->name encoding:NSUTF8StringEncoding];
		[resultForNode setObject:currentNodeContent forKey:@"nodeName"];
	}

	if (currentNode->content && currentNode->type != XML_DOCUMENT_TYPE_NODE) {
		NSString *currentNodeContent = [NSString stringWithCString:(const char *)currentNode->content
                                                          encoding:NSUTF8StringEncoding];

		if ([[resultForNode objectForKey:@"nodeName"] isEqual:@"text"] && parentResult) {
			currentNodeContent = [currentNodeContent
                                  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

			NSString *existingContent = [parentResult objectForKey:@"nodeContent"];
			NSString *newContent;
			if (existingContent) {
				newContent = [existingContent stringByAppendingString:currentNodeContent];
			} else {
				newContent = currentNodeContent;
			}

			[parentResult setObject:newContent forKey:@"nodeContent"];
			return nil;
		}

		[resultForNode setObject:currentNodeContent forKey:@"nodeContent"];
	}

	xmlAttr *attribute = currentNode->properties;
	if (attribute) {
		NSMutableArray *attributeArray = [NSMutableArray array];
		while (attribute) {
			NSMutableDictionary *attributeDictionary = [NSMutableDictionary dictionary];
			NSString *attributeName =
            [NSString stringWithCString:(const char *)attribute->name encoding:NSUTF8StringEncoding];
			if (attributeName) {
				[attributeDictionary setObject:attributeName forKey:@"attributeName"];
			}

			if (attribute->children) {
				NSDictionary *childDictionary = DictionaryForNode(attribute->children, attributeDictionary);
				if (childDictionary) {
					[attributeDictionary setObject:childDictionary forKey:@"attributeContent"];
				}
			}

			if ([attributeDictionary count] > 0) {
				[attributeArray addObject:attributeDictionary];
			}
			attribute = attribute->next;
		}

		if ([attributeArray count] > 0) {
			[resultForNode setObject:attributeArray forKey:@"nodeAttributeArray"];
		}
	}

	xmlNodePtr childNode = currentNode->children;
	if (childNode) {
		NSMutableArray *childContentArray = [NSMutableArray array];
		while (childNode) {
			NSDictionary *childDictionary = DictionaryForNode(childNode, resultForNode);
			if (childDictionary) {
				[childContentArray addObject:childDictionary];
			}
			childNode = childNode->next;
		}
		if ([childContentArray count] > 0) {
			[resultForNode setObject:childContentArray forKey:@"nodeChildArray"];
		}
	}

	return resultForNode;
}

NSArray *PerformXPathQuery(xmlDocPtr doc, NSString *query) {
    xmlXPathContextPtr xpathCtx;
    xmlXPathObjectPtr xpathObj;

    /* Create xpath evaluation context */
    xpathCtx = xmlXPathNewContext(doc);
    if(xpathCtx == NULL) {
		NSLog(@"Unable to create XPath context.");
		return nil;
    }

    /* Evaluate xpath expression */
    xpathObj = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], xpathCtx);
    if(xpathObj == NULL) {
		NSLog(@"Unable to evaluate XPath.");
		return nil;
    }

	xmlNodeSetPtr nodes = xpathObj->nodesetval;
	if (!nodes) {
		NSLog(@"Nodes was nil.");
		return nil;
	}

	NSMutableArray *resultNodes = [NSMutableArray array];
	for (NSInteger i = 0; i < nodes->nodeNr; i++) {
		NSDictionary *nodeDictionary = DictionaryForNode(nodes->nodeTab[i], nil);
		if (nodeDictionary) {
			[resultNodes addObject:nodeDictionary];
		}
	}

    /* Cleanup */
    xmlXPathFreeObject(xpathObj);
    xmlXPathFreeContext(xpathCtx);

    return resultNodes;
}

NSArray *PerformHTMLXPathQuery(NSData *document, NSString *query) {
    xmlDocPtr doc;

    /* Load XML document */
	doc = htmlReadMemory([document bytes], [document length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);

    if (doc == NULL) {
		NSLog(@"Unable to parse.");
		return nil;
    }

	NSArray *result = PerformXPathQuery(doc, query);
    xmlFreeDoc(doc);

	return result;
}

NSArray *PerformXMLXPathQuery(NSData *document, NSString *query) {
    xmlDocPtr doc;

    /* Load XML document */
	doc = xmlReadMemory([document bytes], [document length], "", NULL, XML_PARSE_RECOVER);

    if (doc == NULL) {
		NSLog(@"Unable to parse.");
		return nil;
    }

	NSArray *result = PerformXPathQuery(doc, query);
    xmlFreeDoc(doc);

	return result;
}

NSString *PerformHTMLXPathExtraction(NSData *document, NSString *query) {
    xmlDocPtr doc;
    NSString *result = nil;

    /* Load XML document */
	doc = htmlReadMemory([document bytes], [document length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);

    if (doc == NULL) {
		NSLog(@"Unable to parse.");
		return nil;
    }

    xmlXPathContextPtr xpathCtx;
    xmlXPathObjectPtr xpathObj;

    /* Create xpath evaluation context */
    xpathCtx = xmlXPathNewContext(doc);
    if(xpathCtx == NULL) {
		NSLog(@"Unable to create XPath context.");
		return nil;
    }

    /* Evaluate xpath expression */
    xpathObj = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], xpathCtx);
    if(xpathObj == NULL) {
		NSLog(@"Unable to evaluate XPath.");
		return nil;
    }

	xmlNodeSetPtr nodes = xpathObj->nodesetval;
	if (!nodes) {
		NSLog(@"Nodes was nil.");
		return nil;
	}

    xmlBufferPtr dumpBfr = xmlBufferCreate();
    htmlNodeDump(dumpBfr, doc, nodes->nodeTab[0]);

    if(dumpBfr->content == NULL) {
        NSLog(@"Unable to extract content");
        return nil;
    }

	result = [NSString stringWithUTF8String:(char const *)dumpBfr->content];

    xmlBufferFree(dumpBfr);
    xmlXPathFreeObject(xpathObj);
    xmlXPathFreeContext(xpathCtx);

    xmlFreeDoc(doc);

	return result;
}

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

#pragma mark - ASIHTTPRequest Delegate methods

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

}

- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request {

}


#pragma mark - XPathAdditions

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

#pragma mark - Memory Management

#ifndef ARC_MEM_MGMT
- (void)dealloc {
    xmlXPathFreeContext(_xpathCtx);
    xmlFreeDoc(_xpathDoc);
    [_completionBlock release];
    [super dealloc];
}
#endif
@end

#endif