//
//  RouterStub.swift
//  UDSChallengeTests
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
@testable import UDSChallenge
class RouterStub: Router {
    var didCallRouteToLogin = 0
    var didCallRouteToMain = 0
    override func routeToLogin() {
        didCallRouteToLogin = didCallRouteToLogin + 1
        super.routeToLogin()
    }
    
    override func routeToMain() {
        didCallRouteToMain = didCallRouteToMain + 1
        super.routeToMain()
    }
}
