//
//  PlaceSearchParentsViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/11.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class PlaceSearchParentsViewController: UIViewController {
    
    var searchBarPlaceholder = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "placeSearchBarEmbedSegue"){
            let placeSearchBarVC = segue.destination as! PlaceSearchBarViewController
            
            placeSearchBarVC.searchBarPlaceholder = searchBarPlaceholder
        }
        else{ //placeSearchResultEmbedSegue
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
