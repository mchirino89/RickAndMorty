# RickAndMorty
PoC for entire programatic UIKit app + SPM

![RickAndMorty](https://user-images.githubusercontent.com/1657723/109507856-ee278480-7a7d-11eb-9f55-ac27703b29ce.jpg)

It's a simple list + detail app for random characters from the Rick and Morty series

| Navigation | Dark mode support |
| --- | --- |
|  <img src="https://github.com/mchirino89/RickAndMorty/blob/main/Preview/2023-01-10%205.33.15%20PM.gif" width="300"/>  |  <img src="https://github.com/mchirino89/RickAndMorty/blob/main/Preview/2023-01-10%205.33.21%20PM.gif" width="300"/>  |

# Technologies

SPM dependencies used are my own 

* [MauriUtils](https://github.com/GeekingwithMauri/MauriUtils)
* [MauriNet](https://github.com/GeekingwithMauri/MauriNet)
* [MauriKit](https://github.com/GeekingwithMauri/MauriKit)

This project was built and compile on [XCode 13.4](https://download.developer.apple.com/Developer_Tools/Xcode_13.4/Xcode_13.4.xip).

The test API used was [Rick and Morty](https://rickandmortyapi.com) public one. Complex handling of oauth was beyond the scope of this PoC so that one did the trick (mainly due to time constraints)

# Architecture organization

The inner project organization is based on Uncle's Bob [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) divided as follow:

![architecture](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

## 1. Entities

Since the app is so simple, the only entities concerned are the endpoints descriptions. These are sort of the "core business objects" given than they are the less likely to change (in fact, they haven't in 2 years)

![1](https://github.com/mchirino89/RickAndMorty/blob/main/DocResources/1_Entities.png)

## 2. Use cases

The only possible actions from the user (beyond scrolling vertically and horizontally where appropiate) are checking the random characters at the very beginning of a new app launch _AND_ checking the details for any selected character from the main list.

![2](https://github.com/mchirino89/RickAndMorty/blob/main/DocResources/2_UseCases.png)

## 3. Interface adapters

The UI design pattern for this app is MVVM. Some of the helpers associated with it live in the previously mentioned "external library" [MauriUtils](https://github.com/GeekingwithMauri/MauriUtils/tree/main/Sources/MauriUtils/MVVM). 

The rest lives inside this folder:

- (View)Controllers 
- UI code
- Data transfer objects ([DTOs](https://en.wikipedia.org/wiki/Data_transfer_object))

![3](https://github.com/mchirino89/RickAndMorty/blob/main/DocResources/3_Adapters.png)

## 4. Frameworks and drivers

All external connections and implementation details are located here. For this case we're talking about endpoint consumption, iOS app setup and an in-house cache framework developed to speed image showing whenever it was previously loaded.

![4](https://github.com/mchirino89/RickAndMorty/blob/main/DocResources/4_Drivers.png)

# Reasoning

- [SOLID](https://www.youtube.com/watch?v=TMuno5RZNeE&ab_channel=Peoplecareer) is at the heart of this development, always favoring composition over inherence (that's why you can see so many files for such a "small" project). It was _lego oriented_ design 😁
- Use of UIStackViews wherever possible to laverage its flexibility and layout power.
- Break down every delegate/data source across the project in order to avoid fat classes. [`MainListViewController`](https://github.com/mchirino89/RickAndMorty/blob/main/R&M/R&M/InterfaceAdapters/Components/List/MainListViewController.swift) is the _commander_ (sort of speak) of it all.
- Cache handling to improve UX and diminish bandwidth footprint 
- [`ItemDataSource`](https://github.com/mchirino89/RickAndMorty/blob/main/R&M/R&M/Drivers/CacheFramework/ItemDataSource.swift) is where the magic happens: Cache and MVVM is shared between components here and communication never touches view model or view controller.
- Dark mode support
- Github action integration: [CI setup](https://github.com/mchirino89/RickAndMorty/blob/main/.github/workflows/swift.yml) for every PR and push made against the **main** branch

# Testing

Given the app simplicity, most tests are unit tests and refer to repository consumption (the flow of data is the expected one). The naming for all test doubles is based on [this great Martin Fowler post](https://martinfowler.com/articles/mocksArentStubs.html#TheDifferenceBetweenMocksAndStubs).

There are however a couple of integration tests that are worth mentioning:

- [NavigationTestCases](https://github.com/mchirino89/RickAndMorty/blob/main/R%26M/R%26MTests/TestCases/NavigationTestCases.swift): verifies the navigation is being properly invoked. Given that things are so losely couple (navigation occurs via a delegate that notifies the coordinator), the compiler itself offers no guarantee in this case. The connection could be lost/erased by accident and the app would keep compiling, therefore this safeguard was implemented.

- [SnapshotTestCases](https://github.com/mchirino89/RickAndMorty/blob/main/R%26M/R%26MTests/TestCases/SnapshotTestCases.swift): even though snapshot tests tend to be flaky across different OS versions and environemnts, when dealing with only code UI they have more pros than cons. This one in particular checks both listing and details rendering layout looks as expected (in both light and dark mode)

# Considerations 

There were tradeoffs in every major design decision behind the development. While it is true that SOLID principles are at the core of every choice made here, no peace of software is ever complete so there might be minor duplicated here and there for speeding sake. Some notes can be found across the project explaining the shortcomings of those implementations. 

# Things to improve

You might find odd for me to include this section since it looks like I'm sabotaging myself. The intention here is to acknowledge the things that, most likely due to lack of time, remain pending. Just to mention a few:

- Proper error handling for network requests
- Maybe give a second though on the responsibility of [`ItemDataSource`](https://github.com/mchirino89/RickAndMorty/blob/main/R&M/R&M/Drivers/CacheFramework/ItemDataSource.swift). For scalability reasons it might be broken down in smaller components with single responsibilities.
- Add infinite scrolling 
