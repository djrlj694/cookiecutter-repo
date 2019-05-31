#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = 'Robert (Bob) L. Jones'
__coauthor__ = 'N/A'
__copyright__ = 'Copyright 2019, Cookiecutter-Project'
__credits__ = ['Robert (Bob) L. Jones']
__license__ = 'MIT'
__version__ = '0.0.1'
__maintainer__ = 'Robert (Bob) L. Jones'
__email__ = 'djrlj694@gmail.com'
__status__ = 'Development'
__created_date__= 'May 27, 2019'
__modified_date__= 'May 30, 2019'

### Libraries ###

# 3rd-party

import os
import sys

from cookiecutter.main import cookiecutter

### Variable Declarations ###

PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)

### Function Declarations ###

def add(cookiecutter_suffix, extra_context):
    cookiecutter(
        'gh:djrlj694/cookiecutter-%s' % cookiecutter_suffix,
        extra_context=extra_context,
        no_input=True,
        output_dir='..',
        overwrite_if_exists=True)   

### Main Program ###

extra_context = {'project_name': '{{ cookiecutter.project_name }}'}

if '{{ cookiecutter.license }}' != 'Not open source':
    add('github', extra_context)

if {{ cookiecutter.include_makefile }}:
    add('makefile', extra_context)

if '{{ cookiecutter.project_type }}' == 'iOS':
    add('xcode', extra_context)

# Create project from the cookiecutter-pypackage.git repo template.
#cookiecutter(
#    'gh:djrlj694/Cookiecutter-Xcode',
#    extra_context={'project_name': '{{ cookiecutter.project_name }}'},
#    output_dir='..',
#    overwrite_if_exists=True)

sys.exit(0)
