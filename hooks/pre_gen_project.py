#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = '0.0.0'

__author__ = 'Robert (Bob) L. Jones'
__copyright__ = 'Copyright 2019, Cookiecutter Repo'

__credits__ = ['Robert (Bob) L. Jones']
__license__ = 'MIT'

__created_date__= 'Aug 25, 2019'
__modified_date__= 'Aug 29, 2020'


# ============================================================================ #
# IMPORTS
# ============================================================================ #

# -- Python Standard Library -- #

import os
import re
import sys


# ============================================================================ #
# CONSTANTS
# ============================================================================ #

# -- Debugging -- #

DEBUG = False

# -- Input -- #

# Filesystem
REPO_DIR = '{{cookiecutter.repo_dir}}'

# GitHub API v3
REPO_NAME = '{{cookiecutter.repo_name}}'


# ============================================================================ #
# FUNCTIONS
# ============================================================================ #

# -- Quality Assurance -- #

def qa_repo_dir(dir, name):
    """
    Validate an entered repository directory name.
    """

    error_msg = (
        f'The basename of the entered repository directory "{dir}" '
        f'does not match the entered repository name "{name}".'
        )

    if test_repo_dir(dir, name):
        raise ValueError(error_msg)

def qa_repo_name(name):
    """
    Validate an entered GitHub repository name.
    """

    error_msg = (
        f'The entered repository name "{name}" '
        'contains an illegal character.'
        )

    if test_repo_name(name):
        raise ValueError(error_msg)

# -- Testing -- #

def test_repo_dir(dir, name):
    """
    Test an entered GitHub repository directory name.
    """

    subdir = os.path.basename(dir)

    return subdir != name

def test_repo_name(name):
    """
    Test an entered GitHub repository name.
    """

    regex = r'^[_a-zA-Z][\-_a-zA-Z0-9]+$'

    return not re.match(regex, name)

# -- Main Execution -- #

def main():
    """
    Run the main set of functions that define the program.
    """

    print('pre_gen_hook: Begin') if DEBUG else exit
    qa_repo_name(REPO_NAME)
    qa_repo_dir(REPO_DIR, REPO_NAME)
    print('pre_gen_hook: End') if DEBUG else exit


# ============================================================================ #
# MAIN EXECUTION
# ============================================================================ #

# -- Main Program -- #

# If this module is in the main module, call the main() function.
if __name__ == "__main__":
    main()

# -- Housekeeping -- #

# Exit the program normally.
sys.exit(0)
