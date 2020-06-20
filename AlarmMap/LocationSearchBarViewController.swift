//
//  PlaceSearchBarViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/11.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class LocationSearchBarViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var searchBarTextField: UITextField!
    
    var isStartingLocationSearching = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isStartingLocationSearching){
            searchBarTextField.placeholder = "출발지 검색"
            searchBarTextField.text = userSelectedStartingPoint.location.name
        }
        else{
            searchBarTextField.placeholder = "도착지 검색"
            searchBarTextField.text = userSelectedDestinationPoint.location.name
        }
        
        self.backgroundView.layer.addBorder([.bottom], color: .systemGray4, width: 0.5)
    }

}
