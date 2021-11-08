# CombineValidate
![License](https://img.shields.io/badge/License-MIT-blue)
![Swift versions](https://img.shields.io/badge/Swift%20versions-5.3%20%7C%205.4%20%7C%205.5-red.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS-red.svg)
[![codecov](https://codecov.io/gh/pridees/combine-validate/branch/main/graph/badge.svg?token=VUX36CJOXE)](https://codecov.io/gh/pridees/combine-validate)
[![Test And Coverage](https://github.com/pridees/combine-validate/actions/workflows/test_and_codecov.yml/badge.svg?branch=main)](https://github.com/pridees/combine-validate/actions/workflows/test_and_codecov.yml)

* [What is CombineValidate?](#what-is-combine-validate)
* [Examples](#examples)
* [Basic usage](#basic-usage)
* [CombineValidateExtended library](#combine-validate-extended-library)
* [Requirements](#requirements)
* [Installation](#installation)
* [Documentation](#documentation)

 
## What is CombineValidate?

Useful satellite for validation user inputs proposes for any SwiftUI architectures. (MVVM as basic reference)
#### Batteries:
- **SwiftUI** native
- **Combine** under the hood
- Fully **customizable**
- Validate simple fields for non empty values
- Validate fields by predefined or your own **regular expressions**
- Try input by **multiple regex expressions** and emerge up the result what is the regex got fired
- Pass your **own error messages**
- Localize error messages with **custom localization table names**
- Use the **wide validation extension library**
- **Extend** the set of validation possibilities as you want
 
## Examples


## Basic usage
Firstly you should define the validation publisher within your `@Published` property

```swift
class FormViewModel: ObservableObject {
    
    @Published var email = ""
    public lazy var emailValidator: ValidationPublisher = {
        $email.validateWithRegex(
            regex: RegularPattern.email,
            error: "Not email",
            tableName: nil
        )
    }()
}
```
Excellent! And then, call the validate view modifier from your SwiftUI Input

```swift
TextField("Should email", text: $viewModel.email)
        .validate(for: viewModel.emailValidator)
```

Enjoy!

Same steps you can apply to `SecureField` and `Toggle`.

## CombineValidateExtended library
Useful set of validation publishers and regular expressions library.
Validation for
- any kind of credit card numbers
- urls
- hash tags
- numbers
- passwords
- much more

## Requirements
The CombineValidate dependes on the Combine reactive framework. 
**Minimal requirements:**
- iOS 13
- MacOS Catalina

## Installation
Package installation occurs via SPM. 
Add package in your Xcode as dependency
- Find in **File** menu "**Add packages**"
- Use the repo link [https://github.com/pridees/combine-validate](https://github.com/pridees/combine-validate) and follow for installation steps
- Add the CombineValidate dependency to your project targets

## Documentation
Look at [here]() and explore documentation.
