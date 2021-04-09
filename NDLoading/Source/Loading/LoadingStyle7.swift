//
//  LoadingStyle7.swift
//  NDLoading
//
//  Created by Nghia Dinh on 4/9/21.
//

import Foundation
import UIKit

class LoadingStyle7: UIView, NDLoadingSettingProtocol {
    var setting: NDLoadingSetting? {
        didSet {
            removeAllSubLayer()
            setupView()
            setupPath()
        }
    }
    
    private var overlayLayer = CAShapeLayer()
    private var mainLayer = CAShapeLayer()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let maskLayer: CALayer = {
        let maskLayer = CALayer()
        let bundle = Bundle(for: LoadingStyle7.self)
        let url = bundle.url(forResource: "NDHUD", withExtension: "bundle")
        let imageBundle = Bundle(url: url!)
        
        let path = imageBundle!.path(forResource: "angle-mask", ofType: "png")
        maskLayer.contents = UIImage(contentsOfFile: path!)!.cgImage!
        return maskLayer
    }()
    
    let flatAnimation: CABasicAnimation = {
        let animationDuration = 0.8
        let linearCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = animationDuration
        animation.timingFunction = linearCurve
        animation.isRemovedOnCompletion = false
        animation.repeatCount = .infinity
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.autoreverses = false
        return animation
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupPath()
    }
    
    func setupView() {
        self.backgroundColor = setting?.mainBackgroundColor ?? .white
        self.layer.cornerRadius = setting?.mainCornerRadius ?? 8.0
    }
    
    func setupPath() {
        let point = CGPoint(x: self.center.x, y: self.center.y )
        let radius = self.frame.width <= self.frame.height ? self.frame.width / 2 * 2 / 3 : self.frame.height / 2 * 2 / 3
        
        let backgroundPath = UIBezierPath()
        backgroundPath.addArc( withCenter: point,
                        radius: radius,
                        startAngle: 0,
                        endAngle: CGFloat(2 * Double.pi ),
                        clockwise: true)
        
        mainLayer.contentsScale = UIScreen.main.scale
        mainLayer.frame = self.frame
        mainLayer.path = backgroundPath.cgPath
        mainLayer.strokeColor = (setting?.mainColor ?? .red).cgColor
        mainLayer.fillColor = UIColor.clear.cgColor
        mainLayer.lineWidth = (setting?.widthLoading ?? 4)
        mainLayer.lineCap = CAShapeLayerLineCap.round
        maskLayer.frame = mainLayer.bounds
        mainLayer.mask = maskLayer
        
        self.layer.addSublayer(mainLayer)
        mainLayer.add(flatAnimation, forKey: "flatAnimation")
    }
    
    private func removeAllSubLayer() {
        self.layer.sublayers?.forEach({ (layer) in
            layer.removeAllAnimations()
            layer.removeFromSuperlayer()
        })
    }
    
    func stopAnimation() {
        mainLayer.removeAllAnimations()
    }
}

