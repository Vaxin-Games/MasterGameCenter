//
//  ViewController.swift
//  MasterGameCenter
//
//  Created by Pierre Garant on 2020-11-07.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Activate Game Center login screen
        GameCenterHelper.helper.viewController = self

    }

    @IBAction func click() {
        print ("Ne sert à rien...")
    }
}

