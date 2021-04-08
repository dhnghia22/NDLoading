//
//  LoadingStyle4.swift
//  NDLoading
//
//  Created by Nghia Dinh on 4/8/21.
//

import Foundation
import UIKit

class LoadingStyle4: UIView, NDLoadingSettingProtocol {
    var setting: NDLoadingSetting? {
        didSet {
            removeAllSubLayer()
            setupPath()
        }
    }
    
    private var overlayLayer = CAShapeLayer()
    private var mainLayer = CAShapeLayer()
    private let padding: CGFloat = 16.0

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupPath()
    }
    
    func setupView() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8.0
    }
    
    private func getScaleAnimation(withDelay delay: Double) -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "transform.scale.y")
        anim.toValue = 2.0
        anim.duration = 0.3
        anim.isRemovedOnCompletion = false
        anim.repeatCount = .infinity
        anim.autoreverses = true
        anim.beginTime = CACurrentMediaTime() + delay
        return anim
    }
    
    private func getChangePositionAnimation(withDelay delay: Double) -> CABasicAnimation {
        let height = (self.frame.height - (padding * 2)) / 2
        let anim = CABasicAnimation(keyPath: "position.y")
        anim.toValue = self.center.y - height
        anim.duration = 0.3
        anim.isRemovedOnCompletion = false
        anim.beginTime = CACurrentMediaTime() + delay
        anim.repeatCount = .infinity
        anim.autoreverses = true
        return anim
    }
    
    func setupPath() {
        let centerX = self.center.x
        let height = (self.frame.height - (padding * 2)) / 2
        
        let leftPath = UIBezierPath()
        leftPath.move(to: CGPoint(x:0, y: 0))
        leftPath.addLine(to: CGPoint(x: 0 , y: height))
        
        let leftPathLayer = CAShapeLayer()
        leftPathLayer.path = leftPath.cgPath
        leftPathLayer.lineWidth = setting?.widthLoading ?? 6
        leftPathLayer.strokeColor = (setting?.mainColor ?? UIColor.red).cgColor
        leftPathLayer.position = CGPoint(x: centerX - (setting?.widthLoading ?? 6) / 2 - 12, y: self.center.y - height / 2)
        leftPathLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.layer.addSublayer(leftPathLayer)
        
        
        let centerPath = UIBezierPath()
        
        centerPath.move(to: CGPoint(x:0, y: 0))
        centerPath.addLine(to: CGPoint(x: 0, y: height))
        
        let centerPathLayer = CAShapeLayer()
        centerPathLayer.path = centerPath.cgPath
        centerPathLayer.lineWidth = setting?.widthLoading ?? 6
        centerPathLayer.strokeColor = (setting?.mainColor ?? UIColor.red).cgColor
        centerPathLayer.position = CGPoint(x: centerX, y: self.center.y - height / 2)
        centerPathLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.layer.addSublayer(centerPathLayer)
        
        
        let rightPath = UIBezierPath()
        
        rightPath.move(to: CGPoint(x: 0, y: 0))
        rightPath.addLine(to: CGPoint(x: 0, y: height))
        
        let rightPathLayer = CAShapeLayer()
        rightPathLayer.path = rightPath.cgPath
        rightPathLayer.lineWidth = setting?.widthLoading ?? 6
        rightPathLayer.strokeColor = (setting?.mainColor ?? UIColor.red).cgColor
        rightPathLayer.position = CGPoint(x: centerX + (setting?.widthLoading ?? 6) / 2 + 12, y: self.center.y - height / 2)
        rightPathLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.layer.addSublayer(rightPathLayer)
        
        ///---- Add animation
        
        
        let leftAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        leftAnimation.toValue = 2.0
        leftAnimation.duration = 0.3
        leftAnimation.isRemovedOnCompletion = false
        leftAnimation.repeatCount = .infinity
        leftAnimation.autoreverses = true
        
        
        let leftMoveAnimation = CABasicAnimation(keyPath: "position.y")
        leftMoveAnimation.toValue = self.center.y - height
        leftMoveAnimation.duration = 0.3
        leftMoveAnimation.isRemovedOnCompletion = false
        leftMoveAnimation.repeatCount = .infinity
        leftMoveAnimation.autoreverses = true

        leftPathLayer.add(getScaleAnimation(withDelay: 0), forKey: "leftLayerAnim")
        leftPathLayer.add(getChangePositionAnimation(withDelay: 0), forKey: "leftMoveAnimation")
        

        centerPathLayer.add(getScaleAnimation(withDelay: 0.2), forKey: "centerAnimation")
        centerPathLayer.add(getChangePositionAnimation(withDelay: 0.2), forKey: "centerMoveAnimation")


        rightPathLayer.add(getScaleAnimation(withDelay: 0.4), forKey: "rightAnimation")
        rightPathLayer.add(getChangePositionAnimation(withDelay: 0.4), forKey: "rightMoveAnimation")
        
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


