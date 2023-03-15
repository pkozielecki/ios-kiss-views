# KISS SwiftUI Views showcase

Welcome to the demonstration of **simple, universal** and **generic** SwiftUI **views**.

|![](External%20Resources/smart-views.gif)|![](External%20Resources/smart-popups.gif)|![](External%20Resources/simple-views.gif)|![](External%20Resources/simple-popups.gif)|
|-----|-----|-----|-----|

## Main Features
* Pure SwiftUI
* Navigation based on Router and NavigationStack
* A badly-written, multipurpose view added for comparison (`BadErrorView`)
* Sample Unit Tests coverage

## Integration

### Requirements
* iOS 16.0

### Running the app

* Clone the repo.
* Open `KISS Views.xcodeproj` file.
* Run `KISS Views` scheme.

## App content

### Universal views

The app showcases a universal, reusable and generic `ErrorView` to visualise various app errors:
* No network connection
* Backend unresponsive 
* Outdated application
* Security issues detected

Each of the cases above has a dedicated View Model responsible for providing view configuration and handling user feedback (e.g. tapping a button): `NoNetworkErrorViewModel`, `AppUpdateRequiredErrorViewModel`, etc.

### Badly written, _"smart"_ view (for reference)

The app contains also badly written, _"smart"_ `BadErrorView` (with bound `BadErrorViewModel`).\
The view also visualises different app error, but the way is implemented is complicated and not sustainable throughout the life of the project.\
**The purpose of this code is to visualise how quickly a rather simple view can grow (in size and complexity) when new responsibilities are added to it.**\
Please refer to the commit history between `fde934ed002e6a23844c27f9a77ddf61d27acf00` and `5dafddd3763c2dba7208761d1c71d96cf1130cb7`.

### Navigation

Each of the showcased **app errors** can be displayed as:
* a view in a **navigation stack**
* a popup in a **sheet**

To do that, and also allow views to pop / dismiss themselves from code, the app provides `NavigationRouter`.\
The router is bound with the `HomeView` navigation stack.

## Project maintainer

- [Pawel Kozielecki](https://github.com/pkozielecki)

See also the list of [contributors](https://github.com/netguru/ng-ios-network-module/contributors) who participated in this project.

## License

This project is licensed under the MIT License.
[More info](LICENSE.md)
