//
//  Router.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit

class Router {
    var navigationController : UINavigationController
    init(){
           navigationController = UINavigationController()
            let userManager = UserManager()
//        if userManager.isUserLoggedIn(){
//            routeToMain()
//        } else {
//           routeToLogin()
//        }
        
        routeToLogin()
    }
    func routeToLogin() {
           let loginVc = instantiateInitialVCFromStoryboard(storyboardName: "Login") as! LoginViewController
        loginVc.model = LoginViewModel(router: self)
        addViewControllerToNavigation(vc: loginVc)
       }
    func routeToMain() {
        
    }
    
    func routeToAskForPassword() {
        let askPassword = instantiateInitialVCFromStoryboard(storyboardName: "AskForPassword") as! AskForPasswordViewController
               askPassword.model = AskForPasswordViewModel(router: self)
               addViewControllerToNavigation(vc: askPassword)
    }
    
    func routeToSignUp() {
        let registerVc = instantiateInitialVCFromStoryboard(storyboardName: "SignUp") as! SignUpViewController
        registerVc.model = SignUpViewModel(router: self)
        addViewControllerToNavigation(vc: registerVc)
    }
    //MARK:- Helper methods
      func addViewControllerToNavigation(vc : UIViewController) {
          navigationController.pushViewController(vc, animated: true)
      }
      
      func instantiateInitialVCFromStoryboard(storyboardName : String) -> UIViewController {
          let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
          let vc = storyboard.instantiateInitialViewController()
          guard let existingVc = vc else {fatalError("Initial view controller not set in storyboard \(storyboardName)")
          }
          return existingVc
      }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
