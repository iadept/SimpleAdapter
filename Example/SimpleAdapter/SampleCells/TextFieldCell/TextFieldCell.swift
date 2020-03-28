//
//  TextFieldCell.swift
//  SimpleAdapter_Example
//
//  Created by Mikhail Smetannikov on 28.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SimpleAdapter

class TextFieldCell: SATableViewCell {

    static let cellIdentifier = "textField"

    @IBOutlet private weak var textField: UITextField?

    override func fill() {
        guard let item = item as? TextFieldItem else { return }
        textField?.placeholder = item.placeholder
    }
}

extension TextFieldCell: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let item = item as? TextFieldItem else { return }
        item.value = textField.text ?? ""
    }
}
