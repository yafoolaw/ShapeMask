//
//  ViewController.swift
//  ShapeMask
//
//  Created by FrankLiu on 15/11/9.
//  Copyright © 2015年 刘大帅. All rights reserved.
//
//  https://github.com/yafoolaw
//  http://www.jianshu.com/users/09e77d340dcf/latest_articles
//

import UIKit

class ViewController: UIViewController {
    
    var movedMask:CALayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blackColor()
        
        mask()
        
//        emitterMask()
        
    }
    
    func handlePan(recongnizer: UIPanGestureRecognizer) {
    
        // 拖拽
        let translation: CGPoint = recongnizer.translationInView(view)
        recongnizer.view?.center = CGPoint(x: (recongnizer.view?.center.x)! + translation.x, y: (recongnizer.view?.center.y)! + translation.y)
        recongnizer.setTranslation(CGPoint(x: 0, y: 0), inView: view)
        
        // 关闭CoreAnimation实时隐式动画绘制(核心)
        CATransaction.setDisableActions(true)
        movedMask?.position = (recongnizer.view?.center)!
    }
    
    func mask() {
    
        // 背景图片与mask图片
        let backgroundImage: UIImage = UIImage(named: "background")!
        let maskImage:       UIImage = UIImage(named: "mask")!
        
        // 背景图片显示
        let backgroundIV: UIImageView = UIImageView(frame: view.bounds)
        backgroundIV.image = backgroundImage.grayScale()
        view.addSubview(backgroundIV)
        
        // 遮罩图片显示
        let backgroundChangedIV: UIImageView = UIImageView(frame: view.bounds)
        backgroundChangedIV.image = backgroundImage
        view.addSubview(backgroundChangedIV)
        
        // 形成遮罩
        movedMask = CALayer()
        movedMask?.frame = CGRect(origin: CGPointZero, size: maskImage.size)
        movedMask?.contents = maskImage.CGImage
        movedMask?.position = view.center
        backgroundChangedIV.layer.mask = movedMask
        
        // 拖拽的view
        let dragView: UIView = UIView(frame: CGRect(origin: CGPointZero, size: maskImage.size))
        dragView.center = view.center
        view.addSubview(dragView)
        
        // 给dragView添加拖拽手势
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        dragView.addGestureRecognizer(pan)
    }
    
    func emitterMask() {
    
        // 创建粒子layer
        let snowEmitter: CAEmitterLayer = CAEmitterLayer()
        
        // 粒子发射位置
        snowEmitter.emitterPosition = CGPoint(x: 120, y: 0)
        
        // 发射源的尺寸大小
        snowEmitter.emitterSize = view.bounds.size
        
        // 发射模式
        snowEmitter.emitterMode = kCAEmitterLayerSurface
        
        // 发射源的形状
        snowEmitter.emitterShape = kCAEmitterLayerLine
        
        // 创建雪花类型的粒子
        let snowFlake: CAEmitterCell = CAEmitterCell()
        
        // 粒子的名字
        snowFlake.name = "snow"
        
        // 粒子参数的速度乘数因子
        snowFlake.birthRate = 15
        snowFlake.lifetime  = 60
        
        // 粒子速度
        snowFlake.velocity = 10
        
        // 粒子的速度范围
        snowFlake.velocityRange = 10
        
        // 粒子y方向的加速度分量
        snowFlake.yAcceleration = 20
        
        // 周围发射角度
        snowFlake.emissionRange = CGFloat(0.5 * M_PI)
        
        // 子旋转角度范围
        snowFlake.spinRange = CGFloat(0.25 * M_PI)
        snowFlake.contents  = UIImage(named: "snow")?.CGImage
        
        // 设置雪花形状粒子的颜色
        snowFlake.color = UIColor.whiteColor().CGColor
        
        snowFlake.scale      = 0.2
        snowFlake.scaleRange = 0.2
        
        snowEmitter.shadowOpacity = 1
        snowEmitter.shadowRadius  = 0
        snowEmitter.shadowOffset  = CGSizeZero
        
        // 粒子边缘的颜色
        snowEmitter.shadowColor = UIColor.whiteColor().CGColor
        
        // 添加粒子
        snowEmitter.emitterCells = [snowFlake]
        
        // 将粒子layer添加进图层
        view.layer.addSublayer(snowEmitter)
        
        // 形成遮罩
        let maskImage: UIImage = UIImage(named: "mask")!
        movedMask = CALayer()
        movedMask?.frame = CGRect(origin: CGPointZero, size: maskImage.size)
        movedMask?.contents = maskImage.CGImage
        movedMask?.position = view.center
        snowEmitter.mask = movedMask
        
        // 拖拽的view
        let dragView: UIView = UIView(frame: CGRect(origin: CGPointZero, size: maskImage.size))
        dragView.center = view.center
        view.addSubview(dragView)
        
        // 给dragView添加拖拽手势
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        dragView.addGestureRecognizer(pan)
        
    }
}

