/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import GameKit

final class GameCenterHelper: NSObject {
  typealias CompletionBlock = (Error?) -> Void
    
    // 1
    static let helper = GameCenterHelper()

    // 2
    var viewController: UIViewController?
    
    // Connect to Game Center when class is created
    override init() {
        super.init()
      
        //Game Center authentication
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            if GKLocalPlayer.local.isAuthenticated {

                // Notify App
                NotificationCenter.default
                  .post(name: .authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)

                // resume
                print("Authenticated to Game Center!")
            } else if let vc = gcAuthVC {
                self.viewController?.present(vc, animated: true)
            }
            else {
                print("Error authentication to GameCenter: " +
                "\(error?.localizedDescription ?? "none")")
            }
        }
        // Other init procedures
    }
    // Other class functions
    /*
    func presentMatchmaker() {
      // 1
      guard GKLocalPlayer.local.isAuthenticated else {
        return
      }
      
      // 2
      let request = GKMatchRequest()
      
      request.minPlayers = 2
      request.maxPlayers = 2
      // 3
      request.inviteMessage = "Would you like to play Nine Knights?"
      
      // 4
      let vc = GKTurnBasedMatchmakerViewController(matchRequest: request)
      GameCenterHelper.helper.presentMatchmaker()
      viewController?.present(vc, animated: true)
    }
     */
}

//Notify app of Game Center connection
extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}

extension GameCenterHelper: GKTurnBasedMatchmakerViewControllerDelegate {
  func turnBasedMatchmakerViewControllerWasCancelled(
    _ viewController: GKTurnBasedMatchmakerViewController) {
      viewController.dismiss(animated: true)
  }
  
  func turnBasedMatchmakerViewController(
    _ viewController: GKTurnBasedMatchmakerViewController,
    didFailWithError error: Error) {
      print("Matchmaker vc did fail with error: \(error.localizedDescription).")
  }
}
