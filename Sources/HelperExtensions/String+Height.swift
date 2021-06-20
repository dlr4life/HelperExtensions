//
//  String+Height.swift
//  XtraCredit
//
//  Created by DLR on 5/26/20.
//  Copyright © 2020 DLR. All rights reserved.
//

import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}
