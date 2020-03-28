//
//  ButtonItem.swift
//  SimpleAdapter_Example
//
//  Created by Mikhail Smetannikov on 28.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SimpleAdapter

protocol ButtonItemDelegate: AnyObject {

    func buttonItemDidTap(_ item: ButtonItem)
}

class ButtonItem: SATableViewItem {

    private(set) weak var delegate: ButtonItemDelegate?

    let title: String

    var visibleCell: ButtonCell? { // For fast access without cast
        return cell as? ButtonCell
    }

    var isEnabled: Bool = true {
        willSet {
            visibleCell?.set(isEnabled: newValue)
        }
    }

    init(identifier: ItemIdentifier, title: String, delegate: ButtonItemDelegate) {
        self.title = title
        self.delegate = delegate
        super.init(
            cellIdentifier: ButtonCell.cellIdentifier,
            itemIdentifier: identifier.rawValue)
    }
}
