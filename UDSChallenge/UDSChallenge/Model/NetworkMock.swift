//
//  NetworkMock.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit

class NetworkMock {
    enum keys : String {
        case mockEmails
        case mockPassword
        case mockName
    }
    func logIn(email : String, password : String, completion : @escaping(String?,String?,String?)->()) {
        let emails = getListDictionaryOfEmailsFromUserDefaults()
        
        if let emailObject = emails[email] as? [String: String] {
            completion(email,emailObject[NetworkMock.keys.mockPassword.rawValue],emailObject[NetworkMock.keys.mockName.rawValue])
            return
        } else {
            completion(nil,nil,nil)
            return
        }
    }
    
    func register(email: String,password : String,name : String, completion : @escaping(Bool)->()) {
        var  emails = getListDictionaryOfEmailsFromUserDefaults()
        
        if (emails[email] as? [String: String]) != nil {
            completion(false)
            return
        } else {
            let dicObj = [NetworkMock.keys.mockName.rawValue : name,
                          NetworkMock.keys.mockPassword.rawValue :password]
            emails[email] = dicObj
            UserDefaults.standard.set(emails, forKey: NetworkMock.keys.mockEmails.rawValue)
            completion(true)
            return
        }
        
        
    }
    
    func askForPassword(email: String,completion : @escaping(Bool)->()) {
        completion(true)
        return
    }
    
    func getListDictionaryOfEmailsFromUserDefaults()->[String:Any] {
        let emails = UserDefaults.standard.dictionary(forKey: NetworkMock.keys.mockEmails.rawValue)
        return emails ?? [:]
    }
}
