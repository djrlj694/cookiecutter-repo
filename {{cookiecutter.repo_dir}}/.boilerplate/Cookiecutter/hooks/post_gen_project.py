#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = '0.0.0'

__author__ = '{{cookiecutter.lead_name}}'
__credits__ = ['{{cookiecutter.lead_name}}']

__copyright__ = 'Copyright {% now 'local', '%Y' %}, {{cookiecutter.project_name}}'
__license__ = '{{cookiecutter.repo_license}}'

__created_date__= '{% now 'local', '%b %d, %Y' %}'
__modified_date__= '{% now 'local', '%b %d, %Y' %}'


# ============================================================================ #
# LIBRARIES
# ============================================================================ #

# -- Python Standard Library -- #

import os
import sys

# -- 3rd-Party -- #

from cookiecutter.main import cookiecutter


# ============================================================================ #
# CONSTANTS
# ============================================================================ #

# -- Debugging -- #

DEBUG = False


# ============================================================================ #
# FUNCTIONS
# ============================================================================ #

# -- Main Program -- #

def main():
    """
    Run the main set of functions that define the program.
    """

    pass


# ============================================================================ #
# MAIN EXECUTION
# ============================================================================ #

# -- Debugging -- #

if DEBUG:
    cmd('echo PWD=$PWD')
    cmd('which python')
    cmd('python --version')
    cmd('conda list')
    cmd('pip list')

# -- Main Execution -- #

# If this module is in the main module, call the main() function.
if __name__ == "__main__":
    main()

# -- Housekeeping -- #

# Exit the program normally.
sys.exit(0)
