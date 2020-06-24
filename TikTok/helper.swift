//
//  helper.swift
//  TikTok
//
//  Created by Mac on 2020/6/22.
//  Copyright © 2020 Kxy. All rights reserved.
//

import UIKit

extension Int {
    var toWanStr:String {
        if self > 10000 {
            return (Double(self / 1000) / 10).description + "W"
        }
        return self.description
    }
}

var layers = [CAShapeLayer]()

extension UIView {
    func raiseAnimate(imageName:String, delay:TimeInterval) {
        let path = UIBezierPath()
        
        //贝塞尔曲线起点
        let beginPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        
        //控制点的位移，随机数
        let a : CGFloat = 2
        let b : CGFloat = 1.5
        let c : CGFloat = 3
        
        let offsets1 = [a, b, c]
        
        let cxOffset = offsets1.randomElement()! * bounds.maxX
        let cyOffset = offsets1.randomElement()! * bounds.maxY
        
        //随机重点位移
        let e : CGFloat = 1.5
        let d : CGFloat = 1
        let f: CGFloat = 0.8
        
        let offSets2 = [e, d, f]
        
        let g : CGFloat = 2.5
        let h : CGFloat = 3
        let i : CGFloat = 2
        
        let offSets3 = [g, h, i]
        
        let exOffset = offSets2.randomElement()! * bounds.maxX
        let eyOffset = offSets3.randomElement()! * bounds.maxY
        
        //终点
        let endPoint = CGPoint(x: beginPoint.x - exOffset, y: beginPoint.y - eyOffset)
        
        //控制点
        let controlPoint = CGPoint(x: beginPoint.x - cxOffset, y: beginPoint.y - cyOffset)
        
        path.move(to: beginPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        let group = CAAnimationGroup()
        group.duration = 4
        group.beginTime = CACurrentMediaTime() + delay
        group.repeatCount = .infinity
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        //动画方式：线性
        group.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.path = path.cgPath
        
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        rotateAnimation.values = [0, .pi / 2.0, .pi/1.0]
        
        let alphaAnimation = CAKeyframeAnimation(keyPath: "opacity")
        alphaAnimation.values = [0, 0.3, 1, 0.3, 0]
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [1.0, 1.8, 2.0]
        
        group.animations = [pathAnimation, rotateAnimation, alphaAnimation, scaleAnimation]
        
        let layer = CAShapeLayer()
        layer.opacity = 0
        layer.contents = UIImage(named: imageName)?.cgImage
        layer.frame = CGRect(origin: beginPoint, size: CGSize(width: 10, height: 10))
        self.layer.addSublayer(layer)
        layer.add(group, forKey: nil)
        layers.append(layer)
    }
    
    //复位动画
    func resetViewAnimation() {
        for layer in layers {
            layer.removeFromSuperlayer()
        }
        self.layer.removeAllAnimations()
    }
}
