# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Markdown.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 03MAR2019
# REVISED: 28AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

# -- Filesystem -- #

COMMON_DOCS := CHANGELOG CODE_OF_CONDUCT CONTRIBUTING README REFERENCES SUPPORT

COMMON_FILES := $(addsuffix .md,$(COMMON_DOCS))
COMMON_DOWNLOADED_FILES := $(addsuffix .download,$(COMMON_FILES))


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Prerequisites for "clean" Target -- #

.PHONY: clean-common clean-docs-common

## clean-common: Completes all Xcode cleanup activities.
clean-common: clean-docs-common

## clean-docs-common: Completes all common document cleanup activities.
clean-docs-common: | $(LOG)
	@printf "Removing common documents..."
	@rm -rf $(COMMON_FILES) 2>&1; \
	$(status_result)

# -- Prerequisite for "docs" Target -- #

.PHONY: docs-common 

## docs-common: Completes all common document generation activites.
docs-common: $(COMMON_FILES)

# -- Prerequisite for "init" Target -- #

.PHONY: init-common


# ============================================================================ #
# FILE TARGETS
# ============================================================================ #

# Makes a CHANGELOG.md file.
CHANGELOG.md: CHANGELOG.md.download

# Makes a CODE_OF_CONDUCT.md file.
CODE_OF_CONDUCT.md: CODE_OF_CONDUCT.sed CODE_OF_CONDUCT.md.download
	$(update-file)

# Makes a sed script for file CODE_OF_CONDUCT.sed.
CODE_OF_CONDUCT.sed:
	$(eval kv_list = $(PROJECT_KV) $(EMAIL_KV) $(GITHUB_USER_KV))
	$(call add-sed-cmds,cc-sed-cmd,$(kv_list))

# Makes a CONTRIBUTING.md file.
CONTRIBUTING.md: CONTRIBUTING.sed CONTRIBUTING.md.download
	$(update-file)

# Makes a sed script for file CONTRIBUTING.sed.
CONTRIBUTING.sed:
	$(eval kv_list = $(PROJECT_KV) $(EMAIL_KV) $(GITHUB_USER_KV))
	$(call add-sed-cmds,cc-sed-cmd,$(kv_list))

## README.md: Makes a README.md file.
README.md: README.sed README.md.download
	$(update-file)

# Makes a sed script for file README.sed.
README.sed:
	$(eval kv_list = $(PROJECT_KV) $(EMAIL_KV) $(GITHUB_USER_KV) $(TRAVIS_USER_KV))
	$(call add-sed-cmds,cc-sed-cmd,$(kv_list))

## REFERENCES.md: Makes a REFERENCES.md file.
REFERENCES.md: REFERENCES.md.download

# Makes a SUPPORT.md file.
SUPPORT.md: SUPPORT.md.download


# ============================================================================ #
# INTERMEDIATE TARGETS
# ============================================================================ #

.INTERMEDIATE: $(COMMON_DOWNLOADED_FILES) CODE_OF_CONDUCT.sed CONTRIBUTING.sed README.sed
