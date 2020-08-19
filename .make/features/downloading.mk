# Copyright © 2020 djrlj694.dev. All rights reserved.
# ============================================================================ #
# PROGRAM: downloading.mk
# AUTHORS: Robert (Bob) L. Jones
# VERSION: 0.0.0
# CREATED: 10MAR2019
# REVISED: 19AUG2020
# ============================================================================ #
# For info on terminology or style conventions, see ".make/README.md".
# ============================================================================ #

# ============================================================================ #
# USER-DEFINED FUNCTIONS
# ============================================================================ #

# $(call download-file,file,base-url)
# Downloads a file.
define download-file
	curl --silent --show-error --location --fail $2/$1 --time-cond $1
endef

# ============================================================================ #
# FILE TARGETS
# ============================================================================ #

# Downloads a file.
# https://stackoverflow.com/questions/32672222/how-to-download-a-file-only-if-more-recently-changed-in-makefile
%.download: | $(LOG) 
#	$(eval FILE = $(basename $@))
	@printf "Downloading file $(file_var)..."
#	@curl -s -S -L -f $(FILE_URL)/$(file) -z $(file) -o $@ >$(LOG) 2>&1; \

	@$(call download-file,$(file),$(FILE_URL)) -o $@ >$(LOG) 2>&1; \
	mv -n $@ $(file) >>$(LOG) 2>&1; \
	$(status_result)
