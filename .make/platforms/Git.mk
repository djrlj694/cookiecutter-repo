# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Git.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 04FEB2019
# REVISED: 27AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# EXTERNAL CONSTANTS
# ============================================================================ #

# OSes, IDEs, or programming languagses
TOOLCHAIN ?= "dropbox,vim,visualstudiocode"


# ============================================================================ #
# USER-DEFINED FUNCTIONS
# ============================================================================ #

# $(call download-gitignore,toolchain)
# Downloads a .gitignore file.
define download-gitignore
	$(eval base_url = "https://www.toptal.com")
	$(eval path = "/developers/gitignore/api/")
	$(eval url = "$(base_url)$(path)$(TOOLCHAIN)")
	@$(call download-file,.gitignore,$(url))
endef


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Prerequisite for "clean" Target -- #

.PHONY: clean-git

## clean-git: Completes all git cleanup activities.
clean-git: | $(LOG)
	@printf "Removing git setup..."
	@rm -rf .git .gitignore >$(LOG) 2>&1; \
	$(status_result)

# -- Prerequisite for "init" Target -- #

.PHONY: init-git

## init-git: Completes all initial git setup activities.
init-git: .gitignore .git | $(LOG)
	@printf "Committing the initial project to the master branch..."
	@git checkout -b master >$(LOG) 2>&1; \
	git add . >>$(LOG) 2>&1; \
	git commit -m "Initial project setup" >>$(LOG) 2>&1; \
	$(status_result)
	@printf "Syncing the initial project with the origin..."
	@git remote add origin $(GH_ORIGIN_URL) >$(LOG) 2>&1; \
	git push -u origin master >$(LOG) 2>&1; \
	$(status_result)


# ============================================================================ #
# DIRECTORY TARGETS
# ============================================================================ #

## .git: Makes a git repository.
.git: | $(LOG)
	@printf "Initializing git repository..."
	@git init >$(LOG) 2>&1; \
	$(status_result)


# ============================================================================ #
# FILE TARGETS
# ============================================================================ #

## .gitignore: Makes a .gitignore file.
.gitignore: | $(LOG)
	@printf "Downloading file $@..."
	@$(call download-gitignore) >$(LOG) 2>&1; \
	$(status_result)

# Makes a special empty file for marking that a directory tree has been generated.
%/.gitkeep:
	@printf "Making directory tree for marker file $(target_var)..."
	@printf "Making marker file $(target_var) and its directory tree..."
	@MKDIR $(@D); \
	$(status_result)
	@printf "Making marker file $(target_var)..."
	@touch $@; \
	$(status_result)


# ============================================================================ #
# INTERMEDIATE TARGETS
# ============================================================================ #

.INTERMEDIATE: .gitignore.download


# ============================================================================ #
# SECOND EXPANSION TARGETS
# ============================================================================ #

.SECONDEXPANSION:
# Make a directory tree.
#$(PREFIX)/%.gitkeep: $$(@D)/.gitkeep | $$(@D)/.
