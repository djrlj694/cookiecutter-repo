# README

[**`make`**](https://en.wikipedia.org/wiki/Make_(software)) is a command-line utility for maintaining groups of software files, typically source code files. Originally created in 1976 as a software build automation tool for Unix environments, it can be used more broadly "[to describe any task where files must be updated automatically from others whenever the others change](https://linux.die.net/man/1/make)". This automation is facilitated via so-called [**makefiles**](https://en.wikipedia.org/wiki/Makefile), script-like description files that [declaratively](https://en.wikipedia.org/wiki/Declarative_programming) specify via variable definitions and build rules:

1. A software project's file components;
2. The [dependency graph](https://en.wikipedia.org/wiki/Dependency_graph) of these components (i.e., their interrelationships);
3. The sequence of commands for creating or updating each component.

**Makefile projects**, integrated sets of makefiles, provide a blueprint for a software project's source code base and its maintenance. In addition, together with the `make` command, makefile projects serve as the scaffolding for build activities and more within a software project's development process.

The sections that follow summarize the [makefiles](#files), style [conventions](#conventions), and [terminology](#glossary) used in this makefile project.  For information about the `make` command or makefile syntax, please refer to the links in the [References](#references) section.

## Files

Software projects with large, source code files are problematic. At best, they can be intimidating to developers, particularly to those who are new to a development team.  At worse, they become difficult to maintain, debug, or reuse. Makefile projects are no different in these respects.

This makefile project is designed with modularity and maintainability in mind.  Following the [separation of concerns (SoC)](https://en.wikipedia.org/wiki/Separation_of_concerns) software design principle, it separates makefiles into 4 orthogonal areas of concern:

| Path | Concern | Intended Usage |
| ---- | ------- | ----------- |
| `$(PREFIX)/Makefile` | Customizations | Uniquely defining a software project |
| `$(PREFIX)/.make/features/*` | Features | Adding feature capabilities to a makefile project |
| `$(PREFIX)/.make/platforms/*` | Software platforms | Adding software platform/tool management capabilities for a software project |
| `$(PREFIX)/.make/utilities/*` | Utilities | Adding general-purpose variable definitions |

Makefiles stored under the appropriately named `.make` directory are makefile libraries, portable collections of variable definitions and target rules. They are distinguished from the top-level makefile, `Makefile`, in 2 respects:

1. They are intended for sharing and reusability across multiple makefile projects with no rework required;
2. They are isolated and hidden from the rest of a software project.

Makefile libraries may or may not be suffixed with `.mk`; the extension isn't a syntactic requirement for when the `make` command reads makefiles.  However, as a convention, extending makefile names with `.mk` is highly recommended and strongly encouraged.
 
The subsections that follow focus on 2 makefile library groups: [**feature libraries**](#feature-libraries) and [**platform libraries**](#platform-libraries).

### Feature Libraries

| File | Intended Usage |
| ---- | ----------- |
| [common.mk](features/common.mk) | Managing documentation to be included in any software project. |
| [debugging.mk](features/debugging.mk) | Debugging makefile projects. |
| [downloading.mk](features/downloading.mk) | Downloading files. |
| [formatting.mk](features/formatting.mk) | Formatting standard output (STDOUT). |
| [helping.mk](features/helping.mk) | Generating and displaying a makefile project's online help. |
| [initializing.mk](features/initializing.mk) | Setting up a software project. |

### Platform Libraries

| File | Intended Usage |
| ---- | ----------- |
| [Carthage.mk](platforms/Carthage.mk) | Managing [Carthage](https://github.com/Carthage/Carthage) dependencies in Xcode software projects. |
| [CocoaPods.mk](platforms/CocoaPods.mk) | Managing [CocoaPods](https://cocoapods.org) dependencies in Xcode software projects. |
| [Cookiecutter.mk](platforms/Cookiecutter.mk) | Transforming [Cookiecutter](https://github.com/audreyr/cookiecutter) templates into software projects. |
| [Git.mk](platforms/Git.mk) | Managing [Git](https://git-scm.com) repositories and version control in software projects. |
| [GitHub.mk](platforms/GitHub.mk) | Managing [GitHub](https://github.com) repositories. |
| [sed.mk](platforms/sed.mk) | Transforming text files using the [`sed`](https://www.gnu.org/software/sed/manual/sed.html) command. |
| [Swift.mk](platforms/Swift.mk) | Managing [Swift](https://swift.org) software projects. |
| [Xcode.mk](platforms/Xcode.mk) | Managing [Xcode](https://developer.apple.com/xcode/) software projects. |

## Conventions

This project distinguishes makefile variables into 5 categories, based on considerations such as how the variable is assigned or defined as well its intended usage (i.e., how values are set and where).  For each variable category, there is a convention for naming and defining a variable. For more information about these variable categories, please refer to the [glossary](GLOSSARY.md) of terms or click on a particular variable category in the table below.

| Variable Category | Naming Convention | Example | Definition Expansion |
| ----------------- | ----------------- | ------- | -------------------- |
| [External constant](#external-constants) | Uppercase, underscore-separated words | `USER ?= $(shell whoami)` | Deferred |
| [Internal constant](#internal-constants) | Uppercase, underscore-separated words | `MKDIR := mkdir -p` | Immediate |
| [Internal variable](#internal-variables) | Lowercase, underscore-separated words | `subdir = $(shell basename $(@D))` | Deferred |
| [Macro](#macros) | Lowercase, hyphenated words | `define usage_help`<br><br>`Usage:`<br>&nbsp;&nbsp;`make $(TARGET_ARG) $(MAKE_ARGS)`<br>`endef` | Deferred |
| [User-defined function](#user-defined-functions) | Lowercase, hyphenated words | `define result`<br>&nbsp;&nbsp;`([ $$? -eq 0 ] && printf "$1") \|\|`<br>&nbsp;&nbsp;`(printf "$(FAILED)\n" && cat $(LOG) && echo)`<br>`endef` | Deferred |

## Glossary

[References](#references) on makefile syntax describe 4 types of constructs:

1. **comment:** A line that starts with a hashtag character (`#`) and is entirely ignored.
2. **directive:** An instruction for the `make` command to do something special while reading the makefile.
3. **rule:** A name that specifies when and how to (re)make one or more files.
4. **variable:** A name for a text string value that can be substituted (i.e., "expanded") into the name later.

This section goes beyond these constructs and lists technical terminology used in this makefile project. Some of the terms are generally accepted as part of makefile parlance. Others are unique to this particular makefile project, in part to better facilitate common conventions for, say, naming and defining makefile variables.

### Variables

This project distinguishes makefile variables into the following 5 categories, based on considerations such as how the variable is assigned or defined as well its intended usage (i.e., how values are set and where).

#### External Constants

An **external constant** is a variable that is intended to:

1. Have a fixed value;
2. Be set at the command line or by the environment.

It's typically defined using the `?=` assignment operator to "conditionally" assign its right-hand side&mdash;i.e., to assign only if a value for the variable hasn't been externally set.

By convention, external constants use uppercase, underscore-separated words for names.

#### Internal Constants

An **internal constant** is a variable that is intended to:

1. Have a fixed value;
2. Be set within a makefile.

It's typically defined using the `:=` assignment operator to "simply" expand its right-hand side&mdash;i.e., immediately evaluate any variables therein, saving the resulting text as final the value.

By convention, internal constants uses uppercase, underscore-separated words for names.

#### Internal Variables

An **internal variable** is one that is intended to:

1. Have a value that depends on other variables, shell commands, etc. in its definition;
2. Be set within a makefile.

It's typically defined using the `=` assignment operator to "recursively" expand its right-hand side&mdash;i.e., defer evaluation until the variable is used.

By convention, internal variables use lowercase, underscore-separated words for names.

#### Macros

A **macro** is a variable that is defined using the "define" directive instead of an assignment operator. It's typically used to define a multi-line variable.

By convention, macros use lowercase, hyphenated words for names.

#### User-Defined Variables

A **user-defined function** is a variable or macro that includes one or more temporary variables (`$1`, `$2`, etc.) in its definition.

By convention, its user-defined functions use lowercase, hyphenated words for names.

### Targets

#### Phony Targets

A **phony target** is one that doesn't represent a file or directory. It can be thought of as an embedded shell script. It's run when an explicit request is made unless unless a file of the same name exists.

Two reasons to use a phony target are:

1. To avoid a conflict with a file of the same name;
2. To improve performance.

#### Intermediate Targets

An **intermediate target** corresponds to a file that is needed on the way from a source file to a target file.  It typically is a temporary file that is needed only once to generate the target after the source changed.  The `make` command automatically removes files that are identified as intermediate targets.  In other words, such files that didn't exist before a `make` run won't exist after a `make` run.

#### Second Expansion Targets

## References

1. https://www.cl.cam.ac.uk/teaching/0910/UnixTools/make.pdf
2. https://linux.die.net/man/1/make
3. https://www.gnu.org/software/make
4. https://www.gnu.org/software/make/manual/make.html
5. https://www.oreilly.com/library/view/managing-projects-with/0596006101
6. https://www.oreilly.com/openbook/make3/book
7. https://en.wikipedia.org/wiki/Make_(software)
8. https://en.wikipedia.org/wiki/Makefile
