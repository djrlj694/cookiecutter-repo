#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'Robert (Bob) L. Jones'
__coauthor__ = 'N/A'
__copyright__ = 'Copyright 2019, Cookiecutter-Repo'
__credits__ = ['Robert (Bob) L. Jones']
__license__ = 'MIT'
__version__ = '0.0.1'
__maintainer__ = 'Robert (Bob) L. Jones'
__email__ = 'djrlj694@gmail.com'
__status__ = 'Development'
__created_date__= 'May 27, 2019'
__modified_date__= 'Jun 05, 2019'

### Libraries ###

# 3rd-party

import os
import sys

from cookiecutter.main import cookiecutter

### Variable Declarations ###

PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)

### Function Declarations ###

# Create a repo from a cookiecutter.
def add(cookiecutter_suffix, extra_context):
    cookiecutter(
        'gh:djrlj694/cookiecutter-%s' % cookiecutter_suffix,
        extra_context=extra_context,
        no_input=True,
        output_dir='..',
        overwrite_if_exists=True)   

### Main Program ###

extra_context = {'project_name': '{{ cookiecutter.repo_name }}'}

if {{ cookiecutter.add_github }}:
    add('github', extra_context)

if {{ cookiecutter.add_make }}:
    add('makefile', extra_context)

platform = '{{ cookiecutter.repo_platform | lower}}'.split(' ')[0]
if '{{ cookiecutter.repo_platform }}' == 'swift':
    os.system('mkdir Hello; cd Hello; swift package init; cd ..')
    add(platform, extra_context)
elif '{{ cookiecutter.repo_platform }}' in ['ios', 'ipados', 'macos', 'tvos', 'watchos', 'xcode']:
    add('xcode', extra_context)
else:
    add(platform, extra_context)

sys.exit(0)
