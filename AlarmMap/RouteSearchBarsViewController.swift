//
//  RouteSearchBarsViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/10.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteSearchBarsViewController: UIViewController {
    
    @IBOutlet var startingPointTextField: UITextField!
    
    @IBOutlet var destinationPointTextField: UITextField!
    
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.backgroundView.layer.addBorder([.bottom], color: .systemGray4, width: 0.5)
    
        startingPointTextField.backgroundColor = .systemGray6
        destinationPointTextField.backgroundColor = .systemGray6
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let placeSearchParentsVC = segue.destination as! PlaceSearchParentsViewController
        placeSearchParentsVC.searchBarPlaceholder = (sender as! UITextField).placeholder!
    }

    @IBAction func staringPntTxtFldEditingBegin(_ sender: Any) {
        startingPointTextField.endEditing(true)
        performSegue(withIdentifier: "placeSearchSegue", sender: sender)
    }
    
    @IBAction func destinationPntTxtFldEditingBegin(_ sender: Any) {
        destinationPointTextField.endEditing(true)
        performSegue(withIdentifier: "placeSearchSegue", sender: sender)
    }
}
