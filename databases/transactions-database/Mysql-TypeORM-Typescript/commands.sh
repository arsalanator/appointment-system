# !/bin/bash

mkdir -p {config,entities,services,migrations,tests}
touch config/mysqlConfig.ts
touch entities/transactionEntity.ts
touch services/transactionService.ts
touch migrations/migration1.ts
touch tests/transactionService.test.ts