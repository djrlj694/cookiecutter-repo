# Copyright © 2019 djrlj694.dev. All rights reserved.
#==============================================================================#
# PROGRAM: CocoaPods
# AUTHORS: Robert L. Jones
# COMPANY: djrlj694.dev
# VERSION: 1.1.0
# CREATED: 04FEB2019
# REVISED: 25MAY2019
#==============================================================================#
# For more info on terminology, style conventions, or source references, see
# the file ".make/README.md".
#==============================================================================#

#==============================================================================#
# INTERNAL CONSTANTS
#==============================================================================#

#------------------------------------------------------------------------------#
# Files
#------------------------------------------------------------------------------#

COCOAPODS_FILES := Framework.podspec

#==============================================================================#
# PHONY TARGETS
#==============================================================================#

#------------------------------------------------------------------------------#
# Prerequisite phony targets for the "clean" target
#------------------------------------------------------------------------------#

.PHONY: clean-cocoapods

## Completes all CocoaPods cleanup activities.
clean-cocoapods: | $(LOG)
	@printf "Removing CocoaPods setup..."
	@rm -rf $(COCOAPODS_FILES) >$(LOG) 2>&1; \
	$(status_result)

#------------------------------------------------------------------------------#
# Prerequisite phony targets for the "init" target
#------------------------------------------------------------------------------#

.PHONY: init-cocoapods 

## init-cocoapods: Completes all initial CocoaPods setup activities.
init-cocoapods: $(COCOAPODS_FILES)

#==============================================================================#
# FILE TARGETS
#==============================================================================#

# Makes a Framework.podspec file.
Framework.podspec: Framework.podspec.download

#==============================================================================#
# INTERMEDIATE TARGETS
#==============================================================================#

.INTERMEDIATE: Framework.podspec.download
