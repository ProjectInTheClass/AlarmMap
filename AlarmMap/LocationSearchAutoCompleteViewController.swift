//
//  LocationSearchAutoCompleteViewController.swift
//  AlarmMap
//
//  Created by SeoungJun Oh on 2020/06/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import GooglePlaces

class LocationSearchAutoCompleteViewController: UIViewController {

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var isStartingLocationSearching = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults.standard.set(["ko"], forKey: "AppleLanguages")

        // Do any additional setup after loading the view.
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController

        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar

        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true

        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }

}

extension LocationSearchAutoCompleteViewController: GMSAutocompleteResultsViewControllerDelegate {
    
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didAutocompleteWith place: GMSPlace) {
    searchController?.isActive = false
    
    if(isStartingLocationSearching){
        userSelectedStartingPoint.location.name = place.name!
        userSelectedStartingPoint.location.latitude = place.coordinate.latitude
        userSelectedStartingPoint.location.longitude = place.coordinate.longitude
    }
    else{
        userSelectedDestinationPoint.location.name = place.name!
        userSelectedDestinationPoint.location.latitude = place.coordinate.latitude
        userSelectedDestinationPoint.location.longitude = place.coordinate.longitude
    }
    
    searchController?.dismiss(animated: false, completion: {
        self.performSegue(withIdentifier: "unwindRouteSearchingParentsVCSegue", sender: self)
    })
  }

  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
