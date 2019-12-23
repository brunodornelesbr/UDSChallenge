//
//  AskForPasswordViewModel.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class AskForPasswordViewModel: BaseViewModel {
     var email = BehaviorRelay<String>(value : "")
    var didAskForPassword = BehaviorRelay<Bool>(value: false)
    var network = NetworkMock()
     weak var router : Router?
       init(router : Router) {
            super.init()
           self.router = router
    }
    
    func send() {
        guard email.value != "" else {
            showError(error: "Digite o email")
            return
        }
        network.askForPassword(email: email.value) {
            [weak self] didAskForPassword in
            if didAskForPassword {
                self?.didAskForPassword.accept(true)
            } else {
                self?.showError(error: "Não foi possivel requisitar a senha.")
            }
        }
        
    }
    
    func  didAskigForPassword() {
        router?.goBack()
    }
}
