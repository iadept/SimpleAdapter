# SimpleAdapter

[![CI Status](https://img.shields.io/travis/iadept/SimpleAdapter.svg?style=flat)](https://travis-ci.org/iadept/SimpleAdapter)
[![Version](https://img.shields.io/cocoapods/v/SimpleAdapter.svg?style=flat)](https://cocoapods.org/pods/SimpleAdapter)
[![License](https://img.shields.io/cocoapods/l/SimpleAdapter.svg?style=flat)](https://cocoapods.org/pods/SimpleAdapter)
[![Platform](https://img.shields.io/cocoapods/p/SimpleAdapter.svg?style=flat)](https://cocoapods.org/pods/SimpleAdapter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

```swift
import SimpleAdapter

// Create cell class and xib with TableViewCell with same name(don't forget set custom class)
class TextCell: SATableViewCell {
    static let cellIdentifier = "text" // reuseIdentifier store variant
  
    @IBOutlet weak var label: UILabel?
  
    override func fill() {
        guard let item = item as? TextItem else { return }
        label?.text = item?.text
    }
}

// Create item class
class TextItem: SATableViewItem {
    let text: String
    
    init(text: String) {
        self.text = text
        super.init(cellIdentifier: TextCell.cellIdentifier)
    }
}


class ViewController: UIViewController {
    private var adapter: SATableViewAdapter?

    func setupUI() {
        adapter = SATableViewAdapter(tableView: tableView)
        adapter?.register(cell: SampleCell.self, withIdentifier: SampleCell.cellIdentifier)
        
        adapter?.set(items: [TextItem(text: "Hello")])
    }
}
```
After you may insert/remove/update any item
```swift
self.adapter?.update([
    .insert(item: TextItem(text: "New item"), to: .top, animation: .top),
])
```
All variant use adapter in example project
## Installation

SimpleAdapter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleAdapter'
```

## Author

iadept, iadept@gmail.com

## License

SimpleAdapter is available under the MIT license. See the LICENSE file for more info.
