.PHONY: help clean start web windows_dx windows_dx12 mac linux

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m

# Default target shows help
.DEFAULT_GOAL := help

help: ## Show this help message
	@echo "$(BLUE)Available targets:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}'

clean: ## Delete all built files
	@rm -rf dist

web: dist/web/game.js ## build for web (in dist/web)
	@cp src/index.html dist/web/

start: web ## start local server and watch for changes
	@trap 'kill $$(jobs -p) 2>/dev/null || true' INT TERM; \
	npx -y live-server dist/web & \
	npx -y onchange 'src/*.hx' -- make web & \
	wait

windows_dx: dist/game_dx.hl ## make windows DirectX release
	# TODO: bundle game

windows_dx12: dist/game_dx12.hl
	# TODO: bundle game

mac: dist/game_sdl.hl
	# TODO: bundle game

linux: dist/game_sdl.hl
	# TODO: bundle game

# internal build targets

dist/web/game.js: src/*.hx
	@haxe cfg/web.hxml

dist/game_sdl.hl: src/*.hx
	@haxe cfg/hashlink_sdl.hxml

dist/game_dx.hl: src/*.hx
	@haxe cfg/hashlink_dx.hxml

dist/game_dx12.hl: src/*.hx
	@haxe cfg/hashlink_dx12.hxml

