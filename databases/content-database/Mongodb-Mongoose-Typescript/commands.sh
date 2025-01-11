# !/bin/bash

mkdir -p {config,models,controllers,services,migrations,tests}
touch config/database.ts
touch models/contentModel.ts
touch controllers/contentController.ts
touch services/contentService.ts
touch migrations/migration1.ts
touch tests/contentController.test.ts