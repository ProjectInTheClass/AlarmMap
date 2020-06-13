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
        // 0611
        if let startingLocationText = startingLocation?.name {
            if startingLocation!.latitude >= 0.0 && startingLocation!.longitude >= 0.0 {
                startingLocationTextField.text = startingLocationText
            }
        }
        
        destinationLocationTextField.text = ""
        // 0611
        if let destinationLocationText = destinationLocation?.name {
            if destinationLocation!.latitude >= 0.0 && destinationLocation!.longitude >= 0.0 {
                destinationLocationTextField.text = destinationLocationText
            }
        }
        
        self.backgroundView.layer.addBorder([.bottom], color: .systemGray4, width: 0.5)
    
        startingLocationTextField.backgroundColor = .systemGray6
        destinationLocationTextField.backgroundColor = .systemGray6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("searchbars뷰")
        // 0611
        print(destinationLocation!.name)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let locationSearchParentsVC = segue.destination as! LocationSearchParentsViewController
        
        if (segue.identifier == "startingLocationSearchSegue"){
            locationSearchParentsVC.isStartingLocationSearching = true
            locationSearchParentsVC.searchingLocation = startingLocation
        }
        else {
            locationSearchParentsVC.isStartingLocationSearching = false
            locationSearchParentsVC.searchingLocation = destinationLocation
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
