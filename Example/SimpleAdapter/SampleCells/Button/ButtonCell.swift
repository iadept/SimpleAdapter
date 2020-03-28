//
//  ButtonCell.swift
//  TablePresenter
//
//  Created by Mikhail Smetannikov on 28.03.2020.
//  Copyright © 2020 Mikhail Smetannikov. All rights reserved.
//

import UIKit
import SimpleAdapter

class ButtonCell: SATableViewCell {

    static let cellIdentifier = "button"

    @IBOutlet private weak var button: UIButton?

    override func fill() {
        guard let item = item as? ButtonItem else { return }
        button?.setTitle(item.title, for: .normal)
        set(isEnabled: item.isEnabled)
    }

    func set(isEnabled: Bool) {
        button?.isEnabled = isEnabled
    }

    @IBAction private func didTap(_ sender: Any) {
        guard let item = item as? ButtonItem else { return }
        item.delegate?.buttonItemDidTap(item)
    }
}
