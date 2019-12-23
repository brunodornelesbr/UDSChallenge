//
//  LoginViewModel.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class LoginViewModel : BaseViewModel {
    var email = BehaviorRelay<String>(value : "")
    var password = BehaviorRelay<String>(value : "")
    var userManager = UserManager()

    func doLogin() {
        guard email.value != "" && password.value != "" else {
            self.showError(error: "Digite o email e senha")
            return
        }
        
        userManager.logIn(email: email.value, password: password.value){[weak self] didLogin in
            if didLogin {
                self?.router?.routeToMain()
            } else {
                self?.showError(error: "Não foi possivel fazer o login")
            }
        }
    }
    
    func doRecoverPassword() {
        self.router?.routeToAskForPassword()
    }
    
    func doRegister() {
        self.router?.routeToSignUp()
    }
    
    
}
