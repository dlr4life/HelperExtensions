//
//  CustomAlertView.swift
//  XtraCredit
//
//  Created by DLR on 12/15/18.
//  Copyright © 2018 DLR. All rights reserved.
//

import UIKit

class CustomAlertView: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var boxImage: UIImageView!

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var delegate: CustomAlertViewDelegate?
    var selectedOption = "First"
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.boxImage.layer.backgroundColor = UIColor(red:0.00, green:0.44, blue:1.00, alpha:1.0).cgColor
//        self.boxImage.layer.cornerRadius = boxImage.frame.height / 2
//        self.boxImage.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
//        jumpingHints()
        cancelButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
        cancelButton.addBorder(side: .Right, color: alertViewGrayColor, width: 1)
        okButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
    }
    
    // MARK: - Functions

    func setupView() {
        alertView.layer.cornerRadius = 15
        self.titleLabel.text = "Alert"
        self.messageLabel.text = "One of the required fields is blank. All fields are required to proceed."
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    func jumpingHints() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.boxImage.center.y += self.alertView.bounds.width / 5
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            let transitionOptions: UIView.AnimationOptions = [.repeat, .autoreverse]
            UIView.transition(with: self.boxImage, duration: 1.0, options: transitionOptions, animations: {
            })
        }, completion: nil)
    }
    
    // MARK: - Buttons

    @IBAction func onTapCancelButton(_ sender: Any) {
        delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapOkButton(_ sender: Any) {
        delegate?.okButtonTapped(selectedOption: selectedOption)
        self.dismiss(animated: true, completion: nil)
    }
}
