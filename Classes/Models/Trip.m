#import "Trip.h"
#import "Landmark.h"
#import "Database.h"

static NSMutableArray *trips;
static sqlite3_stmt *insert_statement = nil;
static sqlite3_stmt *update_statement = nil;

@interface Trip (Private)
- (void)update:(sqlite3 *)database;
- (void)insert:(sqlite3 *)database;
@end

@implementation Trip

@synthesize title, description, landmarks;

+ (NSMutableArray *)getTrips {
  if (trips == nil) {
    trips = [[NSMutableArray alloc] init];
	
		Statement *statement = [Database 
			prepareStatement:@"SELECT primary_key, title, description FROM trips"];
			
		if (![statement inError]) {
			while ([statement nextRow]) {	
				int primaryKey = [statement intAtColumn:0];
				NSString *title = [statement textAtColumn:1];
				NSString *description = [statement textAtColumn:2];

				Trip *trip = [[Trip alloc] initWithPrimaryKey:primaryKey 
					title:title description:description];

				int y;
				for (y = 0; y < 5; y++) {
					Landmark *landmark = [[Landmark alloc] 
						initWithAddress:@"123 Main St" city:@"Seattle" state:@"WA"];
						
					[trip addLandmark:landmark];
				}
				
				[trips addObject:trip];
				[trip release];
			}
		}
		else {
			NSAssert1(0, @"Failed to read trips: '%s'", [statement errorMessage]);
		}
		[statement finalize];
  }
  return trips;
}

- (id)initWithPrimaryKey:(NSInteger)pk title:(NSString *)aTitle description:(NSString *) aDescription {
  if (self = [super init]) {
    landmarks = [[NSMutableArray alloc] init];
		primaryKey = pk;
    self.title = aTitle;
		self.description = aDescription;
		dirty = NO;
  }
  return self;
}


- (id)initWithTitle:(NSString *)aTitle description:(NSString *) aDescription {
  if (self = [super init]) {
    landmarks = [[NSMutableArray alloc] init];
    self.title = aTitle;
		self.description = aDescription;
		dirty = YES;
  }
  return self;
}

- (void)addLandmark:(Landmark *)aLandmark {
	[landmarks addObject:aLandmark];
}


// Finalize (delete) all of the SQLite compiled queries.
+ (void)finalizeStatements {
	if (insert_statement) sqlite3_finalize(insert_statement);
	if (update_statement) sqlite3_finalize(update_statement);
}

- (void)saveOrUpdate:(sqlite3 *)database {
  if (primaryKey > 0) {
		[self update:database];
	} else {
	  [self insert:database];
	}
}

- (void)update:(sqlite3 *)database {
						
	if (update_statement == nil) {
			static char *sql = "UPDATE trips set title = ?, description = ? WHERE primary_key = ?";
			if (sqlite3_prepare_v2(database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			}
	}

	// Bind the query variables.
	sqlite3_bind_text(update_statement, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(update_statement, 2, [description UTF8String], -1, SQLITE_TRANSIENT);
  sqlite3_bind_int(update_statement, 3, primaryKey);

	int success = sqlite3_step(update_statement);

	// Because we want to reuse the statement, we "reset" it instead of "finalizing" it.
	sqlite3_reset(update_statement);

	if (success != SQLITE_ERROR) {
		NSAssert1(0, @"Error: failed update trip in the database with message '%s'.", sqlite3_errmsg(database));
	}
	dirty = NO;
}

- (void)insert:(sqlite3 *)database {
						
	if (insert_statement == nil) {
			static char *sql = "INSERT INTO trips (title, description) VALUES (?, ?)";
			if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			}
	}

	// Bind the query variables.
	sqlite3_bind_text(insert_statement, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(insert_statement, 2, [description UTF8String], -1, SQLITE_TRANSIENT);

	int success = sqlite3_step(insert_statement);

	// Because we want to reuse the statement, we "reset" it instead of "finalizing" it.
	sqlite3_reset(insert_statement);

	if (success != SQLITE_ERROR) {
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
	}

	// SQLite provides a method which retrieves the value of the most recently auto-generated primary key sequence
	// in the database. To access this functionality, the table should have a column declared of type 
	// "INTEGER PRIMARY KEY"
	primaryKey = sqlite3_last_insert_rowid(database);
	dirty = NO;
}

- (void)dealloc {
  [super dealloc];
  [title release];
	[description release];
	[landmarks release];
}
@end
