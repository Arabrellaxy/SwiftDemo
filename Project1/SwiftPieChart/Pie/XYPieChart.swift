//
//  XYPieChart.swift
//  SwiftPieChart
//
//  Created by 谢艳 on 2018/9/26.
//  Copyright © 2018年 XY. All rights reserved.
//

import UIKit

class XYPieChart: UIView {
    lazy var items:[XYPieChartItem] = {
        return [XYPieChartItem]()
    }()
    var endPercentages = [CGFloat]()
    var pieLayer :CAShapeLayer = {
        return CAShapeLayer()
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame:CGRect,items:[XYPieChartItem]) {
        super.init(frame:frame)
        self.items = items
        self.calPercentage()
    }
   
    lazy var innerRadius :CGFloat = {
        return self.bounds.size.width/6
    }()
    
    lazy var outterRadius:CGFloat = {
        return self.bounds.size.width / 2
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.strokeChart()
    }
    func strokeChart() {
        for index in 0..<self.items.count {
            let item = self.items[index]
            let startPercentage = self.startPercentageAtIndex(index: index)
            let endPercentage = self.endPercentageAtIndex(index: index)
            let radius = self.innerRadius+(self.outterRadius-self.innerRadius)/2
            let borderWidth = self.outterRadius-self.innerRadius
            let currentPieLayer = self.newCircelLayerWithRadius(radius: radius, startPercentage: startPercentage, endPercentage: endPercentage, fillColor: UIColor.clear, borderColor: item.color!, borderWidth: borderWidth)
            self.pieLayer.addSublayer(currentPieLayer)
        }
        self.maskLayer()
        self.addAnimation()
    }
    func calPercentage(){
        var currentTotal:CGFloat = 0
        var total: CGFloat = 0
        total =  self.items.reduce(total) { (total, item) -> CGFloat in
            return total + item.value!
        }
        for index in  0 ..< self.items.count {
            currentTotal = currentTotal+self.items[index].value!
            self.endPercentages.append(currentTotal/total)
        }
        self.layer.addSublayer(self.pieLayer)
    }
    
}

extension XYPieChart {
    func startPercentageAtIndex(index:Int)-> CGFloat{
        guard index > 0 else {
            return 0
        }
        return self.endPercentages[index-1]
    }
    func endPercentageAtIndex(index:Int)->CGFloat {
        return self.endPercentages[index]
    }
    func newCircelLayerWithRadius(radius:CGFloat, startPercentage:CGFloat, endPercentage:CGFloat,fillColor:UIColor,borderColor:UIColor,borderWidth:CGFloat)->CAShapeLayer{
        let cicle = CAShapeLayer(layer: self.layer)
        let center = CGPoint(x:self.bounds.midX,y:self.bounds.midY)
        let path:UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -(CGFloat)(Double.pi/2), endAngle: CGFloat(Double.pi/2*3), clockwise: true)
        cicle.fillColor = fillColor.cgColor
        cicle.strokeColor = borderColor.cgColor
        cicle.strokeStart = startPercentage
        cicle.strokeEnd = endPercentage
        cicle.lineWidth = borderWidth
        cicle.path = path.cgPath
        return cicle
    }
    func addAnimation(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.isRemovedOnCompletion = true
        self.pieLayer.mask?.add(animation, forKey: "circleAnimation")
    }
    func maskLayer()  {
        let radius = self.innerRadius+(self.outterRadius-self.innerRadius)/2
        let borderWidth = self.outterRadius-self.innerRadius
        let maskLayer = self.newCircelLayerWithRadius(radius: radius, startPercentage: 0, endPercentage: 1, fillColor: UIColor.clear, borderColor: UIColor.black, borderWidth: borderWidth)
        self.pieLayer.mask = maskLayer
    }
}
