# SQL 💀💀💀

This repository is a playground for learning SQL and different ORMs.

## Environment (Docker) 🐳

I will be using docker to spin up a `mysql` container.

```bash
docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=root -d -p 3306:3306 mysql:latest
```

## Connecting to the database 🚪

For connecting to the container with `mysql`:

```bash
docker exec -it mysql-container mysql -u root -p
```

For removing all the stopped containers:

```bash
docker container prune
```

For copying the `schema.sql` file to the container:

```bash
docker cp <path.sql> mysql-container:/
```

For executing the `schema.sql` file inside the container:

```bash
docker exec -it mysql-container bash -c 'mysql -u root -p < /schema.sql'
```

## SQL (MySQL Shell) 🐚

1. For listing all the databases:

```sql
SHOW DATABASES;
```

2. For creating a new database:

```sql
CREATE DATABASE IF NOT EXISTS <database_name>;
```

3. For using a database:

```sql
USE <database_name>;
```

4. For listing all the tables:

```sql
SHOW TABLES;
```

5. For viewing the current database:

```sql
SELECT DATABASE();
```

6. For viewing the current user:

```sql
SELECT USER();
```
## .NET 8.0 🚀 + EF Core

1. For creating a new console project:

```bash
dotnet new console -n <project_name>
```

2. For adding the `EF Core` package:

```bash
dotnet tool install --global dotnet-ef
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Pomelo.EntityFrameworkCore.MySql
dotnet add package Microsoft.EntityFrameworkCore.Design
```

3. For creating migrations:

```bash
dotnet ef migrations add <MigrationName>
```

4. For updating the database:

```bash
dotnet ef database update
```
