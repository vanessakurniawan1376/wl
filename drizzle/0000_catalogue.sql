CREATE TABLE products (
 id TEXT PRIMARY KEY NOT NULL,
 category TEXT NOT NULL,
 name TEXT NOT NULL,
 description TEXT NOT NULL DEFAULT '',
 price INTEGER,
 unit TEXT NOT NULL DEFAULT 'pak',
 image TEXT NOT NULL DEFAULT '',
 visible INTEGER NOT NULL DEFAULT 1,
 example INTEGER NOT NULL DEFAULT 0,
 updated_at TEXT NOT NULL
);
--> statement-breakpoint
CREATE TABLE shop_settings (
 id INTEGER PRIMARY KEY NOT NULL,
 value TEXT NOT NULL,
 updated_at TEXT NOT NULL
);
