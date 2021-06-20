//
//  Alert.swift
//  XtraCredit
//
//  Created by DLR on 4/23/20.
//  Copyright © 2020 DLR. All rights reserved.
//

import UIKit

class Alert {
    class func showAlert(title: String, titleColor: UIColor, message: String, preferredStyle: UIAlertController.Style, titleAction: String, actionStyle: UIAlertAction.Style, vc: UIViewController) {
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SF-Pro", size: 16)!, NSAttributedString.Key.foregroundColor: titleColor])
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: titleAction, style: actionStyle, handler: nil))
        vc.present(alert, animated: true)
    }
}
