//
//  SecondViewController.swift
//  Circular Transition Animation
//
//  Created by mohit kotie on 09/12/17.
//  Copyright © 2017 mohit kotie mohit. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2
    }
    @IBAction func dismissSecondVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}
