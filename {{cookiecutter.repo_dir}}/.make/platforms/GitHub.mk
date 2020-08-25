# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: GitHub.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 23FEB2019
# REVISED: 24AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# EXTERNAL CONSTANTS
# ============================================================================ #

# -- Accounts -- #

GITHUB_USER ?= $(USER)
TRAVIS_USER ?= $(USER)

# -- Source Code Control (SCM) -- #

# GitHub API v3
IS_PRIVATE ?= true


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

# -- Accounts -- #

EMAIL := $(USER)@gmail.com


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
	$(eval description_kv = "description":"This is a text")
	$(eval license_kv = "license_template":"$(LICENSE_TEMPLATE)")
	$(eval name_kv = "name":"$(PROJECT)")
	$(eval private_kv = "private":"$(IS_PRIVATE)")
	$(eval gh_api_url = https://api.github.com/user/repos)
	$(eval PROJECT_REPO = $(GITHUB_USER)/$(PROJECT))
	$(eval TEMPLATES_REPO = $(GITHUB_USER)/cookiecutter-github)
	$(eval ORIGIN_URL = https://github.com/$(PROJECT_REPO).git)
#	@cookiecutter gh:$(TEMPLATES_REPO) email=$(EMAIL) project_name=$(PROJECT)
#	@curl -H "Authorization: token $(GITHUB_API_TOKEN)" https://api.github.com/user/repos -d '{"name": "'"${NEW_REPO_NAME}"'"}'

	#@curl -u $(GITHUB_USER) $(gh_api_url) \
	#-d '{"name": "$(PROJECT)", "description": "This is a text", "private": $(IS_PRIVATE), "license_template": "$(LICENSE_TEMPLATE)"}'; \
	#$(status_result)

ifeq ($(LICENSE),)
	@curl -u $(GITHUB_USER) $(gh_api_url) \
	-d '{$(name_kv),$(description_kv),$(private_kv),$(license_kv)}'; \
	$(status_result)
else
	@curl -u $(GITHUB_USER) $(gh_api_url) \
	-d '{$(name_kv),$(description_kv),$(private_kv)'; \
	$(status_result)
endif
