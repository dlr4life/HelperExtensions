//
//  UTSignatureView.swift
//  XtraCredit
//
//  Created by DLR on 5/27/20.
//  Copyright © 2020 DLR. All rights reserved.
//

import QuartzCore
import UIKit

class UTSignatureView: UIView {
    
    private var path: UIBezierPath?
    private var previousPoint = CGPoint.zero
    private var signaturePlaceholder: String = "Sign Here..."
    
    private var _placeholderLabel: UILabel?
    var placeholderLabel: UILabel? {
        if _placeholderLabel == nil { // String("\(signaturePlaceholder)") {
            _placeholderLabel = UILabel()
            _placeholderLabel?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            _placeholderLabel?.textAlignment = .center
            _placeholderLabel?.textColor = UIColor.lightGray
        }
        return _placeholderLabel
    }
    
    var signatureColor: UIColor?
    // Default is black
    var hasSignature: Bool {
        return !(path?.isEmpty ?? false)
    }
    
    var signaturePath: UIBezierPath? {
        return path
    }
    
    var signatureImage: UIImage? {
        // Scale bounds to create bigger image
        var bounds = self.bounds
        bounds.size.width = 3
        bounds.size.height = 3
        UIGraphicsBeginImageContext(bounds.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
        context?.fill(bounds)
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        context?.scaleBy(x: 3, y: 3)
        path?.stroke()
        
        let signatureImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return signatureImage
    }
    
    var signatureImageData: Data? {
        return signatureImage?.pngData()
    }
    // Returns PNG representation
    @objc func clear() {
        path = UIBezierPath()
        placeholderLabel?.isHidden = false
        setNeedsDisplay()
    }
    
    // MARK: - Init -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        placeholderLabel?.frame = bounds
        
        if let placeholderLabel = placeholderLabel {
            addSubview(placeholderLabel)
        }
        
        signatureColor = UIColor.black
        path = UIBezierPath()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        panGestureRecognizer.minimumNumberOfTouches = 1
        panGestureRecognizer.maximumNumberOfTouches = 1
        addGestureRecognizer(panGestureRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(clear))
        addGestureRecognizer(longPressRecognizer)
    }
    
    // MARK: - Accessors -
    
    // MARK: - Actions -
    
    // MARK: - Private -
    @objc func pan(_ panGestureRecognizer: UIPanGestureRecognizer?) {
        let currentPoint = panGestureRecognizer?.location(in: self)
        let midPoint = middlePoint(previousPoint, currentPoint ?? CGPoint.zero)
        
        if panGestureRecognizer?.state == .began {
            path?.move(to: currentPoint ?? CGPoint.zero)
        } else if panGestureRecognizer?.state == .changed {
            path?.addQuadCurve(to: midPoint, controlPoint: previousPoint)
        }
        
        placeholderLabel?.isHidden = !(path?.isEmpty ?? false)
        previousPoint = currentPoint ?? CGPoint.zero
        
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        signatureColor?.setStroke()
        path?.stroke()
    }
}

private func middlePoint(_ p0: CGPoint, _ p1: CGPoint) -> CGPoint {
    return CGPoint(x: 0.5 * (p0.x + p1.x), y: 0.5 * (p0.y + p1.y))
}
