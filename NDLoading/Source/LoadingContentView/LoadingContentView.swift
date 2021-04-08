//
//  LoadingContentView.swift
//  NDLoading
//
//  Created by Nghia Dinh on 4/7/21.
//

import UIKit

class LoadingContentView: UIView {
    private let loadingTag: Int = 10637
    var style: LoadingStyle? {
        didSet {
            self.removeAllSubView()
            self.updateView()
        }
    }
    
    var setting: NDLoadingSetting? {
        didSet {
            if var view = self.viewWithTag(loadingTag) as? NDLoadingSettingProtocol {
                view.setting = setting
            } else {
                self.removeAllSubView()
                self.updateView()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.updateView()
        
    }
    
    func updateView() {
        var view: UIView?
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        switch style {
        case .Style1:
            view = LoadingStyle1(frame: frame)
            break
        case .Style2:
            view = LoadingStyle2(frame: frame)
            break
        case .Style3:
            view = LoadingStyle3(frame: frame)
            break
        case .Style4:
            view = LoadingStyle4(frame: frame)
            break
        case .Style5:
            view = LoadingStyle5(frame: frame)
            break
        default:
            break
        }
        if var view = view as? NDLoadingSettingProtocol {
            view.setting = setting
        }
        if let view = view {
            view.tag = self.loadingTag
            self.addSubview(view)
        }
    }
    
    func removeAllSubView() {
        self.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    func stopAnimation() {
        if let view = self.viewWithTag(loadingTag) as? NDLoadingSettingProtocol {
            view.stopAnimation()
        }
    }
    
}
