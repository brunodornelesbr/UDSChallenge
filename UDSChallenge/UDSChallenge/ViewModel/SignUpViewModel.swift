//
//  SignUpViewModel.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class SignUpViewModel : BaseViewModel {
    var email = BehaviorRelay<String>(value : "")
    var password = BehaviorRelay<String>(value : "")
    var name = BehaviorRelay<String>(value : "")
    var didRegister = BehaviorRelay<Bool>(value: false)
    var userManager = UserManager()
       weak var router : Router?
       init(router : Router) {
            super.init()
           self.router = router
    }
    
    func register() {
        guard email.value != "" && password.value != "" && name.value != "" else {
            showError(error: "Digite todos os campos")
            return
        }
        userManager.register(email: email.value, password: password.value, name: name.value) { [weak self] didRegister in
            if didRegister {
                self?.didRegister.accept(true)
            } else {
                self?.showError(error: "Não foi possivel cadastrar")
            }
            
        }
    }
    
    func didFinishRegister() {
        self.router?.goBack()
    }
}
