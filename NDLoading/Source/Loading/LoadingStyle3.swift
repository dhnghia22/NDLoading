//
//  LoadingStyle3.swift
//  NDLoading
//
//  Created by Nghia Dinh on 4/8/21.
//

import Foundation
import UIKit

class LoadingStyle3: UIView, NDLoadingSettingProtocol {
    var setting: NDLoadingSetting? {
        didSet {
            removeAllSubLayer()
            setupView()
            setupPath()
        }
    }
    
    private var overlayLayer = CAShapeLayer()
    private var mainLayer = CAShapeLayer()
    private let padding: CGFloat = 16.0

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let centerX = self.center.x
        let space = (self.frame.height - (padding * 2)) / 3
        let height = (self.frame.height - (padding * 2)) / 3
        
        let leftPath = UIBezierPath()
        leftPath.move(to: CGPoint(x: centerX - (setting?.widthLoading ?? 6) / 2 - 12, y: self.frame.minY + padding))
        leftPath.addLine(to: CGPoint(x: centerX - (setting?.widthLoading ?? 6) / 2 - 12, y: self.frame.minY + padding + height))
        
        let leftPathLayer = CAShapeLayer()
        leftPathLayer.path = leftPath.cgPath
        leftPathLayer.lineWidth = setting?.widthLoading ?? 6
        leftPathLayer.strokeColor = (setting?.mainColor ?? UIColor.red).cgColor
        
        self.layer.addSublayer(leftPathLayer)
        
        
        let centerPath = UIBezierPath()
        centerPath.move(to: CGPoint(x: centerX, y: self.frame.minY + padding + space))
        centerPath.addLine(to: CGPoint(x: centerX, y: self.frame.minY + padding + space + height))
        
        let centerPathLayer = CAShapeLayer()
        centerPathLayer.path = centerPath.cgPath
        centerPathLayer.lineWidth = setting?.widthLoading ?? 6
        centerPathLayer.strokeColor = (setting?.mainColor ?? UIColor.red).cgColor
        
        self.layer.addSublayer(centerPathLayer)
        
        
        let rightPath = UIBezierPath()
        
        rightPath.move(to: CGPoint(x: centerX + (setting?.widthLoading ?? 6) / 2 + 12, y: self.frame.minY + padding + space * 2))
        rightPath.addLine(to: CGPoint(x: centerX + (setting?.widthLoading ?? 6) / 2 + 12, y: self.frame.minY + padding + space * 2 + height))
        
        let rightPathLayer = CAShapeLayer()
        rightPathLayer.path = rightPath.cgPath
        rightPathLayer.lineWidth = setting?.widthLoading ?? 6
        rightPathLayer.strokeColor = (setting?.mainColor ?? UIColor.red).cgColor
        
        self.layer.addSublayer(rightPathLayer)
        
        ///---- Add animation
        
        let leftAnimation = CAKeyframeAnimation()
        leftAnimation.keyPath = "position.y"
        let leftStartAni = 0
        let leftEndAni = self.frame.maxY - padding * 2 - height
        leftAnimation.values = [leftStartAni, leftEndAni, leftStartAni]
        leftAnimation.keyTimes = [0, 0.5, 1]
        leftAnimation.duration = 0.6
        leftAnimation.repeatCount = .infinity
        leftAnimation.isAdditive = true
        
        leftPathLayer.add(leftAnimation, forKey: "leftLayerAnim")
        
        
        let centerAnimation = CAKeyframeAnimation()
        centerAnimation.keyPath = "position.y"
        let centerStartAni = 0
        let centerBottomAni = self.frame.maxY - padding * 2 - height - space
        let centerTopAni = -space
        centerAnimation.values = [centerStartAni, centerBottomAni, centerTopAni, centerStartAni]
        centerAnimation.keyTimes = [0, 0.16, 0.66, 1]
        centerAnimation.duration = 0.6
        centerAnimation.repeatCount = .infinity
        centerAnimation.isAdditive = true
        
        centerPathLayer.add(centerAnimation, forKey: "centerAnimation")
        
        
        let rightAnimation = CAKeyframeAnimation()
        rightAnimation.keyPath = "position.y"
        let rightStartAni = 0
        let rightEndAni = -(space * 2)
        rightAnimation.values = [rightStartAni, rightEndAni, rightStartAni]
        centerAnimation.keyTimes = [0, 0.5, 1]
        rightAnimation.duration = 0.6
        rightAnimation.repeatCount = .infinity
        rightAnimation.isAdditive = true
        
        rightPathLayer.add(rightAnimation, forKey: "rightLayerAnim")
        
    }
    
    private func removeAllSubLayer() {
        self.layer.sublayers?.forEach({ (layer) in
            layer.removeAllAnimations()
            layer.removeFromSuperlayer()
        })
    }
    
    func stopAnimation() {
    }
}

