# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: GitHub.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 23FEB2019
# REVISED: 28AUG2020
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

# -- Filesystem -- #

GITHUB_DIR1 := .github/ISSUE_TEMPLATE
GITHUB_DIR2 := .github/PULL_REQUEST_TEMPLATE

GITHUB_DIRS := $(addsuffix /.,$(GITHUB_DIR1) $(GITHUB_DIR2))

GITHUB_DOCS1 := $(addprefix $(GITHUB_DIR1)/,bug_report custom feature_request ISSUE_TEMPLATE)
GITHUB_DOCS2 := $(addprefix $(GITHUB_DIR2)/,pull_request_template)
GITHUB_DOCS := $(GITHUB_DOCS1) $(GITHUB_DOCS2)

GITHUB_FILES := $(addsuffix .md,$(GITHUB_DOCS))
GITHUB_DOWNLOADED_FILES := $(addsuffix .download,$(GITHUB_FILES))

# -- Source Code Control (SCM) -- #

# GitHub
GH_REPO_PATH = $(GH_USER)/$(REPO_NAME)
GH_ORIGIN_URL = https://github.com/$(GH_REPO_PATH).git
GH_RAW_URL = https://raw.githubusercontent.com/$(GH_REPO_PATH)/master/%7B%7Bcookiecutter.project_name%7D%7D

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

# -- Prerequisite for "docs" Target -- #

.PHONY: docs-github 

## docs-github: Completes all GitHub document generation activites.
docs-github: $(GITHUB_FILES)

# -- Prerequisites for "init" Target -- #

.PHONY: init-github init-github-dirs

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
	-d '{$(name_kv),$(description_kv),$(private_kv)'}; \
	$(status_result)
endif

## init-github-dirs: Completes all initial Github directory setup activites.
init-github-dirs: $(GITHUB_DIRS)


# ============================================================================ #
# FILE TARGETS
# ============================================================================ #

# Makes a bug_report.md file.
$(GITHUB_DIR1)/bug_report.md: $(GITHUB_DIR1)/bug_report.md.download

# Makes a custom.md file.
$(GITHUB_DIR1)/custom.md: $(GITHUB_DIR1)/custom.md.download

# Makes a feature_request.md file.
$(GITHUB_DIR1)/feature_request.md: $(GITHUB_DIR1)/feature_request.md.download

# Makes a ISSUE_TEMPLATE.md file.
$(GITHUB_DIR1)/ISSUE_TEMPLATE.md: $(GITHUB_DIR1)/ISSUE_TEMPLATE.md.download

# Makes a pull_request_template.md file.
$(GITHUB_DIR2)/pull_request_template.md: $(GITHUB_DIR2)/pull_request_template.md.download


# ============================================================================ #
# INTERMEDIATE TARGETS
# ============================================================================ #

.INTERMEDIATE: $(GITHUB_DOWNLOADED_FILES)
