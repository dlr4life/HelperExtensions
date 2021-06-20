//
//  Storyboarded.swift
//  XtraCredit
//
//  Created by DLR on 5/12/21.
//

import UIKit

protocol Storyboarded {
    
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
