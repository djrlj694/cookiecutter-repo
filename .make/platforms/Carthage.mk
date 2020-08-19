# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: Carthage.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 04FEB2019
# REVISED: 19AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #

# ============================================================================ #
# INTERNAL CONSTANTS
# ============================================================================ #

#------------------------------------------------------------------------------#
# Files
#------------------------------------------------------------------------------#

CARTHAGE_FILES := Cartfile Cartfile.private

# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

#------------------------------------------------------------------------------#
# Prerequisite phony targets for the "clean" target
#------------------------------------------------------------------------------#

.PHONY: clean-carthage

clean-carthage: | $(LOG) ## Completes all Carthage cleanup activities.
	@printf "Removing Carthage setup..."
	@rm -rf $(CARTHAGE_FILES) >$(LOG) 2>&1; \
	$(status_result)

#------------------------------------------------------------------------------#
# Prerequisite phony targets for the "init" target
#------------------------------------------------------------------------------#

.PHONY: init-carthage

## init-carthage: Completes all initial Carthage setup activities.
init-carthage: $(CARTHAGE_FILES)

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
carthage_setup: setup.download 
