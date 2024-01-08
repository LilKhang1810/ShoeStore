//
//  Extension.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 08/01/2024.
//

import Foundation

extension Encodable{
    func asDictionary() -> [String: Any]{
        guard let data = try? JSONEncoder().encode(self) else{
            return [:]
        }
        do{
            let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
            return json ?? [:]
        } catch{
            return[:]
        }
    }
}
