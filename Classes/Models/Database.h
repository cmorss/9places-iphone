#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"
#import "Statement.h"

@interface Database : NSObject {
}

+ (sqlite3 *)connection;
+ (void)close;
+ (NSInteger)getSchemaVersion;
+ (void)updateSchemaVersion:(int)version;
+ (BOOL)tableExists:(NSString *)tableName; 
+ (Statement *)prepareStatement:(NSString *)sql;
+ (void)migrate;
+ (void)remigrate;

@end
