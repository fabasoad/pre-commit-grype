.PHONY: install

install:
	@./scripts/bpkg-install-packages.sh
	@echo "[pre-commit-grype] Operation completed successfully: install"
