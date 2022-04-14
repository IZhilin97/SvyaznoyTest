//
//  TableModel.swift
//  SvyaznoyTest
//
//  Created by Иван Жилин on 13.04.2022.
//

import Foundation

struct ElementsData: Codable {
    var list: [String]
}

protocol ApiGetListResponder: AnyObject {
    func handleGetListResponse(with data: Data, complition: @escaping (_ data: ElementsData?) -> Void)
}

protocol ApiGetDetailResponder: AnyObject {
    func handleGetDetailResponse(with data: Data, complition: @escaping (_ data: ElementDetail?) -> Void)
}

class TableModel: ApiGetListResponder {
    func handleGetListResponse(with data: Data, complition: @escaping (_ data: ElementsData?) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("Jsone got: ", String(data: data, encoding: String.Encoding.utf8)!)
        do {
            let data = try decoder.decode(ElementsData.self, from: data)
            elements = data.list
            complition(data)
        } catch {
            complition(nil)
            return
        }
    }
    
    var elements: [String] = []
}
