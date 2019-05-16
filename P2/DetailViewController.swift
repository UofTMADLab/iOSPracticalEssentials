//
//  DetailViewController.swift
//  PracticalPrototpye
//
//  Created by Mike Spears on 2019-05-13.
//  Copyright © 2019 Mike Spears. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var mapLocation: MapLocation?
    var mapAPI: MapAPI!
    
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = mapLocation?.title
        subtitleTextField.text = mapLocation?.subtitle

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if let validLocation = self.mapLocation {
            validLocation.title = self.titleTextField.text
            validLocation.subtitle = self.subtitleTextField.text
            mapAPI.updateLocation(location: validLocation)
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        if let validLocation = self.mapLocation {
            mapAPI.deleteLocation(location: validLocation)
            self.mapLocation = nil
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
