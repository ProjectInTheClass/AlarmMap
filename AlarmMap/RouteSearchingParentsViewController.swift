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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "RouteSearchBarEmbedSegue"){
            
        }
        else{ //RouteSearchResultEmbedSegue
            
        }
    }

}
