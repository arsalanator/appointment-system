# !/bin/bash

mkdir -p {cache-database/Redis-IOredis-Typescript,content-database/Mongodb-Mongoose-Typescript,transactions-database/Mysql-TypeORM-Typescript}/src/{config,models,interfaces,utils}
mkdir -p content-database/Mongodb-Mongoose-Typescript/src/{schemas,repositories}
mkdir -p cache-database/Redis-IOredis-Typescript/src/{services,policies}
mkdir -p transactions-database/Mysql-TypeORM-Typescript/src/{entities,migrations}

# Create necessary files
touch content-database/Mongodb-Mongoose-Typescript/src/config/mongoose.config.ts
touch content-database/Mongodb-Mongoose-Typescript/src/schemas/base.schema.ts
touch content-database/Mongodb-Mongoose-Typescript/src/interfaces/repository.interface.ts
touch content-database/Mongodb-Mongoose-Typescript/src/utils/connection.util.ts

touch cache-database/Redis-IOredis-Typescript/src/config/redis.config.ts
touch cache-database/Redis-IOredis-Typescript/src/services/cache.service.ts
touch cache-database/Redis-IOredis-Typescript/src/policies/cache.policy.ts
touch cache-database/Redis-IOredis-Typescript/src/interfaces/cache.interface.ts

touch transactions-database/Mysql-TypeORM-Typescript/src/config/typeorm.config.ts
touch transactions-database/Mysql-TypeORM-Typescript/src/entities/base.entity.ts
touch transactions-database/Mysql-TypeORM-Typescript/src/interfaces/repository.interface.ts
touch transactions-database/Mysql-TypeORM-Typescript/src/utils/connection.util.ts