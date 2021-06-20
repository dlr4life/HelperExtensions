//
//  Coordinator.swift
//  XtraCredit
//
//  Created by DLR on 5/12/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var children: [Coordinator] { get set }
    
    func start()
    
}
