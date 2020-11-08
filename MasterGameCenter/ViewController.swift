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
        // Do any additional setup after loading the view.
        
        //Activate Game Center login screen with GameCenterHelper
        GameCenterHelper.helper.viewController = self
        print ("Connecting to Game Center")

/*
        //Activate Game Center with Apple's Code
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            if let gcAuthVC = gcAuthVC {
                
                print("Present the view controller so the player can sign in")
                return
            }
            if error != nil {
                print("Player could not be authenticated")
                // Disable Game Center in the game
                return
            }
            
            // Player was successfully authenticated
            // Check if there are any player restrictions before starting the game
                    
            if GKLocalPlayer.local.isUnderage {
                // Hide explicit game content
            }

            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // Disable multiplayer game features
            }

            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                // Disable in game communication UI
            }
            
            // Perform any other configurations as needed (for example, access point)
        }
*/
        // Place the access point on the upper-left corner
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.showHighlights = true
        GKAccessPoint.shared.isActive = true
    }

    @IBAction func click() {
               
        // Test GK var
        var message:String = ""

        message = "Player \(GKLocalPlayer.local.displayName) authetication status: \(GKLocalPlayer.local.isAuthenticated)"
        print (message)
        
        // Toggle Access Point
        GKAccessPoint.shared.isActive = !GKAccessPoint.shared.isActive
        
        // Send Notification
        GKNotificationBanner.show(withTitle: "Master Game Center", message: "\(message)", completionHandler: nil)
        
        // Match Request
        invite()
    }
    
    func invite() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 4
        request.inviteMessage = "Master Game Center match request test"
        request.recipientResponseHandler = { player, response in
            self.updateUI(for: player, accepted: response == .accepted)
        }
    }

    func updateUI(for player: GKPlayer, accepted: Bool) {
        // update your UI here
    }
    
}

