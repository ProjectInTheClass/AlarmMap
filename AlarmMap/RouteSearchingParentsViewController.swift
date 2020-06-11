//
//  RouteSearchingParentsViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/10.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteSearchingParentsViewController: UIViewController {
    
    var myRouteInfo:RouteInfo? = nil
    
    var startingLocation:Location? = nil
    var destinationLocation:Location? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startingLocation = myRouteInfo!.route.startingPoint
        destinationLocation = myRouteInfo!.route.destinationPoint
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "RouteSearchBarEmbedSegue"){
            let routeSearchBarVC = segue.destination as! RouteSearchBarsViewController
            
            routeSearchBarVC.startingLocation = startingLocation
            routeSearchBarVC.destinationLocation = destinationLocation
        }
        else{ //RouteSearchResultEmbedSegue
            
        }
    }
    
    @IBAction func unwindRouteSearchingParentsVC (segue : UIStoryboardSegue) {
        
    }

}
