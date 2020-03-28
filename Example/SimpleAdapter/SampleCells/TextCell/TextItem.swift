//
//  TextItem.swift
//  SimpleAdapter_Example
//
//  Created by Mikhail Smetannikov on 28.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SimpleAdapter

class TextItem: SATableViewItem {
    
    let text: String
    
    init(text: String) {
        self.text = text
        super.init(cellIdentifier: TextCell.cellIdentifier)
    }
}
