//
//  NDLoading.swift
//  NDLoading
//
//  Created by Nghia Dinh on 4/7/21.
//

import Foundation
import UIKit


class Loading {
    static let shared = Loading()
    let loadingView: LoadingContentView = LoadingContentView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    let backgroundView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3028994278)
        return view
    }()
}

public class NDLoading {
    public static var style: LoadingStyle? = .Style1 {
        didSet {
            Loading.shared.loadingView.style = style
        }
    }
    
    public static var setting: NDLoadingSetting? {
        didSet {
            Loading.shared.loadingView.setting = setting
        }
    }
    
    
    open class func show(onViewController vc: UIViewController? = nil) {
        if let vc = vc {
            self.addLoading(toView: vc.view)
        } else if let window = UIApplication.shared.windows.last{
            self.addLoading(toView: window)
        }
    }
    
    open class func dissmiss() {
        UIView.animate(withDuration: 0.2, animations: {
            Loading.shared.loadingView.alpha = 0.0
            Loading.shared.backgroundView.alpha = 0.0
            Loading.shared.loadingView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            Loading.shared.loadingView.stopAnimation()
            Loading.shared.loadingView.removeFromSuperview()
            Loading.shared.backgroundView.removeFromSuperview()
            Loading.shared.loadingView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
}

extension NDLoading {
    fileprivate class func addLoading(toView view: UIView) {
        if !view.subviews.contains(Loading.shared.backgroundView) {
            Loading.shared.backgroundView.layer.zPosition =  CGFloat(Float.greatestFiniteMagnitude)
            Loading.shared.backgroundView.frame = view.frame
            Loading.shared.loadingView.center = Loading.shared.backgroundView.center
            // Animation addsubview
            Loading.shared.backgroundView.alpha = 0.0
            Loading.shared.loadingView.alpha = 0.0
            
            view.addSubview(Loading.shared.backgroundView)
            Loading.shared.backgroundView.addSubview(Loading.shared.loadingView)
            
            Loading.shared.loadingView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            Loading.shared.loadingView.alpha = 0.0
            
            UIView.animate(withDuration: 0.2) {
                Loading.shared.loadingView.alpha = 1.0
                Loading.shared.backgroundView.alpha = 1.0
                Loading.shared.loadingView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
