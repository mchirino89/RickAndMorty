# RickAndMorty
PoC for entire programatic UIKit app + SPM

![RickAndMorty](https://user-images.githubusercontent.com/1657723/109507856-ee278480-7a7d-11eb-9f55-ac27703b29ce.jpg)

It's a simple list + detail app for random characters from the Rick and Morty series

![navigation](https://github.com/mchirino89/RickAndMorty/blob/main/Preview/2023-01-10%205.33.15%20PM.gif)

It also includes dark mode support

![darkMode](https://github.com/mchirino89/RickAndMorty/blob/main/Preview/2023-01-10%205.33.21%20PM.gif)

# Technologies

SPM dependencies used are my own 

* [MauriUtils](https://github.com/GeekingwithMauri/MauriUtils)
* [MauriNet](https://github.com/GeekingwithMauri/MauriNet)
* [MauriKit](https://github.com/GeekingwithMauri/MauriKit)

This project was built and compile on [XCode 13.4](https://download.developer.apple.com/Developer_Tools/Xcode_13.4/Xcode_13.4.xip).

The test API used was [Rick and Morty](https://rickandmortyapi.com) public one. Complex handling of oauth was beyond the scope of this PoC so that one did the trick (mainly due to time constraints)

# Architecture organization

The inner project organization is based on Uncle's Bob [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

# Reasoning

- [SOLID](https://www.youtube.com/watch?v=TMuno5RZNeE&ab_channel=Peoplecareer) is at the heart of this development, always favoring composition over inherence (that's why you can see so many files for such a "small" project). It was _lego oriented_ design 😁
- Use of StackViews wherever possible to laverage its flexibility and layout power.
- Break down every delegate/data source across the project in order to avoid fat classes. `MainListViewController` is the _commander_ (sort of speak) of it all.
- Cache handling to improve UX and diminish bandwidth footprint 
- `CharacterDataSource` is where the magic happens: Cache and MVVM is shared between components here and communication never touches view model or view controller.
- Dark mode support
- Github action integration: CI setup on every PR and push made against the **main** branch

# Considerations 

There were tradeoffs in every major design decision behind the development. While it is true that SOLID principles are at the core of every choice made here, no peace of software is ever complete so there might be minor duplicated here and there for speeding sake. Some notes can be found across the project explaining the shortcomings of those implementations. 

# Things to improve
You might find odd for me to include this section since it looks like I'm sabotaging myself. The intention here is to acknowledge the things that, most likely due to lack of time, remain pending. Just to mention a few:

- Proper error handling for network requests
- Maybe give a second though on the responsibility of `CharacterDataSource`, for scalability reasons it might be broken down in smaller components with single responsibilities.
- Add infinite scrolling 
