//
//  CustomAlertViewDelegate.swift
//  XtraCredit
//
//  Created by DLR on 12/15/18.
//  Copyright © 2018 DLR. All rights reserved.
//

protocol CustomAlertViewDelegate: class {
    func okButtonTapped(selectedOption: String)
    func cancelButtonTapped()
}
