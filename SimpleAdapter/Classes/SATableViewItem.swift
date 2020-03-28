//
//  SATableViewItem.swift
//  TablePresenter
//
//  Created by Mikhail Smetannikov on 27.03.2020.
//  Copyright © 2020 Mikhail Smetannikov. All rights reserved.
//

import Foundation

open class SATableViewItem {

    public private(set) weak var cell: SATableViewCell?
    
    let cellIdentifier: String
    let itemIdentifier: String?
   
    public init(
        cellIdentifier: String,
        itemIdentifier: String? = nil
    ) {
        self.cellIdentifier = cellIdentifier
        self.itemIdentifier = itemIdentifier
    }
    
    func set(cell: SATableViewCell) {
        self.cell = cell
    }
}
