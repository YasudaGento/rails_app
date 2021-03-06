all:
	@echo コマンド付きで使ってください
	@echo 詳細が知りたければ以下を入力
	@echo コマンド: make help
	@exit 0

create_db:
	sh shell/create.sh
	@exit 0

migration:
	sh shell/migration.sh
	@exit 0

destroy:
	sh shell/destroy_files.sh
	@exit 0

.PHONY: down
down:
	@docker-compose down

.PHONY: build
build:
	@docker-compose build

.PHONY: up
up:
	@docker-compose up

.PHONY: eslint
eslint:
	@docker exec rails_app npm run lint "app/javascript/**/*.{js,vue,ts}"

.PHONY: rubocop
rubocop:
	@docker exec rails_app bundle exec rubocop --lint --fail-level W --display-only-fail-level-offenses

.PHONY: jest
jest:
	@docker exec rails_app yarn test --colors --verbose

# 被らせないためのコマンド(.PHONYT)
.PHONYT: help
help:
	@echo コマンド: make migration
	@echo -e "説明: db環境の作成\n"
	@exit 0