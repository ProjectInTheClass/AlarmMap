//
//  BusListSettingViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/09.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusListSettingViewController: UIViewController {

    
    @IBOutlet var busStopNameLabel: UILabel!
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var busStopDirectionLabel: UILabel!
    
    var busStop:BusStop? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busStopNameLabel.text = busStop!.name
        
        busStopDirectionLabel.text = ""
        if let busStopDirection = busStop?.direction {
            busStopDirectionLabel.text = busStopDirection + " 방면"
        }
        
        self.backgroundView.layer.addBorder([.bottom], color: .systemGray3, width: 0.3)
    }
    
    
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

