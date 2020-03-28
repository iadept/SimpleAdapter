//
//  TextCell.swift
//  TablePresenter
//
//  Created by Mikhail Smetannikov on 27.03.2020.
//  Copyright © 2020 Mikhail Smetannikov. All rights reserved.
//

import UIKit
import SimpleAdapter

class TextCell: SATableViewCell {

    static let cellIdentifier = "text"

    @IBOutlet weak var label: UILabel?

    var requiredItem: TextItem? {
        return item as? TextItem
    }

    override func fill() {
        label?.text = requiredItem?.text
    }
}
