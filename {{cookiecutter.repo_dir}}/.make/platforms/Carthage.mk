# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Carthage.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 04FEB2019
# REVISED: 22AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

# -- Filesystem -- #

CARTHAGE_FILES := Cartfile Cartfile.private


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Prerequisite for "clean" Target -- #

.PHONY: clean-carthage

clean-carthage: | $(LOG) ## Completes all Carthage cleanup activities.
	@printf "Removing Carthage setup..."
	@rm -rf $(CARTHAGE_FILES) >$(LOG) 2>&1; \
	$(status_result)

# -- Prerequisite for "init" Target -- #

.PHONY: init-carthage

## init-carthage: Completes all initial Carthage setup activities.
init-carthage: $(CARTHAGE_FILES)
	@if ! command -v carthage > /dev/null; then \
	echo 'Carthage is not installed.' \
	echo 'See https://github.com/Carthage/Carthage for install instructions.' \
	exit 1 \
	fi
	@carthage update --platform iOS --use-submodules --no-use-binaries


# ============================================================================ #
# FILE TARGETS
# ============================================================================ #

# Makes a Cartfile file for listing runtime Carthage dependencies.
Cartfile: | $(LOG)
	@printf "Making empty file $(target_var)..."
	@touch $@ >$(LOG) 2>&1; \
	$(status_result)

# Makes a Cartfile file for listing private Carthage dependencies.
Cartfile.private: | $(LOG)
	@printf "Making empty file $(target_var)..."
	@touch $@ >$(LOG) 2>&1; \
	$(status_result)

## Makes a setup file.
#carthage_setup: setup.download
