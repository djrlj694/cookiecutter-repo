#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = '0.0.0'

__author__ = '{{cookiecutter.lead_name}}'
__credits__ = ['{{cookiecutter.lead_name}}']

__copyright__ = 'Copyright {% now 'local', '%Y' %}, {{cookiecutter.repo_name}}'
__license__ = '{{cookiecutter.repo_license}}'

__created_date__= '{% now 'local', '%b %d, %Y' %}'
__modified_date__= '{% now 'local', '%b %d, %Y' %}'

### Libraries ###

# 3rd-party

import os
import sys

from cookiecutter.main import cookiecutter

### Variable Declarations ###

### Function Declarations ###

### Main Program ###

sys.exit(0)
