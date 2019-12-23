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
        if userManager.isUserLoggedIn(){
            routeToMain()
        } else {
           routeToLogin()
        }
    }
    func routeToLogin() {
           let loginVc = instantiateInitialVCFromStoryboard(storyboardName: "Login") as! LoginViewController
        loginVc.model = LoginViewModel(router: self)
        addViewControllerToNavigation(vc: loginVc)
       }
    func routeToMain() {
        let mainVc = instantiateInitialVCFromStoryboard(storyboardName: "Main") as! UITabBarController
        
        let rulingCreation = instantiateInitialVCFromStoryboard(storyboardName: "RulingCreation") as! RulingCreationViewController
        rulingCreation.model = RulingCreationViewModel(router: self)
        
        let profile = instantiateInitialVCFromStoryboard(storyboardName: "Profile") as! ProfileViewController
        profile.model = ProfileViewModel(router: self)
        
        mainVc.setViewControllers([rulingCreation,profile], animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        addViewControllerToNavigation(vc: mainVc)
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
    
    func logout() {
        navigationController.popToRootViewController(animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
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
