#import "/usr/include/sqlite3.h"

@interface Statement : NSObject {
	sqlite3      *sqliteDb;
	sqlite3_stmt *statement;
	int          status;
	NSString     *errorMessage;
}

- (id)initWithDB:(sqlite3 *)db SQL:(NSString *)sqlString;
- (BOOL)inError;
- (int)status;
- (NSString *)errorMessage;
- (BOOL)isOpen;
- (BOOL)nextRow;
- (BOOL)step;
- (void)finalize;

- (int)intAtColumn:(int)column;
- (NSString *)textAtColumn:(int)column;

@end
