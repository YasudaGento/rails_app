sudo rm -rf rails_app/public/packs
sudo rm -rf rails_app/public/packs-test
sudo rm -rf rails_app/tmp/pids/server.pid
sudo rm -rf rails_app/log/test.log
sudo touch rails_app/log/test.log
docker system prune