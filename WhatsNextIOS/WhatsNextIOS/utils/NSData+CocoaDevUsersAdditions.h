//
//  NSData+CocoaDevUsersAdditions.h
//  Inmarsat
//
//  Created by Andrei on 02/06/2013.
//
//

#import <Foundation/Foundation.h>

@interface NSData (CocoaDevUsersAdditions)
// Returns range [start, null byte), or (NSNotFound, 0).
- (NSRange) rangeOfNullTerminatedBytesFrom:(int)start;

// Canonical Base32 encoding/decoding.
+ (NSData *) dataWithBase32String:(NSString *)base32;
- (NSString *) base32String;

// COBS is an encoding that eliminates 0x00.
- (NSData *) encodeCOBS;
- (NSData *) decodeCOBS;

// ZLIB
- (NSData *) zlibInflate;
- (NSData *) zlibDeflate;

// GZIP
- (NSData *) gzipInflate;
- (NSData *) gzipDeflate;

//CRC32
- (unsigned int)crc32;

// Hash
- (NSData*) md5Digest;
- (NSString*) md5DigestString;
- (NSData*) sha1Digest;
- (NSString*) sha1DigestString;
- (NSData*) ripemd160Digest;
- (NSString*) ripemd160DigestString;

@end
