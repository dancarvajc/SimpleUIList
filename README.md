# SimpleUIList

A simple UITableView implementation for SwiftUI.

## Description

SimpleUIList is a simple `UITableView` wrapper designed for usage in SwiftUI, specifically focused in chat applications. This was inspired by multiple issues found while implementing a chat list in SwiftUI, such as starting the list at the bottom during different iOS versions, performance problems and reversing list issues with `contextMenu`.

This package aims to resolve these problems reliably.

Support: **iOS 13+**

## Usage

To use SimpleUIList, import the module and pass the information you want to display along with the corresponding view.

```swift
import SwiftUI 
import SimpleUIList

let myData = [Model1(), Model1(), Model3()]

var body: some View {
    SimpleUIList(myData.reversed()) { item in
        Text("\(item.property)")
    }
    .startAtBottom(true)
    .reverseList(true)
}
```

- **startAtBottom**: This starts the list at the bottom of the UITableView.

- **reverseList**: This reverses the order of the elements in the UITableView. This feature is particularly beneficial for a chat application, where you'd want to maintain the scroll position when the keyboard appears (like Telegram, Whatsapp, etc.). This provides the only reliable method to include this feature in SwiftUI.

## Installation

SimpleUIList is available as a swift package. Add it to your project in Xcode using its GitHub repository url.

```
https://github.com/dancarvajc/SimpleUIList.git
```



## License

MIT License



Please feel free to contribute and open issues.