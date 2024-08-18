# Database

Functions for managing MySQL databases (DB), including data export, structure export, querying, and more.

---

## db-dump-data-db

Dump the full DB. Only data (each record on a separate row) are exported with no table structures.
This can be valuable for debugging, as it enables readable diffs for changes in data.

**Usage**

```
db-dump-data-db DB [EXTRA]...

Params:
DB                 Database name
EXTRA              Optional extra params to 'mysqldump'
```

---

## db-dump-data-tables

Dump specific tables from the DB. Only data (each record on a separate row) are exported with no table structures.
This could be useful for debugging as it allows a readable diff for changes in data. Also for export-change-import operations.

**Usage**

```
db-dump-data-tables DB TABLE...

Params:
DB                 Database name
TABLE              Tables to export
```

---

## db-dump-full-db

Dump the full DB (data in compact form + table structures). This could be used for backups and migrations.

**Usage**

```
db-dump-full-db DB [EXTRA]...

Params:
DB                 Database name
EXTRA              Optional extra params to 'mysqldump'
```

---

## db-dump-full-tables

Dump specific tables from DB. Data in compact form and table structure is exported also.

**Usage**

```
db-dump-full-tables DB TABLE...

Params:
DB                 Database name
TABLE              Tables to export
```

---

## db-dump-structure-db

Dump full DB structure. No data exported.

**Usage**

```
db-dump-structure-db DB [EXTRA]...

Params:
DB                 Database name
EXTRA              Optional extra params to 'mysqldump'
```

---

## db-dump-structure-tables

Dump specific table structures from DB. No data exported.

**Usage**

```
db-dump-structure-tables DB TABLE...

Params:
DB                 Database name
TABLE              Tables to export
```

---

## db-dump-wrapper

Base wrapper for `mysqldump`. The other specific dumper functions add parameters to this function to achieve desired behaviour.

**Usage**

```
db-dump-wrapper PARAMS...

Params:
PARAMS             Parameters to 'mysqldump'
```

---

## db-list-tables

List all tables in a Database, each table on a new line for easy further processing.
Tables can be filtered by pattern where SQL style wildcards are allowed.

**Usage**

```
db-list-tables DB PATTERN

Params:
DB                 Database name
PATTERN            Pattern to filter tables.
                   SQL wildcards are allowed, e.g. '%cache%'.
```

---

## db-query

Execute single queries on a database.

**Usage**

```
db-query DB QUERY [EXTRA]...

Params:
DB                 Database name
QUERY              Query to execute
EXTRA              Optional extra params to 'mysql'
```

---

## db-replace

Replace all occurences of a string in a Database table. This is basically an ETL (extract-transform-load) operation.
Table is dumped first, then `sed` substitution and changed data imported finally. Import means dropping and recreating table with new data.

Basic Regular Expressions (BRE; no `-r` switch) is used for `sed` so `+`, `?,` and `(`, `)` treated literal.
Delimiter for `sed` substition command can be changed as well, it defaults to `@` so strings can't contain `@` character.
If your string contains that character you can select a different delimiter that is not found in search or replace strings.

**Usage**

```
db-replace DB TABLE SEARCH REPLACE [DELIMITER]

Params:
DB                 Database name
TABLE              Table name
SEARCH             Search string
REPLACE            Replace string
DELIMITER          Delimiter for 'sed', defaults to '@'
```
