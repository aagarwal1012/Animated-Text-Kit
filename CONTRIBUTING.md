Contributing to Animated-Text-Kit
==========================
:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:  
If you'd like to report a bug or join in the development
of Animated-Text-Kit, then here are some notes on how to do that.

Please **note** we have a [code of conduct](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/CODE_OF_CONDUCT.md), please follow it in all your interactions with the project.

## Contents
* [Reporting bugs and opening issues](#reporting-bugs-and-opening-issues)
* [Coding Guidelines](#coding-guidelines)
    * [Pull Requests](#pull-requests)
    * [MVP architecture](#mvp-architecture)
    * [Style Check](#style-check)
    * [Git Commit Messages](#git-commit-messages)
* [Security](#security)
  
## Reporting bugs and opening issues

If you'd like a report a bug or open an issue then please:

**Check if there is an existing issue.** If there is then please add
   any more information that you have, or give it a 👍.

When submitting an issue please describe the issue as clearly as possible, including how to
reproduce the bug, which situations it appears in, what you expected to happen, and what actually happens.
If you can include a screenshot for front end issues that is very helpful.

## Coding Guidelines

### Pull Requests
We love pull requests, so be bold with them! Don't be afraid of going ahead
and changing something, or adding a new feature. We're very happy to work with you
to get your changes merged into Animated-Text-Kit.

If you've got an idea for a change then please discuss it in the open first, 
either by opening an issue, or email me at [aagarwal9782@gmail.com](mailto:aagarwal9782@gmail.com).

If you're looking for something to work on, have a look at the open issues in the repository [here](https://github.com/aagarwal1012/Animated-Text-Kit/issues).

> We don't have a set format for Pull requests, but we expect you to list changes, bugs generated and other relevant things in PR message.

Refer this pull request [template](https://github.com/aagarwal1012/Animated-Text-Kit/blob/master/PULL_REQUEST_TEMPLATE.md).

### MVP architecture
Animated-Text-Kit is built keeping [MVP (model-view-presenter)](https://en.wikipedia.org/wiki/Model–view–presenter) architecture in mind, so any changes that are proposed to Animated-Text-Kit should follow MVP architecture.

### Style Check
Animated-Text-Kit uses `dartfmt`  for performing style checks on the codebase, which helps us in maintaining the quality of the code. Please check that the code is properly formatted according to `dartfmt` and also resolve all the issues, if any, shown by `dart analyze` before making a pull request. **Pull Requests will only be merged once all the violations are resolved**.

### Git Commit Messages
* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally
* When only changing documentation, include `[ci skip]` in the commit description
* Please start your commits with the following prefixes for better understanding among collaborators, based on the type of commit:
```
   feat: (addition of a new feature)
   rfac: (refactoring the code: optimization/ different logic of existing code - output doesn't change, just the way of execution changes)
   docs: (documenting the code, be it readme, or extra comments)
   bfix: (bug fixing)
   chor: (chore - beautifying code, indents, spaces, camelcasing, changing variable names to have an appropriate meaning)
   ptch: (patches - small changes in code, mainly UI, for example color of a button, incrasing size of tet, etc etc)
   conf: (configurational settings - changing directory structure, updating gitignore, add libraries, changing manifest etc)
```

