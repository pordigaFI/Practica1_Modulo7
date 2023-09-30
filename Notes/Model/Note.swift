//
//  Note.swift
//  Notes
//
//  Created by Porfirio Diaz on 25/09/23.
//

import Foundation

//Esta estructura debe cumplir con los protocolos Decodable y uncodable
struct Note : Codable{
    var title : String
    var content : String
    var date : Date
}
