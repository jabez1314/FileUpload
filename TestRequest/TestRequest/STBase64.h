//
//  STBase64.h
//  TestRequest
//
//  Created by Jabez on 10/6/15.
//  Copyright © 2015 John. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (STBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;

@end
