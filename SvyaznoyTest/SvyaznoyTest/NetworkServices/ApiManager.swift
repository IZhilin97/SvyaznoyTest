//
//  ApiManager.swift
//  SvyaznoyTest
//
//  Created by Иван Жилин on 13.04.2022.
//

import Foundation

enum ApiMethod: String {
    case getList = "/getList"
    case getDetailedInfo = "/getDetailedInfo"
}

class ApiManager {
    private let baseUrl = "BASE_URL"
    
    static func iniciate(request: ApiMethod, complition: @escaping (_ isSuccess: Bool, _ responseData: Data) -> Void){
        DispatchQueue.global().async {
            print("Запрос пошел")
            sleep(5)
            
            let isNoError: Bool = true
            var sampleData = ""
            
            if isNoError {
                switch request {
                case .getList:
                    sampleData = "{\"list\": [\"one\", \"two\", \"three\"]}"
                    break
                case .getDetailedInfo:
                    sampleData = "{\"title\": \"Sample Title\", \"subtitle\": \"Sample Subtitle\"}"
                    break
                }
            }else{
                sampleData = "{\"code\": \"401\"}"
            }
            
            let data = Data(sampleData.utf8)
            complition(isNoError, data)
        }
    }
    
    static func makeErrorLogRequest(data: Data, screenTitle: String){
        print("Error request")
        //Do http request to log serivce
    }
}
