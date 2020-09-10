# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: common.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 10SEP2020
# REVISED: 10SEP2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #


# ============================================================================ #
# PHONY TARGETS
# ============================================================================ #

# -- Prerequisites for "clean" Target -- #

.PHONY: clean-common

## clean-common: Completes all common cleanup activities.
clean-common: clean-common-boilerplate

## clean-docs-github: Completes all boilerplate cleanup activities.
clean-common-boilerplate: | $(LOG)
	@printf "Removing boilerplate files..."
	@rm -rf .boilerplate >$(LOG) 2>&1; \
	$(status_result)
