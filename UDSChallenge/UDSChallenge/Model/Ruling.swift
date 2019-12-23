//
//  Ruling.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit

class Ruling : Codable,Equatable{
var title = ""
var description = ""
var author = ""
var details = ""
var open = 0
    
    static func == (lhs: Ruling, rhs: Ruling) -> Bool {
          return (lhs.title == rhs.title) && (lhs.details == rhs.details) && (lhs.author == rhs.author) && (lhs.description == rhs.description)
      }
      
}
