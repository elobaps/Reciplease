# Reciplease

Supports: IOS 11 and above

> using of core data for data persistence for recipes's favorites of user

## Introduction:

Reciplease is is an app of recipes, breaks down into several features :

* a search field that allows you to specify a list of ingredients
* a tableview displaying the recipes's list corresponding to the ingredients entered above
* the display of the recipe detail with a button to access all of instructions
* the star button which allows the user to save a recipe in his list of favorites

## API:

This app uses the following API :

* Edamam

## Getting started:

To test this application, you need to use API key for Edamam.

In supporting files's folder, you need to create a file ApiConfig.swift.
It should contain the following informations :

```
struct ApiConfig {
  static let edamamApiKey = "yourApiKey"
  static let edamamId = "yourApiId"
}
```

## Dependencies:

* SwiftLint - A tool to enforce Swift style and conventions. [SwiftLint documentation.](https://github.com/realm/SwiftLint "SwiftLint documentation.")
* Alamofire is an HTTP networking library written in Swift. [Alamofire documentation.](https://github.com/Alamofire/Alamofire "Alamofire documentation.")

## Screenshot
