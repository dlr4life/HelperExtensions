//
//  NavigationBarExtension.swift
//  XtraCredit
//
//  Created by DLR on 1/31/21.
//  Copyright © 2021 DLR. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
extension UINavigationBar {
    
    func airlineNavigationBar() {
        tintColor = UIColor.black
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        layer.masksToBounds = false
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.7
//        barTintColor = UIColor(red: 1.00, green: 0.53, blue: 0.25, alpha: 1.00)
//        backgroundColor = UIColor(red: 1.00, green: 0.53, blue: 0.25, alpha: 1.00)
//        setBackgroundImage(nil, for: .default)
//        shadowImage = nil
        prefersLargeTitles = true
    }
    
    func credidCardNavigationBar() {
        tintColor = UIColor.black
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        layer.masksToBounds = false
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.7
        barTintColor = .green
        backgroundColor = .green
//        setBackgroundImage(nil, for: .default)
//        shadowImage = nil
        prefersLargeTitles = true
    }
    
    func hotelNavigationBar() {
        tintColor = UIColor.white
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        layer.masksToBounds = false
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.7
        barTintColor = .blue
//        setBackgroundImage(nil, for: .default)
//        shadowImage = nil
        prefersLargeTitles = true
    }
    
    func loansNavigationBar() {
        tintColor = UIColor.black
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        layer.masksToBounds = false
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.7
        barTintColor = .yellow
//        setBackgroundImage(nil, for: .default)
//        shadowImage = nil
        prefersLargeTitles = true
    }
    
    func otherNavigationBar() {
        tintColor = UIColor.black
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        layer.masksToBounds = false
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.7
        barTintColor = .cyan
//        setBackgroundImage(nil, for: .default)
//        shadowImage = nil
        prefersLargeTitles = true
    }
    
    func retailNavigationBar() {
        tintColor = UIColor.white
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        layer.masksToBounds = false
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.7
        barTintColor = .purple
//        setBackgroundImage(nil, for: .default)
//        shadowImage = nil
        prefersLargeTitles = true
    }
    
    func utilitiesNavigationBar() {
        tintColor = UIColor.white
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        layer.masksToBounds = false
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.7
        barTintColor = .gray
//        setBackgroundImage(nil, for: .default)
//        shadowImage = nil
        prefersLargeTitles = true
    }
    
    func transparentNavigationBar() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
    }
}
