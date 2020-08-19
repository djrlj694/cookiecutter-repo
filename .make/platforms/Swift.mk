# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Swift.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 03MAR2019
# REVISED: 19AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #

# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

#------------------------------------------------------------------------------#
# Prerequisite phony targets for the "docs" target
#------------------------------------------------------------------------------#

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

#------------------------------------------------------------------------------#
# Prerequisite phony targets for the "init" target
#------------------------------------------------------------------------------#

.PHONY: init-swift init-swift-dirs init-swift-vars

## init-swift: Completes all initial Swift setup activites.
ifeq ($(COOKIECUTTER),)
init-swift: init-swift-vars init-swift-dirs init-carthage init-cocoapods
else
init-swift: init-swift-vars
	@cookiecutter -f -o '..' gh:$(TEMPLATES_REPO) project_name=$(PROJECT)
###	swift package init
endif

## init-swift-dirs: Completes all initial Swift directory setup activites.
init-swift-dirs: $(XCODE_DIRS)

## init-swift-vars: Completes all Swift variable setup activites.
init-swift-vars:
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/cookiecutter-swift)
	$(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)
