//
//  RouterSpec.swift
//  UDSChallengeTests
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import Quick
import Nimble
@testable import UDSChallenge

class RouterSpec: QuickSpec {
    override func spec() {
    describe("Router"){
        context("when initializing and user is not logged in"){
            let router = RouterStub()
            it("should show login") {
                expect(router.didCallRouteToLogin).to(equal(1))
            }
        }
        
        context("when initializing and user is logged in"){
            let userManager = UserManager()
            let email = "bruno@bruno.com"
            let password = "bruno"
            let name = "bruno"
            userManager.register(email: email, password: password, name: name){ _ in
                userManager.logIn(email: email, password: password){ _ in}
            }
           
                 let router = RouterStub()
            
                 it("should show login") {
                     expect(router.didCallRouteToLogin).toEventually(equal(1))
                 }
             }
        }
}
}
