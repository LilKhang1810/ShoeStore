//
//  ShoeModel.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 17/12/2023.
//

import Foundation
import SwiftUI

struct Shoe: Codable, Hashable{
    var id : String
    var brand: String
    var description: String
    var img_url:String
    var name: String
    var price: Double
    var rating: String
    var status: String
    var type: String
    var quantity:Int = 1
}
