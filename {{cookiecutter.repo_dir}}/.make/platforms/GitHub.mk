# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: GitHub.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 23FEB2019
# REVISED: 25AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# EXTERNAL CONSTANTS
# ============================================================================ #

# -- Accounts -- #

GH_USER ?= $(USER)
TRAVIS_USER ?= $(USER)

# -- Source Code Control (SCM) -- #

# GitHub API v3
LICENSE_TEMPLATE ?=
PRIVATE ?= true


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

# -- Accounts -- #

EMAIL := $(USER)@gmail.com

# -- Source Code Control (SCM) -- #

# GitHub
GH_REPO_PATH = $(GH_USER)/$(REPO_NAME)
GH_ORIGIN_URL = https://github.com/$(GH_REPO_PATH).git

# GitHub API v3
GH_API_URL = https://api.github.com/user/repos


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Prerequisites for "clean" Target -- #

.PHONY: clean-github clean-docs-github

## clean-github: Completes all GitHub cleanup activities.
clean-github: clean-docs-github

## clean-docs-github: Completes all GitHub Markdown cleanup activities.
clean-docs-github: | $(LOG)
	@printf "Removing GitHub documents..."
	@rm -rf .github >$(LOG) 2>&1; \
	$(status_result)

# -- Prerequisite for "init" Target -- #

.PHONY: init-github

## init-github: Completes all initial Github setup activites.
init-github:
	@printf "Initializing GitHub repository..."
	$(eval description_kv = "description":"$(DESCRIPTION)")
	$(eval license_kv = "license_template":"$(LICENSE_TEMPLATE)")
	$(eval name_kv = "name":"$(REPO_NAME)")
	$(eval private_kv = "private":"$(PRIVATE)")
#	@curl -H "Authorization: token $(GITHUB_API_TOKEN)" $(GH_API_URL) -d '{"name": "${NEW_REPO_NAME}"}'

ifeq ($(LICENSE_TEMPLATE),)
	@curl -u $(GH_USER) $(GH_API_URL) \
	-d '{$(name_kv),$(description_kv),$(private_kv),$(license_kv)}'; \
	$(status_result)
else
	@curl -u $(GH_USER) $(GH_API_URL) \
	-d '{$(name_kv),$(description_kv),$(private_kv)'; \
	$(status_result)
endif
