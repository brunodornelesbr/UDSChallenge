//
//  SignUpViewController.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    var model : SignUpViewModel!
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        bindToShowError(viewModel: model, bag: bag)
        // Do any additional setup after loading the view.
    }
    
    func setupRx() {
          (self.passwordTextField.rx.text.orEmpty <-> model.password).disposed(by: bag)
          (self.emailTextField.rx.text.orEmpty <-> model.email).disposed(by: bag)
          (self.nameTextField.rx.text.orEmpty <-> model.name).disposed(by: bag)
        
        self.registerButton.rx.tap.subscribe(onNext : {
            [weak self] _ in
            self?.model.register()
            }).disposed(by: bag)
       
        self.model.didRegister.filter{return $0}.subscribe(onNext : {[weak self] value in
            let alert = UIAlertController(title: "Informação", message: "Cadastro concluido com sucesso.",preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                        self?.model.didFinishRegister()
                              }))
                       self?.present(alert, animated: true, completion: nil)

            }).disposed(by: bag)

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
