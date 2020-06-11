//
//  PlaceSearchParentsViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/11.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class LocationSearchParentsViewController: UIViewController {
    
    var searchBarPlaceholder = ""
    var searchBarText = ""
    var isStartingLocationSearching = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "locationSearchBarEmbedSegue"){
            let locationSearchBarVC = segue.destination as! LocationSearchBarViewController
            
            locationSearchBarVC.searchBarPlaceholder = searchBarPlaceholder
            locationSearchBarVC.searchBarText = searchBarText
        }
        else{ //placeSearchResultEmbedSegue
            let locationSearchResultTVC = segue.destination as! LocationSearchResultTableViewController
            
            locationSearchResultTVC.isStartingLocationSearching = isStartingLocationSearching
        }
    }

}
