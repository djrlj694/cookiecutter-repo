# Copyright © 2019 djrlj694.dev. All rights reserved.
#==============================================================================#
# PROGRAM: Swift.mk
# AUTHORS: Robert L. Jones
# COMPANY: djrlj694.dev
# VERSION: 1.0.0
# CREATED: 03MAR2019
# REVISED: 25MAY2019
#==============================================================================#
# For more info on terminology, style conventions, or source references, see
# the file ".make/README.md".
#==============================================================================#

#==============================================================================#
# PHONY TARGETS
#==============================================================================#

#------------------------------------------------------------------------------#
# Prerequisite phony targets for the "docs" target
#------------------------------------------------------------------------------#

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
