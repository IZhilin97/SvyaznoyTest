//
//  DetailModel.swift
//  SvyaznoyTest
//
//  Created by Иван Жилин on 14.04.2022.
//

import Foundation

struct ElementDetail: Codable {
    var title: String
    var subtitle: String
}

class DetailModel: ApiGetDetailResponder {
    func handleGetDetailResponse(with data: Data, complition: @escaping (ElementDetail?) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("Jsone got: ", String(data: data, encoding: String.Encoding.utf8)!)
        do {
            let data = try decoder.decode(ElementDetail.self, from: data)
            title = data.title
            subtitle = data.subtitle
            complition(data)
        } catch {
            complition(nil)
            return
        }
    }
    
    var title: String = ""
    var subtitle: String = ""
}
