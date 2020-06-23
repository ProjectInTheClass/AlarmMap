//
//  RoutePreviewBarView.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/24.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RoutePreviewBarView: UIView {
    
    var myRouteInfo:RouteInfo? = nil
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let viewHeight = self.bounds.height
        let viewWidth = self.bounds.width
        path.move(to: CGPoint(x: 0, y: viewHeight/2))
        path.addLine(to: CGPoint(x: viewWidth*0.5, y: viewHeight/2))
        path.addLine(to: CGPoint(x: viewWidth*0.1, y: viewHeight/2))
        path.lineWidth = 3
        UIColor.red.setStroke()
        path.stroke()
       
        
    }
}
