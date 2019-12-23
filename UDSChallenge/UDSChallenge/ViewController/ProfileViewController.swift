//
//  ProfileViewController.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ProfileViewController: UIViewController {
    var model : ProfileViewModel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        // Do any additional setup after loading the view.
    }
    
    func setupRx() {
        model.name.asObservable().subscribe(onNext : {[weak self] value in
            self?.nameLabel.text = value
                   }).disposed(by: bag)
        model.email.asObservable().subscribe(onNext : {[weak self] value in
                self?.emailLabel.text = value
                       }).disposed(by: bag)
     
        logoutButton.rx.tap.subscribe(onNext : {[weak self] _ in
            self?.model.logout()
        }).disposed(by:bag)
        

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
