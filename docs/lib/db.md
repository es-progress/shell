# DataBase

Functions for MySQL databases.

---

## db-dump-data-db

Dump full DB. Only data (each record on a separate row) is exported with no table structures.
This could be useful for debugging as it allows a readable diff for changes in data.

**Usage**

```
db-dump-data-db DB [EXTRA]...

Params:
DB                 DataBase name
EXTRA              Optional extra params to 'mysqldump'
```

---

## db-dump-data-tables

Dump specific tables from DB. Only data (each record on a separate row) is exported with no table structures.
This could be useful for debugging as it allows a readable diff for changes in data. Also for export-change-import operations.

**Usage**

```
db-dump-data-tables DB TABLE...

Params:
DB                 DataBase name
TABLE              Tables to export
```

---

## db-dump-full-db

Dump full DB (data in compact form + table structures). This could be used for backups and migrations.

**Usage**

```
db-dump-full-db DB [EXTRA]...

Params:
DB                 DataBase name
EXTRA              Optional extra params to 'mysqldump'
```

---

## db-dump-full-tables

Dump specific tables from DB. Data (in compact form) and table structure is exported also.

**Usage**

```
db-dump-full-tables DB TABLE...

Params:
DB                 DataBase name
TABLE              Tables to export
```

---

## db-dump-structure-db

Dump full DB structure. No data exported.

**Usage**

```
db-dump-structure-db DB [EXTRA]...

Params:
DB                 DataBase name
EXTRA              Optional extra params to 'mysqldump'
```

---

## db-dump-structure-tables

Dump specific table structures from DB. No data exported.

**Usage**

```
db-dump-structure-tables DB TABLE...

Params:
DB                 DataBase name
TABLE              Tables to export
```

---

## db-dump-wrapper

Base wrapper for `mysqldump`. The other specific dumper functions add parameters to this function to achieve desired behaviour.

**Usage**

```
db-dump-wrapper PARAMS...

Params:
PARAMS             Params to 'mysqldump'
```

---

## db-list-tables

List all tables in a DataBase, each table on a new line for easy further processing.
Tables can be filtered by pattern where SQL style wildcards are allowed.

**Usage**

```
db-list-tables DB PATTERN

Params:
DB                 DataBase name
PATTERN            Pattern to filter tables. SQL wildcards are allowed, e.g. '%cache%'.
```

---

## db-query

Run single queries on a DataBase.

**Usage**

```
db-query DB QUERY [EXTRA]...

Params:
DB                 DataBase name
QUERY              Query to execute
EXTRA              Optional extra params to 'mysql'
```
