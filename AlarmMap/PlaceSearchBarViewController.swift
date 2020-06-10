//
//  PlaceSearchBarViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/11.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class PlaceSearchBarViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var searchBarTextField: UITextField!
    
    var searchBarPlaceholder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.backgroundView.layer.addBorder([.bottom], color: .systemGray4, width: 0.5)

        searchBarTextField.placeholder = searchBarPlaceholder
    }

}