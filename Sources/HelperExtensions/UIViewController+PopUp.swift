//
//  UIViewController+PopUp.swift
//  XtraCredit
//
//  Created by DLR on 5/27/20.
//  Copyright © 2020 DLR. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

public enum UIViewControllerPopUpEffectTye: String {
    case zoomIn, zoomOut, flipUp, flipDown
}

private let kLPPUPopUpViewTag                                    = 9012702
private let kLPPUPopUpBluredViewTag                              = 9012703
private let kLPPUPopUpOverlayViewTag                             = 9012701
private let kLPPURotationAngle: CGFloat                          = 70.0
private let kLPPUAnimationDuration: TimeInterval                 = 0.4
private var kLPPUAssociatedPopupEffectKey: UInt8                 = 0
private var kLPPUAssociatedPopupViewControllerKey: UInt8         = 1
private var kLPPUAssociatedPopupViewControllerDelegateKey: UInt8 = 2

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIViewController {
    
    public func presentPopUpViewController(_ viewController: UIViewController) {
        presentPopUpViewController(viewController, completion: nil)
    }
    
    public func presentPopUpViewController(_ viewController: UIViewController, completion: (()->Void)?) {
        enPopupViewController = viewController
        presentPopUpView(viewController.view, completion: completion)
    }
    
    public func dismissPopUpViewController() {
        dismissPopUpViewController(nil)
    }
    
    @objc public func dismissPopUpViewController(_ completion: (()->Void)?) {
        let sourceView  = topView()
        let popupView   = sourceView.viewWithTag(kLPPUPopUpViewTag)
        let overlayView = sourceView.viewWithTag(kLPPUPopUpOverlayViewTag)
        let blurView    = sourceView.viewWithTag(kLPPUPopUpBluredViewTag) as? VisualEffectView
        performDismissAnimation(sourceView, blurView: blurView, popupView: popupView, overlayView: overlayView, completion: completion)
    }
    
    private func presentPopUpView(_ popUpView: UIView, completion: (()->Void)?) {
        let sourceView = topView()
        guard !sourceView.subviews.contains(popUpView) else { return }

        let overlayView                = UIView(frame: sourceView.bounds)
        overlayView.autoresizingMask   = [.flexibleWidth, .flexibleHeight]
        overlayView.tag                = kLPPUPopUpOverlayViewTag
        overlayView.backgroundColor    = .clear

        let bluredView                 = VisualEffectView(frame: sourceView.bounds)
        bluredView.blurRadius          = 4
        bluredView.colorTint           = .black
        bluredView.autoresizingMask    = [.flexibleWidth, .flexibleHeight]
        bluredView.tag                 = kLPPUPopUpBluredViewTag
        sourceView.addSubview(bluredView)

        let dismissButton              = UIButton(type: .custom)
        dismissButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dismissButton.backgroundColor  = UIColor.black.withAlphaComponent(0.3)
        dismissButton.frame            = sourceView.bounds
        dismissButton.addTarget(self, action: #selector(self.dismissBtnEvent), for: .touchUpInside)
        overlayView.addSubview(dismissButton)

        popUpView.layer.cornerRadius   = 7
        popUpView.layer.masksToBounds  = true
        popUpView.layer.zPosition      = 99
        popUpView.tag                  = kLPPUPopUpViewTag
        popUpView.center               = overlayView.center
        popUpView.setNeedsLayout()
        popUpView.setNeedsDisplay()
        overlayView.addSubview(popUpView)
        sourceView.addSubview(overlayView)

        performAppearAnimation(bluredView, popupView: popUpView, completion: completion)
    }
    
    @objc private func dismissBtnEvent() {
        dismissPopUpViewController()
    }
    
    private func transform3d() -> CATransform3D {
        let topVc = topView().parentViewController ?? self
        switch topVc.popUpEffectType! {
        case .flipUp:
            var transform = CATransform3DIdentity
            transform     = CATransform3DTranslate(transform, 0.0, 200.0, 0.0)
            transform.m34 = 1.0 / 800.0
            transform     = CATransform3DRotate(transform, kLPPURotationAngle * CGFloat(Double.pi) / 180.0, 1.0, 0.0, 0.0)
            let scale     = CATransform3DMakeScale(0.8, 0.8, 0.8)
            return CATransform3DConcat(transform, scale)

        case .flipDown:
            var transform = CATransform3DIdentity
            transform     = CATransform3DTranslate(transform, 0.0, -200.0, 0.0)
            transform.m34 = 1.0 / 800.0
            transform     = CATransform3DRotate(transform, 180 + kLPPURotationAngle * CGFloat(Double.pi) / 180.0, 1.0, 0.0, 0.0)
            let scale     = CATransform3DMakeScale(0.7, 0.7, 0.7)
            return CATransform3DConcat(transform, scale)
            
        case .zoomIn:
            return CATransform3DMakeScale(0.01, 0.01, 1.00)
            
        case .zoomOut:
            return CATransform3DMakeScale(1.50, 1.50, 1.50)
            
        }
        
    }
    
    private func performAppearAnimation(_ blurView: VisualEffectView, popupView: UIView, completion: (()->Void)?) {
        popupView.layer.transform = transform3d()
        let transform             = CATransform3DIdentity
        UIView.animate(withDuration: kLPPUAnimationDuration, animations: { [weak self] in
            self!.enPopupViewController?.viewWillAppear(false)
            popupView.layer.transform = transform
        }) { [weak self] (finished: Bool) in
            self!.enPopupViewController?.viewDidAppear(false)
            if let _ = completion {
                completion!()
            }
        }
    }
    
    private func performDismissAnimation(_ sourceView: UIView, blurView: VisualEffectView?, popupView: UIView?, overlayView: UIView?, completion: (()->Void)?) {
        let transform = transform3d()
        let topVc = topView().parentViewController ?? self
        UIView.animate(withDuration: kLPPUAnimationDuration, animations: { [weak topVc] in
            topVc!.enPopupViewController?.viewWillDisappear(false)
            if let _ = popupView {
                popupView!.layer.transform = transform
            }
        }) { [weak topVc] (finished: Bool) in
            if let _ = popupView {
                popupView!.removeFromSuperview()
            }
            if let _ = blurView {
                blurView!.removeFromSuperview()
            }
            if let _ = overlayView {
                overlayView!.removeFromSuperview()
            }
            topVc!.enPopupViewController?.viewDidDisappear(false)
            topVc!.enPopupViewController = nil
            if let _ = completion {
                completion!()
            }
        }
    }
    
    private func topView() -> UIView {
        let recentViewController = self
        return recentViewController.view.superview != nil ? (recentViewController.view.superview!.parentViewController != nil ? recentViewController.view.superview!.parentViewController!.view : recentViewController.view) : recentViewController.view
    }
    
    public var enPopupViewController: UIViewController? {
        get {
            return objc_getAssociatedObject(self, &kLPPUAssociatedPopupViewControllerKey) as? UIViewController
        }
        
        set(newPopupViewController) {
            objc_setAssociatedObject(self, &kLPPUAssociatedPopupViewControllerKey, newPopupViewController, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var popUpEffectType: UIViewControllerPopUpEffectTye? {
        get {
            if let effect = objc_getAssociatedObject(self, &kLPPUAssociatedPopupEffectKey) as? String {
                return UIViewControllerPopUpEffectTye(rawValue: effect)
            } else {
                return .zoomIn
            }
        }
        
        set(newEffect) {
            objc_setAssociatedObject(self, &kLPPUAssociatedPopupEffectKey, newEffect!.rawValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
