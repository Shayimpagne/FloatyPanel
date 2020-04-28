//
//  ViewController.swift
//  FloatyPanel_Example
//
//  Created by Emir Shayymov on 4/28/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func presentPanel(_ sender: Any) {
        let viewController = CustomFloatyPanelViewController()
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: nil)
    }
}
