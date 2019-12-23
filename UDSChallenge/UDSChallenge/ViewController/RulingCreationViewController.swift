//
//  RulingCreationViewController.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class RulingCreationViewController: UIViewController {
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    var model : RulingCreationViewModel!
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTextView.layer.cornerRadius = 5
        detailsTextView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        detailsTextView.layer.borderWidth = 0.7
        detailsTextView.clipsToBounds = true
        setupRx()
        // Do any additional setup after loading the view.
    }
    
    func setupRx() {
        (self.detailsTextView.rx.text.orEmpty <-> model.details).disposed(by: bag)
        (self.titleTextField.rx.text.orEmpty <-> model.title).disposed(by: bag)
        (self.descriptionTextField.rx.text.orEmpty <-> model.description).disposed(by: bag)
        (self.authorTextField.rx.text.orEmpty <-> model.author).disposed(by: bag)
     
        model.finishAvailable.subscribe(onNext : {[weak self] value in
            self?.finishButton.isEnabled = value
            }).disposed(by: bag)
        
        finishButton.rx.tap.subscribe(onNext : {[weak self] _ in
            self?.model.save()
        }).disposed(by:bag)
        
        self.model.successAdding.asObservable().filter{return $0}.subscribe(onNext : {[weak self] _ in
            let alert = UIAlertController(title: "Informação", message: "Pauta adicionada.",preferredStyle: UIAlertController.Style.alert)
                                         alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                                          self?.model.didAdd()
                                                }))
                                         self?.present(alert, animated: true, completion: nil)
         
        })

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
