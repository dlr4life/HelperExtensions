//
//  ZeroPaddingTextView.swift
//  XtraCredit
//
//  Created by DLR on 5/26/20.
//  Copyright © 2020 DLR. All rights reserved.
//

import UIKit

@IBDesignable class ZeroPaddingTextView: UITextView {

    override func layoutSubviews() {
        super.layoutSubviews()
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
    
}
