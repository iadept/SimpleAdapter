//
//  TextFieldItem.swift
//  SimpleAdapter_Example
//
//  Created by Mikhail Smetannikov on 28.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SimpleAdapter

protocol TextFieldItemDelegate: AnyObject {
    func textFieldItem(_ item: TextFieldItem, didChangeValue value: String)
}

class TextFieldItem: SATableViewItem {

    private weak var delegate: TextFieldItemDelegate?

    let placeholder: String

    var value: String = "" {
        didSet {
            delegate?.textFieldItem(self, didChangeValue: value)
        }
    }

    init(placeholder: String,
         delegate: TextFieldItemDelegate) {
        self.placeholder = placeholder
        self.delegate = delegate
        super.init(cellIdentifier: TextFieldCell.cellIdentifier)
    }
}
