//
//  RouteDetailLeftView.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/24.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteDetailLeftView: UIView {
    var waypoint:WayPoint? = nil
    
    override func draw(_ rect: CGRect) {
        let viewHeight = self.bounds.height
        let viewWidth = self.bounds.width
        
        var path = UIBezierPath()
        path.lineWidth = 2
        
        switch waypoint!.type {
        case .metro:
            let metroStation = waypoint!.node as! MetroStation
            if(waypoint!.onboarding){
                lineColor(line: metroStation.line).setStroke()
                
                path.move(to: CGPoint(x: viewWidth/2.0, y: 40))
                path.addLine(to: CGPoint(x: viewWidth/2.0, y: viewHeight))
            }
            else{
                lineColor(line: metroStation.line).setStroke()
                path.move(to: CGPoint(x: viewWidth/2.0, y: 0))
                path.addLine(to: CGPoint(x: viewWidth/2.0, y: 12))
            }
        case .bus:
            let busStop = waypoint!.node as! BusStop
            //let myBus = busStop.busList?[0]
            if(waypoint!.onboarding){
                //myBus의 type에 대한 color로 setStroke()
                UIColor.systemBlue.setStroke()
                path.move(to: CGPoint(x: viewWidth/2.0, y: 28))
                path.addLine(to: CGPoint(x: viewWidth/2.0, y: viewHeight))
            }
            else{
                UIColor.systemBlue.setStroke()
                path.move(to: CGPoint(x: viewWidth/2.0, y: 0))
                path.addLine(to: CGPoint(x: viewWidth/2.0, y: 12))
            }
        default:
            let _ = 1+1
        }
        
        path.stroke()
        
        
    }
    
    func setWalkPath(path:UIBezierPath){
        path.setLineDash([3,3], count: 2, phase: 0)
        UIColor.systemGray4.setStroke()
    }
}
