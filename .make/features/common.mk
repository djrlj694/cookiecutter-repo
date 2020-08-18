# Copyright © 2019 djrlj694.dev. All rights reserved.
#==============================================================================#
# PROGRAM: common.mk
# AUTHORS: Robert L. Jones
# COMPANY: djrlj694.dev
# VERSION: 1.0.0
# CREATED: 03MAR2019
# REVISED: 25MAY2019
#==============================================================================#
# For info on terminology or style conventions, see ".make/README.md".
#==============================================================================#

#==============================================================================#
# INTERNAL CONSTANTS
#==============================================================================#

# -- Files -- #

COMMON_DOCS := README REFERENCES

COMMON_FILES := $(addsuffix .md,$(COMMON_DOCS))
COMMON_DOWNLOADED_FILES := $(addsuffix .download,$(COMMON_FILES))

#==============================================================================#
# PHONY TARGETS
#==============================================================================#

# -- Prerequisite phony targets for the "clean" target -- #

.PHONY: clean-common clean-docs-common

## clean-common: Completes all Xcode cleanup activities.
clean-common: clean-docs-common

## clean-docs-common: Completes all common document cleanup activities.
clean-docs-common: | $(LOG)
	@printf "Removing common documents..."
	@rm -rf $(COMMON_FILES) 2>&1; \
	$(status_result)

# -- Prerequisite phony targets for the "docs" target -- #

.PHONY: docs-common 

## docs-common: Completes all common document generation activites.
docs-common: $(COMMON_FILES)

# -- Prerequisite phony targets for the "init" target -- #

.PHONY: init-common

## init-common: Completes all initial common setup activites.
ifeq ($(COOKIECUTTER),)
init-common: docs-common
endif

#==============================================================================#
# FILE TARGETS
#==============================================================================#

## README.md: Makes a README.md file.
README.md: README.sed README.md.download
	$(update-file)

# Makes a sed script for file README.sed.
README.sed:
	$(eval kv_list = $(PROJECT_KV) $(EMAIL_KV) $(GITHUB_USER_KV) $(TRAVIS_USER_KV))
	$(call add-sed-cmds,cc-sed-cmd,$(kv_list))

## REFERENCES.md: Makes a REFERENCES.md file.
REFERENCES.md: REFERENCES.md.download

#==============================================================================#
# INTERMEDIATE TARGETS
#==============================================================================#

.INTERMEDIATE: $(COMMON_DOWNLOADED_FILES) README.sed
