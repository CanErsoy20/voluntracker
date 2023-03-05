# afet-takip
afet-takip is a centralized application designed to provide an intuitive environment for tracking the organization of volunteer help centers that are formed with the aim of sending supplies and equipment to disaster zones.

## Purpose
The main purpose of this project is to provide an intuitive environment for tracking the organization of volunteer help centers that are formed with the aim of sending supplies and equipment to disaster zones. 

Even though these centers are established with good intentions, their needs and organization go out of control over time as the size of the organization increases and managing it becomes more complex. There is also no way for volunteers who are willing to go to these help centers to know whether there is a need of volunteers, supply, or equipment. Therefore, both the volunteers and the centers unnecessarily lose time. After the Turkey - Syria earthquake in February 2023, in Turkey, we have seen first-hand examples of the difficulties faced by volunteers in gaining information about which help centers need volunteers and supplies.  At the end, volunteers relied on external parties like WhatsApp, Google Spreadsheets to gain information about which help centers need volunteers and supply. Moreover they had questions like:
  - Which help centers currently need help and where are they located at?
  - What kind of volunteers are they looking for?
  - How many volunteers are needed?
  - How urgent is the need for volunteers?
  - If they do not need volunteers at the moment, will they need it at some point? (at busy hours)
  - What kind of supplies are needed and what are their quantities?

and so on.

To avoid these issues and optimize the overall volunteering process, we decided to create a central application to track and manage all of the needs of both the volunteers and the help centers. We aim to cover supply and volunteer management of the help centers with the hopes that both the volunteers and the help centers can be more organized. And in the end we hope that by optimizing this process, we can have more efficient disaster relief efforts.

## Setup
### Requirements
1. NodeJS
2. Docker Daemon
3. docker-compose

### Installation steps
1.  Clone this repository
    ```bash
    git clone https://github.com/selimcanglr?tab=repositories
    ```
2. Install the dependencies using your favourite package manager (we will use npm)
    ```bash
    npm install
    ```

Following these steps will make the application ready to be run.

### Running the Application
To run the application you need to make sure a few things. First of all, to be able to provide a database connection URL to Prisma, make sure to have an environment file named `.env` in the root directory of the project. If it doesn't exist, you can create it. There are two important environment variables: `DATABASE_URL` and `NODE_ENV`.

1. *`DATABASE_URL`*  should be the **connection string** for the database. By default, we have a docker-compose file that runs a PostgreSQL image in docker. If you are using the docker-compose file provided, you can use the following URL: 
    ```
    postgres://postgres:postgres@localhost:5432/<db_name>
    ``` 
    where `<db_name>` is the name of your database. 

    **If you decide to change the database specifications** in the docker-compose files or to use a completely different database, you need to provide the valid database connection string for the `DATABASE_URL` variable. Moreover, if you decide to change the database provider as well (meaning if you don't use PostgreSQL), you need to navigate to the `prisma/scheme.prisma` file and replace
    ```js
    datasource db {
        provider = "postgresql"
        url      = env("DATABASE_URL")
    }
    ```

    with 
    ```js
    datasource db {
        provider = <your_provider>
        url      = env("DATABASE_URL")
    }
    ```
    For more information about datasources, you may visit the [Prisma documentation.](https://www.prisma.io/docs/concepts/components/prisma-schema/data-sources)

2. `NODE_ENV` variable determines the mode of the application, currently `DEV` and `PROD` mods are supported (development and production, respectively).
3. After setting the environment variables and making sure you have installed the necessary requirements specified above, start the database instance:
   ```bash
    docker-compose up
   ```
4. Set up the database
   ```bash
    npx prisma migrate dev
   ```
5. Seed the database with some initial data (optional):
    ```bash
    npm run seed
    ```
   This process might take some time for the first tiem of calling it because of the initialization process, but it should be quick after that.
6. Then, run the application:
   ```bash
    npm run start
   ```
7. Voila! Your API is up and running (hopefully)!
## Resources


## Workflow and Main Concepts
### [Prisma](https://www.prisma.io/)
Prisma is an ORM that helps us read from and write to the database without writing pure SQL queries. It is a powerful and popular tool but it may have its limitations. Or we might have difficulty trying to do complex tasks on it. But I doubt it. 

### Resource Generation
You can use the `nest generate` command to generate nest modules, services, controllers, etc. 

Most of the time you will want to use the following commands:
```bash
    npm generate module

    npm generate resource

    npm generate controller

    npm generate service

    npm generate filter

    npm generate provider
```

A more detailed explanation can be found at the [Nest documentation](https://docs.nestjs.com/cli/usages#nest-generate).

### Controller-Service-Module Structure
Nest is an opininated framework. It has certain ways for doing certain things. In terms of our general structure, we will use the Module-Controller-Service structure. [Controllers](https://docs.nestjs.com/controllers) interact directly with incoming HTTP requests and use necessary services to handle a specific request. Meaning that controllers receive all the HTTP requests and create the needed HTTP response, handle errors if necessary. 

[Modules](https://docs.nestjs.com/modules) are a way of structuring the project in a more scalable way. 

### Data Transfer Objects (DTO)
Name is clearly sufficient.

### Entities
Jeez you pervert. Go and take a look at your Database Systems class.

### Validation
There are useful libraries like `class-validator` and I forgot the other one's name that will help with validation.

### Handling/Throwing Errors
As a beloved friend of mine said:
> 'Cause the software brings errors, and the errors bring back, the errors bring back handling.

Make sure you check all the pre-requisites of a certain endpoint. Throw errors if necessary.

#### Approach to Throwing Errors
Duh. Throw them when necessary. Handle in controllers.

#### Error response Structure
```
// During development
{
  "status": 404,
  "name": "NotFoundException",
  "message": "Cannot GET /",
  "method": "GET",
  "path": "/",
  "timestamp": "2023-02-28T10:57:34.281Z"
}

// During production
{
  "status": 404,
  "message": "Cannot GET /",
}
```

## Filesystem
`/src/help-zones` folder is reserved for the current phase of the project (that is the phase that aims to organize the help centers). All the necessary modules should be created inside it.

### File naming convention
Filenames are separated by dashes, and they end with a dot continued by the type of the file. For example a controller file named help-center should be named as **"help-center.controller.ts"** Further examples can be found in `src/help-zones/help-centers`

The schemes for the database are located in the `schema.prisma` file in the `/prisma` folder.

If you don't think dashes are readable, go back to Java and those class names consisting of 15 meaningless buzzwords.

### Folder naming convention
Use dashes to separate words. Be consistent. Make sure the name is understandable.

## Tools available
Ooh boo boo, yes Nest have many useful tools. Unlike freaking Spring which doesn't even have a proper documentation so you work for hours and hours to handle freaking files.
### Prisma Studio
You can use Prisma Studio to see the contents of the database in a user-friendly interface.

```
    npx prisma studio
```

### Swagger API Documentation
Swagger API documentation can be reached by adding `/api` to the end of the API url. For example if the URL of the API is http://localhost:3000/, the documentation is located at http://localhost:3000/api

### Nest CLI
Nest CLI is a powerful tool that lets you use the features of Nest in a fast manner. One example of the usage of Nest CLI is [creating resources, services, CRUD endpoints](#resource-generation).