//
//  UserManager.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit

class UserManager {
    var network = NetworkMock()
    enum keys : String {
        case userLogged
        case email
        case password
        case name
        case rulingList
    }
    
    func isUserLoggedIn()->Bool {
        return UserDefaults.standard.bool(forKey: UserManager.keys.userLogged.rawValue)
    }
    
   private func setUserLoggedIn(logged : Bool) {
        UserDefaults.standard.set(logged, forKey: UserManager.keys.userLogged.rawValue)
    }
    
    func logout() {
        setUserLoggedIn(logged: false)
        wipeRuling()
    }
    
    func getUserName()->String{
       return UserDefaults.standard.string(forKey: UserManager.keys.name.rawValue) ?? ""
    }
    func getEmail()->String{
        return UserDefaults.standard.string(forKey: UserManager.keys.email.rawValue) ?? ""
    }
    
    func saveRuling(ruling : Ruling) {
        var rulings = getRulingList()
        rulings.append(ruling)
       let data = try? JSONEncoder().encode(rulings)
          UserDefaults.standard.set(data, forKey: UserManager.keys.rulingList.rawValue)
    }
    
    func getRulingList() -> [Ruling] {
       
        guard let rulingData = UserDefaults.standard.data(forKey: UserManager.keys.rulingList.rawValue) else { return [] }
           return (try? JSONDecoder().decode([Ruling].self, from: rulingData)) ?? []
        
    }
    
    func wipeRuling() {
        let rulings = [Ruling]()
        let data = try? JSONEncoder().encode(rulings)
                UserDefaults.standard.set(data, forKey: UserManager.keys.rulingList.rawValue)
    }
    func logIn(email : String,password : String, completion : @escaping ((Bool)->())) {
        network.logIn(email: email, password: password){
            email,name,password in
            
            guard let email = email , let name = name , let password = password else {completion(false)
                return}
            UserDefaults.standard.set(email, forKey: UserManager.keys.email.rawValue)
            UserDefaults.standard.set(password, forKey: UserManager.keys.password.rawValue)
            UserDefaults.standard.set(name,forKey: UserManager.keys.name.rawValue)
            self.setUserLoggedIn(logged: true)
            
             completion(true)
        }
       
        
       
    }
    
    func register(email : String, password: String, name : String , completion : @escaping (Bool)->()) {
        network.register(email: email, password: password, name: name){
            value in
            completion(value)
            return
        }
    }
}

