//
//  Extensions.swift
//  SimpleAdapter
//
//  Created by Mikhail Smetannikov on 28.03.2020.
//  Copyright © 2020 Mikhail Smetannikov. All rights reserved.
//

import Foundation

extension Array where Element == SATableViewItem {
    var lastIndex: Int {
        if endIndex > 0 {
            return endIndex - 1
        }
        return 0
    }
    
    subscript(indexPath: IndexPath) -> SATableViewItem {
        return self[indexPath.row]
    }
}
