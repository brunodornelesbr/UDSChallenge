//
//  Profile.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ProfileViewModel: BaseViewModel {
var email = BehaviorRelay<String>(value: "")
var name = BehaviorRelay<String>(value: "")
var userManager = UserManager()
    override init(router: Router) {
        super.init(router: router)
        name.accept(userManager.getUserName())
        email.accept(userManager.getEmail())
    }
    
    func logout() {
        userManager.logout()
        router?.logout()
    }
}
