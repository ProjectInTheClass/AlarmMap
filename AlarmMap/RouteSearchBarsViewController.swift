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
    
    override func viewWillAppear(_ animated: Bool) {
        print("searchbars뷰")
        print(destinationLocation!.title)
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
