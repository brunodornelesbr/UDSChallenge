//
//  AskForPasswordViewController.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class AskForPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    var model : AskForPasswordViewModel!
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        bindToShowError(viewModel: model, bag: bag)
        // Do any additional setup after loading the view.
    }
    
    func setupRx() {
         (self.emailTextField.rx.text.orEmpty <-> model.email).disposed(by: bag)
        self.sendButton.rx.tap.subscribe(onNext : {
                   [weak self] _ in
                   self?.model.send()
                   }).disposed(by: bag)
        
        self.model.didAskForPassword.filter{return $0}.subscribe(onNext : {[weak self] value in
                   let alert = UIAlertController(title: "Informação", message: "Email de recuperação enviado.",preferredStyle: UIAlertController.Style.alert)
                              alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                               self?.model.didAskigForPassword()
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
