//
//  LoadingStyle6.swift
//  NDLoading
//
//  Created by Nghia Dinh on 4/9/21.
//

import Foundation
import UIKit

class LoadingStyle6: UIView, NDLoadingSettingProtocol {
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
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupPath()
    }
    
    func setupView() {
        self.backgroundColor = setting?.mainBackgroundColor ?? .white
        self.layer.cornerRadius = setting?.mainCornerRadius ?? 8.0
    }
    
    private func getOpacityAnimation(withDelay delay: Double) -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.toValue = 0.1
        anim.duration = 0.3
        anim.isRemovedOnCompletion = false
        anim.repeatCount = .infinity
        anim.autoreverses = true
        anim.beginTime = CACurrentMediaTime() + delay
        return anim
    }
    
    func setupPath() {
        let paddingSize = (setting?.widthLoading ?? 6)
        
        let leftPath = UIBezierPath()
        leftPath.addArc(withCenter: CGPoint(x: self.center.x -  paddingSize * 2 - 4, y: self.center.y),
                    radius: setting?.widthLoading ?? 6,
                        startAngle: 0,
                        endAngle: CGFloat(2 * Double.pi ),
                        clockwise: true)
        
        let leftPathLayer = CAShapeLayer()
        leftPathLayer.path = leftPath.cgPath
        leftPathLayer.fillColor = (setting?.mainColor ?? UIColor.red).cgColor
        
        self.layer.addSublayer(leftPathLayer)
        
        
        let centerPath = UIBezierPath()
        centerPath.addArc(withCenter: CGPoint(x: self.center.x, y: self.center.y),
                    radius: setting?.widthLoading ?? 6,
                        startAngle: 0,
                        endAngle: CGFloat(2 * Double.pi ),
                        clockwise: true)

        
        let centerPathLayer = CAShapeLayer()
        centerPathLayer.path = centerPath.cgPath
        centerPathLayer.fillColor = (setting?.mainColor ?? UIColor.red).cgColor
        self.layer.addSublayer(centerPathLayer)
        
        
        let rightPath = UIBezierPath()
        rightPath.addArc(withCenter: CGPoint(x: self.center.x +  paddingSize * 2 + 4, y: self.center.y),
                    radius: setting?.widthLoading ?? 6,
                        startAngle: 0,
                        endAngle: CGFloat(2 * Double.pi ),
                        clockwise: true)
        
        let rightPathLayer = CAShapeLayer()
        rightPathLayer.path = rightPath.cgPath
        rightPathLayer.fillColor = (setting?.mainColor ?? UIColor.red).cgColor
        self.layer.addSublayer(rightPathLayer)
        
        ///---- Add animation
        
        let startAni = 0
        let leftEndAni = -(padding)
        
        leftPathLayer.add(getPositionAnimation(keyTimes: [0, 0.25, 0.5, 0.75, 1], values: [startAni, leftEndAni, startAni, startAni, startAni]), forKey: "leftLayerAnim")
        centerPathLayer.add(getPositionAnimation(keyTimes: [0, 0.25, 0.5, 0.75, 1], values: [startAni, startAni, leftEndAni, startAni, startAni]), forKey: "leftLayerAnim")
        rightPathLayer.add(getPositionAnimation(keyTimes: [0, 0.25, 0.5, 0.75, 1], values: [startAni, startAni, startAni, leftEndAni, startAni]), forKey: "leftLayerAnim")
        
    }
    
    private func getPositionAnimation(keyTimes keys: [NSNumber], values: [Any]) -> CAAnimation {
        let anim = CAKeyframeAnimation()
        anim.keyPath = "position.y"
        anim.values = values
        anim.keyTimes = keys
        anim.duration = 0.6
        anim.repeatCount = .infinity
        anim.isAdditive = true
        return anim
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




