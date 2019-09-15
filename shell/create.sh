#!/bin/bash
docker exec rails_app bin/rails db:create RAILS_ENV=development
docker exec rails_app bin/rails db:create RAILS_ENV=test