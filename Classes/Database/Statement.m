#import "Statement.h"

@implementation Statement

- (id)initWithDB:(sqlite3 *)db SQL:(NSString *)sqlString {
  if (self = [super init]) {
		const char *sql = [sqlString cStringUsingEncoding:[NSString defaultCStringEncoding]];
		
		if (sqlite3_prepare_v2(db, sql, -1, &statement, NULL) != SQLITE_OK) {
			errorMessage = [[NSString alloc] initWithCString:sqlite3_errmsg(db)];
			sqlite3_finalize(statement);
			statement = nil;
		}
	}
	return self;
}

- (int)intAtColumn:(int)column {
	return sqlite3_column_int(statement, column);
}

- (NSString *)textAtColumn:(int)column {
	return [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, column)];
}

- (BOOL)step {
  status = sqlite3_step(statement);
	return (status == SQLITE_ROW);
}

- (BOOL)nextRow {
  status = sqlite3_step(statement);
	return (status == SQLITE_ROW);
}

- (int)status {
	return status;
}

- (BOOL)isOpen {
	return (statement != nil);
}

- (BOOL)inError {
	return (errorMessage != nil);
}

- (NSString *)errorMessage {
	return errorMessage;
}

- (void)finalize {
	sqlite3_finalize(statement);
	statement = nil;
}

@end
