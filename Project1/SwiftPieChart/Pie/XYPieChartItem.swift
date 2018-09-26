//
//  XYPieChartItem.swift
//  SwiftPieChart
//
//  Created by 谢艳 on 2018/9/26.
//  Copyright © 2018年 XY. All rights reserved.
//

import UIKit

class XYPieChartItem: NSObject {
    var text : String?
    var value : CGFloat?
    var color: UIColor?
    init(text:String,value:CGFloat,color:UIColor){
        self.text = text
        self.value = value
        self.color = color
    }
    
    func setValue(newValue:CGFloat){
        guard newValue > 0 else {
            return
        }
        self.value  = newValue != value ? newValue : value
    }
}
