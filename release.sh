docker system prune -f
docker-compose -f docker-compose-production.yml build
docker exec -it rails_app bundle exec rails assets:precompile RAILS_ENV=production
docker exec -it rails_app gem update --system
docker exec -it rails_app bundle update --bundler
docker exec -it rails_app ./bin/webpack -p --progress
docker exec -it rails_app bundle exec rails db:migrate RAILS_ENV=production

docker-compose -f docker-compose-production.yml down
docker-compose -f docker-compose-production.yml up -d