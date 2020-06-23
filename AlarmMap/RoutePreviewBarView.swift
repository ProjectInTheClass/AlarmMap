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
        let routeToDraw = myRouteInfo!.route
        let totalTime = Float(myRouteInfo!.totalTime)
        
        let viewHeight = self.bounds.height
        let viewWidth = self.bounds.width
        
        var currentX:Float = 0
        
        for waypoint in routeToDraw {
            let path = UIBezierPath()
            
            path.lineWidth = 3
            
            switch waypoint.type {
            case .walk:
                setWalkPath(path: path)
            case .metro:
                if(waypoint.onboarding){
                    let metroStation = waypoint.node as! MetroStation
                    lineColor(line: metroStation.line).setStroke()
                }
                else{
                    setWalkPath(path: path)
                }
            case .bus:
                if(waypoint.onboarding){
                    let busStop = waypoint.node as! BusStop
                    let myBus = busStop.busList?[0]
                    
                    //myBus의 type에 대한 color로 setStroke()
                    UIColor.systemBlue.setStroke()
                }
                else{
                    setWalkPath(path: path)
                }
            case .end:
                continue
            }
            
            let sectionTime = Float(waypoint.takenSeconds)/60.0
            let proprtionTime = sectionTime/totalTime
            let nextX = currentX+(Float(viewWidth)*proprtionTime)
            
            path.move(to: CGPoint(x: CGFloat(currentX), y: viewHeight/2))
            path.addLine(to: CGPoint(x: CGFloat(nextX), y: viewHeight/2))
            
            path.stroke()
            
            currentX = nextX
        }
        
    }
    
    func setWalkPath(path:UIBezierPath){
        path.setLineDash([3,3], count: 2, phase: 0)
        UIColor.systemGray4.setStroke()
    }
}
