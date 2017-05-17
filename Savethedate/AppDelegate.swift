//
//  AppDelegate.swift
//  Savethedate
//
//  Created by arun soorya on 26/03/17.
//  Copyright © 2017 arun soorya. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    var homeViewController:HomeViewController!
    var navController:UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure();
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
      // GIDSignIn.sharedInstance().signIn()
        goToSignUp()
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print(error.localizedDescription)
            // self.goToSignUp()
            return
        }
        print("User signed into google")
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            print("User Signed Into Firebase");
            //self.goToHomeScreen()
            self.homeViewController = HomeViewController(nibName:"HomeViewController" , bundle:nil);
            self.navController!.pushViewController(self.homeViewController, animated: true);
        })
        
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
   
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func goToHomeScreen(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let signInVC = HomeViewController(nibName:"HomeViewController" , bundle:nil);
        window?.rootViewController = signInVC;
        window?.makeKeyAndVisible()
    }
    func goToSignUp(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let signInVC = SignInViewController(nibName:"SignInViewController" , bundle:nil);

        navController = UINavigationController(rootViewController: signInVC)
        window?.rootViewController = navController;
        window?.makeKeyAndVisible()
    }
    
    
}

