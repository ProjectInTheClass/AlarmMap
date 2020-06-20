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
    
    var isStartingLocationSearching = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundView.layer.addBorder([.bottom], color: .systemGray4, width: 0.5)
    
        startingLocationTextField.backgroundColor = .systemGray6
        destinationLocationTextField.backgroundColor = .systemGray6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //startingLocationTextField.text = startingPoint!.location.name
        //destinationLocationTextField.text = destinationPoint!.location.name
        startingLocationTextField.text = userSelectedStartingPoint.location.name
        destinationLocationTextField.text = userSelectedDestinationPoint.location.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let locationSearchParentsVC = segue.destination as! LocationSearchParentsViewController
        
        if(isStartingLocationSearching){
            locationSearchParentsVC.isStartingLocationSearching = true
            //locationSearchParentsVC.searchingPoint = self.startingPoint
        }
        else{
            locationSearchParentsVC.isStartingLocationSearching = false
            //locationSearchParentsVC.searchingPoint = self.destinationPoint
        }
    }

    @IBAction func staringLctnTxtFldEditingBegin(_ sender: Any) {
        startingLocationTextField.endEditing(true)
        isStartingLocationSearching = true
        performSegue(withIdentifier: "locationSearchSegue", sender: sender)
    }
    
    @IBAction func destinationLctnTxtFldEditingBegin(_ sender: Any) {
        destinationLocationTextField.endEditing(true)
        isStartingLocationSearching = false
        performSegue(withIdentifier: "locationSearchSegue", sender: sender)
    }
}
