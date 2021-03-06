# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Swift.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 03MAR2019
# REVISED: 10SEP2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# EXTERNAL CONSTANTS
# ============================================================================ #

# OSes, IDEs, or programming languages
PROJECT_TYPE ?= "lib"


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

# -- Filesystem -- #

#SWIFT_FILES := $(wildcard **/*.swift)
SWIFT_FILES := Package.swift
SWIFT_FILES += Sources/main.swift
SWIFT_FILES += Sources/$(PACKAGE)/$(PACKAGE).swift
SWIFT_FILES += Tests/LinuxMain.swift
SWIFT_FILES += Tests/(PACKAGE)Tests/(PACKAGE)Tests.swift
SWIFT_FILES += Tests/(PACKAGE)Tests/XCTestManifests.swift

SWIFT_BODY_FILES := $(addsuffix .body,$(SWIFT_FILES))
SWIFT_BP_FILES := $(addprefix .boilerplate/Swift/package,$(SWIFT_FILES))


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

.PHONY: init-swift init-swift-files init-swift-package

## init-swift: Completes all initial Swift setup activites.
# init-swift: init-swift-vars init-swift-dirs init-carthage init-cocoapods
init-swift: init-swift-package init-swift-files

## init-swift-files: Adds headers to all Swift files.
#@find . -name '*.swift' -exec mv {} {}.body \;
init-swift-files:
	@echo "Initializing Swift files."
	@for file in $$(find . -type f -name '*.swift' ! -path './.boilerplate/*' ); do \
		mv $$file $$file.body; \
		mv .boilerplate/Swift/package/$$file $$file.header; \
		cat $$file.header $$file.body >$$file; \
		rm $$file.header $$file.body; \
	done

## init-swift-package: Initalizes Swift package.
init-swift-package:
	# @cookiecutter -f -o '..' gh:$(TEMPLATES_REPO) project_name=$(PROJECT)
	# $(eval TEMPLATES_REPO = $(GITHUB_USER)/cookiecutter-swift)
	# $(eval FILE_URL = https://raw.githubusercontent.com/$(TEMPLATES_REPO)/master/%7B%7Bcookiecutter.project_name%7D%7D)
	@swift package init --name $(PACKAGE) --type $(PROJECT_TYPE)
	@swift package generate-xcodeproj
	# @cookiecutter -f -o '..' --no-input gh:$(TEMPLATES_REPO) project_name='$(PROJECT)' project_type='$(PROJECT_TYPE)'


# ============================================================================ #
# FILE TARGETS
# ============================================================================ #

%.swift.body:
	@for file in $(find . -name "*.swift"); do \
		echo "Moving file ${file} to ${file}.body."; \
		mv ${file} ${file}.body; \
	done

$(SWIFT_BODY_FILES):
	mv $(basename $@) $@
