//
//  SignInViewController.swift
//  Savethedate
//
//  Created by arun soorya on 12/04/17.
//  Copyright © 2017 arun soorya. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth


class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!){
        print("Error: \(error)")
    }
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!){
    
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!){
    
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let err = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if let error = error {
                // ...
                return
            }
        }
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
