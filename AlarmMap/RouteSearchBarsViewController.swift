//
//  RouteSearchBarsViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/10.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteSearchBarsViewController: UIViewController {
    
    @IBOutlet var startingLocationTextField: UITextField!
    
    @IBOutlet var destinationLocationTextField: UITextField!
    
    @IBOutlet var backgroundView: UIView!
    
    var startingLocation:Location? = nil
    var destinationLocation:Location? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startingLocationTextField.text = ""
        if let startingLocationText = startingLocation?.title {
            startingLocationTextField.text = startingLocationText
        }
        
        destinationLocationTextField.text = ""
        if let destinationLocationText = destinationLocation?.title {
            destinationLocationTextField.text = destinationLocationText
        }
        
         self.backgroundView.layer.addBorder([.bottom], color: .systemGray4, width: 0.5)
    
        startingLocationTextField.backgroundColor = .systemGray6
        destinationLocationTextField.backgroundColor = .systemGray6
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let locationSearchParentsVC = segue.destination as! LocationSearchParentsViewController
        
        locationSearchParentsVC.searchBarPlaceholder = (sender as! UITextField).placeholder!
        locationSearchParentsVC.searchBarText = (sender as! UITextField).text!
        
        if (segue.identifier == "startingLocationSearchSegue"){
            locationSearchParentsVC.isStartingLocationSearching = true
        }
        else {
            locationSearchParentsVC.isStartingLocationSearching = false
        }
    }

    @IBAction func staringLctnTxtFldEditingBegin(_ sender: Any) {
        startingLocationTextField.endEditing(true)
        performSegue(withIdentifier: "startingLocationSearchSegue", sender: sender)
    }
    
    @IBAction func destinationLctnTxtFldEditingBegin(_ sender: Any) {
        destinationLocationTextField.endEditing(true)
        performSegue(withIdentifier: "destinationLocationSearchSegue", sender: sender)
    }
}
