//
//  Extensions.swift
//  XtraCredit
//
//  Created by DLR on 2/2/20.
//  Copyright © 2020 DLR. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}

@available(iOS 10.0, *)
extension CAGradientLayer {
    class func primaryGradient(on view: UIView) -> UIImage? {
        let gradient = CAGradientLayer()
        let flareRed = UIColor(displayP3Red: 255.0/255.0, green: 189.0/255.0, blue: 118.0/255.0, alpha: 1.0)
        let flareOrange = UIColor(displayP3Red: 254.0/255.0, green: 136/255.0, blue: 65.0/255.0, alpha: 1.0)
        let bounds = view.bounds
//        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
//        gradient.frame = bounds
        gradient.frame.size = bounds.size
        gradient.colors = [flareRed.cgColor, flareOrange.cgColor]
//        gradient.startPoint = CGPoint(x: 1, y: 0)
//        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0.0, 1.0]
        gradient.frame = bounds
        return gradient.createGradientImage(on: view)
    }
    
    private func createGradientImage(on view: UIView) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(view.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

extension UITextField {
    
    // SetIcon : To put an icon on the left side of the textfield using UIImage. Result :
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    // AddShadowToTextField : To add a shadow to any textfield. Result :
    func addShadowToTextField(color: UIColor = UIColor.gray, cornerRadius: CGFloat) {
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
    }
    
    // setBottomBorder : To make flat textfields that have a border at the bottom. Result :
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func setBottomCardBorder() {
        self.borderStyle = UITextField.BorderStyle.none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UITableView {
    func nextResponder(index: Int){
        var currIndex = -1
        for i in index+1..<index+100{
            if let view = self.superview?.superview?.viewWithTag(i){
                view.becomeFirstResponder()
                currIndex = i
                break
            }
        }
        
        let ind = IndexPath(row: currIndex - 100, section: 0)
        if let nextCell = self.cellForRow(at: ind){
            self.scrollRectToVisible(nextCell.frame, animated: true)
        }
    }
    
    func keyboardRaised(height: CGFloat){
        self.contentInset.bottom = height
        self.scrollIndicatorInsets.bottom = height
    }
    
    func keyboardClosed(){
        self.contentInset.bottom = 0
        self.scrollIndicatorInsets.bottom = 0
        self.scrollRectToVisible(CGRect.zero, animated: true)
    }
}

extension UserDefaults {
    var hasAlreadyLaunched: Bool {
        get{
            return bool(forKey: #function)
        } set{
            set(newValue, forKey: #function)
        }
    }
    
    enum UserDefaultsKeys: String {
        case isFirstLaunch
    }
    
    func setIsFirstLaunch(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isFirstLaunch.rawValue)
    }
    
    func isFirstLaunch() -> Bool{
        return bool(forKey: UserDefaultsKeys.isFirstLaunch.rawValue)
    }
}

extension UIView {
    
    func anchorToTop(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        anchorWithConstantsToTop(top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func anchorWithConstantsToTop(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        _ = anchor(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
}

extension String {
    
    // Splitting a string in Swift that receives a regular expression
    init(sep:String, _ lines:String...){
        self = ""
        for (idx, item) in lines.enumerated() {
            self += "\(item)"
            if idx < lines.count-1 {
                self += sep
            }
        }
    }
    
    init(_ lines:String...){
        self = ""
        for (idx, item) in lines.enumerated() {
            self += "\(item)"
            if idx < lines.count-1 {
                self += "\n"
            }
        }
    }
    
    mutating func numberFormated() -> String {
        
        guard self.count == 16 else { return self }
        for i in 1...3 {
            self.insert(" ", at: self.index(startIndex, offsetBy: -1 + (i * 5)))
        }
        return self
    }
    
    public func separate(by: String) -> String {
        let src = self
        var dst = [String]()
        var i = 1
        for char in src {
            let mod = i % 4
            dst.append(String(char))
            if mod == 0 {
                dst.append(by)
            }
            i += 1
        }
        return dst.joined(separator: "")
    }
    
    // Adding Localization
    func localization() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self
        )
    }
    
    // Formatting text for currency textField
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        var amountWithPrefix = self
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        return formatter.string(from: number)!
    }
}

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }
}

extension String {
    
    enum ValidityType {
        case name
        case age
        case email
        case password
        case website
        case phoneNumber
    }
    
    enum Regex: String {
        case name = "^\\w{3,18}$"
        case age = "[0-9]{2,2}"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        case website = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        case phoneNumber = "^[6-9]\\d{9}$"
    }
    
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .name:
            regex = Regex.name.rawValue
        case .age:
            regex = Regex.age.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        case .website:
            regex = Regex.website.rawValue
        case .phoneNumber:
            regex = Regex.phoneNumber.rawValue
//        default:
//            print("There are no rules!")
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}

extension UILabel {
    
    func strikeThroughText (_ text: String) -> NSAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: 1, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    func strikeThrough(_ isStrikeThrough:Bool) {
        if isStrikeThrough {
            if let lblText = self.text {
                let attributeString =  NSMutableAttributedString(string: lblText)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
                self.attributedText = attributeString
            }
        } else {
            if let attributedStringText = self.attributedText {
                let txt = attributedStringText.string
                self.attributedText = nil
                self.text = txt
                return
            }
        }
    }
}

extension Float {
    var localeCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        return formatter.string(from: self as NSNumber)!
    }
}

class CurrencyFormatter {
    static var outputFormatter = CurrencyFormatter.create()
    class func create(locale: Locale = Locale.current,
                      groupingSeparator: String? = nil,
                      decimalSeparator: String? = nil,
                      style: NumberFormatter.Style = NumberFormatter.Style.currency) -> NumberFormatter {
        let outputFormatter = NumberFormatter()
        outputFormatter.locale = locale
        outputFormatter.decimalSeparator = decimalSeparator ?? locale.decimalSeparator
        outputFormatter.groupingSeparator = groupingSeparator ?? locale.groupingSeparator
        outputFormatter.numberStyle = style
        return outputFormatter
    }
}

extension Numeric {
    func toCurrency(formatter: NumberFormatter = CurrencyFormatter.outputFormatter) -> String? {
        guard let num = self as? NSNumber else { return nil }
        var formatedSting = formatter.string(from: num)
        guard let locale = formatter.locale else { return formatedSting }
        if let separator = formatter.groupingSeparator, let localeValue = locale.groupingSeparator {
            formatedSting = formatedSting?.replacingOccurrences(of: localeValue, with: separator)
        }
        if let separator = formatter.decimalSeparator, let localeValue = locale.decimalSeparator {
            formatedSting = formatedSting?.replacingOccurrences(of: localeValue, with: separator)
        }
        return formatedSting
    }
}

extension CurrencyField {
    var doubleValue: Double { (decimal as NSDecimalNumber).doubleValue }
}

extension UITextField {
     var string: String { text ?? "" }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
}

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}

extension Formatter {
    static let currency: NumberFormatter = .init(numberStyle: .currency)
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isWholeNumber) }
}

extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
}

extension Decimal {
    var currency: String { Formatter.currency.string(for: self) ?? "" }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension Double {
    var twoDigits: Double {
        let nf = NumberFormatter()
        nf.numberStyle = NumberFormatter.Style.decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return self
    }
}
