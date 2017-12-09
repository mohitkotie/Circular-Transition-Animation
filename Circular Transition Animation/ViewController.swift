//
//  ViewController.swift
//  Circular Transition Animation
//
//  Created by mohit kotie on 09/12/17.
//  Copyright © 2017 mohit kotie mohit. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var menuButton: UIButton!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let seconVC = segue.destination as! SecondViewController
        seconVC.transitioningDelegate = self
        seconVC.modalPresentationStyle = .custom
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        return transition    }


}

