//
//  LoginViewController.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var recoverPassword: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var model : LoginViewModel!
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        bindToShowError(viewModel: model, bag: bag)
        // Do any additional setup after loading the view.
    }
    
    func setupRx() {
        loginButton.rx.tap.subscribe(onNext : { [weak self] _ in
            self?.model.doLogin()
            }).disposed(by: bag)
        recoverPassword.rx.tap.subscribe(onNext : { [weak self] _ in
        self?.model.doRecoverPassword()
        }).disposed(by: bag)
        signUpButton.rx.tap.subscribe(onNext : {
            [weak self] _ in
            self?.model.doRegister()
            }).disposed(by: bag)
            
        (self.emailTextField.rx.text.orEmpty <-> model.email).disposed(by: bag)
        (self.passwordTextField.rx.text.orEmpty <-> model.password).disposed(by: bag)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
infix operator <->

@discardableResult func <-><T>(property: ControlProperty<T>, variable: BehaviorRelay<T>) -> Disposable {
    let variableToProperty = variable.asObservable()
        .bind(to: property)

    let propertyToVariable = property
        .subscribe(
            onNext: { variable.accept($0) },
            onCompleted: { variableToProperty.dispose() }
    )

    return Disposables.create(variableToProperty, propertyToVariable)
}
