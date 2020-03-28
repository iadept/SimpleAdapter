//
//  SATableViewCell.swift
//  TablePresenter
//
//  Created by Mikhail Smetannikov on 27.03.2020.
//  Copyright © 2020 Mikhail Smetannikov. All rights reserved.
//

import UIKit

open class SATableViewCell: UITableViewCell {

    public private(set) var item: SATableViewItem?

    func set(item: SATableViewItem) {
        self.item = item
        fill()
    }

    open func fill() {}
}
