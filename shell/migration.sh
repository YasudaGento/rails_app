#!/bin/bash
docker exec rails_app bin/rails db:environment:set RAILS_ENV=development

# for development
docker exec rails_app rails db:migrate:reset

# for test
docker exec rails_app rails db:migrate:reset RAILS_ENV=test

# seed投入
docker exec rails_app rails db:seed