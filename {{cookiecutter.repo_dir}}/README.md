# {{cookiecutter.repo_name}}

[![Build Status](https://travis-ci.org/{{cookiecutter.travis_user}}/TravisCIBlog.svg?branch=master)](https://travis-ci.org/{{cookiecutter.travis_user}}/{{cookiecutter.repo_name}})

## Usage

{{cookiecutter.repo_usage}}

## Options

{{cookiecutter.repo_options}}

## System Requirements

{{cookiecutter.repo_requirements}}

## Installation

{{cookiecutter.repo_installation}}

## Documentation

Documentation for the project can be found [here](https://{{cookiecutter.github_user}}.github.io/{{cookiecutter.repo_name}}/).

## Known Issues

Currently, there are no known issues.{% if cookiecutter.add_github %}  If you discover any, please kindly submit a [pull request](CONTRIBUTING.md).{% endif %}

{% if cookiecutter.add_github %}
## Contributing

Code and codeless (documentation, donations, etc.) contributions are welcome. To contribute yours, see [CONTRIBUTING.md](CONTRIBUTING.md).
{% endif %}

{% if cookiecutter.repo_license != 'Not open source' %}
## License

{{cookiecutter.repo_name}} is released under the [{{cookiecutter.repo_license}}](LICENSE.md).
{% endif %}

## References

API documentation, tutorials, and other online references and made portions of this project possible.  See [REFERENCES.md](REFERENCES.md) for a list of some.
