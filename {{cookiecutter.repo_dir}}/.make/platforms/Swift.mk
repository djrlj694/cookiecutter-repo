# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Swift.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 03MAR2019
# REVISED: 25AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# EXTERNAL CONSTANTS
# ============================================================================ #

# OSes, IDEs, or programming languages
PROJECT_TYPE ?= "lib"


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Prerequisite for "docs" Target -- #

.PHONY: docs-swift

## docs-swift: Generates Swift API documentation.
docs-swift: | $(LOG)
	@printf "Generating API documentation..."
	@jazzy \
		--min-acl internal \
		--no-hide-documentation-coverage \
		--theme fullwidth \
		--output ./docs \
        --documentation=./*.md \
		>$(LOG) 2>&1; \
	$(status_result)
	@rm -rf ./build

# -- Prerequisite for "init" Target -- #

.PHONY: init-swift

## init-swift: Completes all initial Swift setup activites.
init-swift:
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/cookiecutter-swift)
	$(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)
	@swift package init --type $(SWIFT_PACKAGE_TYPE)
	@swift package generate-xcodeproj
	@echo PROJECT=$(PROJECT) PROJECT_TYPE=$(PROJECT_TYPE) SWIFT_PACKAGE_TYPE=$(SWIFT_PACKAGE_TYPE)
	@cookiecutter -f -o '..' --no-input gh:$(TEMPLATES_REPO) project_name='$(PROJECT)' project_type='$(PROJECT_TYPE)'
