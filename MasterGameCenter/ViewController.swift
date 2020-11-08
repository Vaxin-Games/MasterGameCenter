//
//  ViewController.swift
//  MasterGameCenter
//
//  Created by Pierre Garant on 2020-11-07.
//

import UIKit
import GameKit

class ViewController: UIViewController {
    
    var GCVviewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Activate Game Center login screen with GameCenterHelper
        GameCenterHelper.helper.viewController = self
        
        //Activate Game Center with Apple's Code
        /*
        GKLocalPlayer.local.authenticateHandler = {
            viewController,error in
                let isGameCenterReady = (viewController == nil) && (error == nil)
            if isGameCenterReady == true {
                print("Let's do this!")
            }
            if let viewController = viewController{
                present(viewController, animated: true)
            }
        }
        */
        
        // Place the access point on the upper-left corner
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.showHighlights = true
        GKAccessPoint.shared.isActive = true
    }

    @IBAction func click() {
               
        // Toggle Access Point
        GKAccessPoint.shared.isActive = !GKAccessPoint.shared.isActive
        
    }
    
    @IBAction func notify(){
        let message:String = "Player \(GKLocalPlayer.local.displayName): \(GKLocalPlayer.local.isAuthenticated)"
        GKNotificationBanner.show(withTitle: "Master Game Center", message: message, completionHandler: nil)
    }
    
    @IBAction func createGame()
    {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 4
        request.inviteMessage = "Master Game Center match request test"
        request.recipientResponseHandler = { player, response in
            self.updateUI(for: player, accepted: response == .accepted)
        }
        let vc = GKTurnBasedMatchmakerViewController(matchRequest: request)
        present(vc, animated: true)
    }
    
    @IBAction func shareData(){
        // Local player profile

        let profileVC = GKGameCenterViewController(state: .localPlayerProfile)
        //profileVC.gameCenterDelegate = self
        present(profileVC, animated: true, completion: nil)
    }
    
    func updateUI(for player: GKPlayer, accepted: Bool) {
        // update your UI here
        print ("Update UI...")
    }
    
}


