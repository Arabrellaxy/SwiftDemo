//
//  ViewController.swift
//  SwiftPieChart
//
//  Created by 谢艳 on 2018/9/26.
//  Copyright © 2018年 XY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(setPieChart())
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setPieChart() -> XYPieChart {
        let item1 = XYPieChartItem(text:"text",value:20,color:UIColor.green)
        let item2 = XYPieChartItem(text:"text",value:40,color:UIColor.red)
        let item3 = XYPieChartItem(text:"text",value:30,color:UIColor.orange)
        let frame = CGRect(x: 40, y: 155, width: 240, height: 240)
        let items: [XYPieChartItem] = [item1,item2,item3]
        let pieChart = XYPieChart(frame: frame, items: items)
       
        pieChart.center = self.view.center
        return pieChart
    }

}

