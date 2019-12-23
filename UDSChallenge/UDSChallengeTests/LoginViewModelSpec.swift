//
//  UDSChallengeTests.swift
//  UDSChallengeTests
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import Quick
import Nimble
@testable import UDSChallenge

class LoginViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("LoginViewModel"){
            context("user did not inform email and password"){
                let loginModel = LoginViewModel(router: Router())
                it("should show a error when user try to login") {
                    loginModel.doLogin()
                    expect(loginModel.errorToBeShow.value).notTo(equal(""))
                }
            }
            context("user did  inform email and did not inform password"){
                let loginModel = LoginViewModel(router: Router())
                loginModel.email.accept("bruno@bruno.com")
                it("should show a error when user try to login") {
                    loginModel.doLogin()
                    expect(loginModel.errorToBeShow.value).notTo(equal(""))
                }
                
            }
            context("user did  inform email and did inform password"){
                let routerStub = RouterStub()
                let loginModel = LoginViewModel(router: routerStub)
                loginModel.email.accept("bruno@bruno.com")
                loginModel.password.accept("bruno")
                let userManager = UserManager()
                userManager.register(email: "bruno@bruno.com", password: "bruno", name: "bruno"){ _ in}
                it("should show a error when user try to login") {
                    loginModel.doLogin()
                    expect(routerStub.didCallRouteToLogin).toEventually(equal(1))
                }
                
            }
            
            
        }
        
    }
}
