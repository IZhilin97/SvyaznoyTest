//
//  TableViewModel.swift
//  SvyaznoyTest
//
//  Created by Иван Жилин on 13.04.2022.
//

import Foundation
import UIKit

protocol ViewControllerPresentResponder: AnyObject {
    func present(view controller: UIViewController)
}

protocol DetailDataChangesResponder: AnyObject {
    func tableDataChanged(to data: ElementDetail?)
}

class TableViewModel: LoadViewResponder, TableListCellClickResponder {
    var apiListLoadedResponder: ApiGetListResponder?
    var apiDetailLoadedResponder: ApiGetDetailResponder?
    weak var tableDataChangesResponder: TableDataChangesResponder?
    weak var viewControllerPresentResponder: ViewControllerPresentResponder?
    var detailDataChangedResponder: DetailDataChangesResponder?
    
    func loadViewTriggered() {
        ApiManager.iniciate(request: .getList, complition: { [weak self] isSuccess, responseData in
            let data = responseData
            print("data loaded: ", data)
            if isSuccess {
                self?.apiListLoadedResponder?.handleGetListResponse(with: data, complition: { [weak self] data in
                    self?.tableDataChangesResponder?.tableDataChanged(to: data)
                })
            }else{
                ApiManager.makeErrorLogRequest(data: data, screenTitle: "TableView")
            }
        })
    }
    
    func cellClicked(with data: String) {
        let controllerToPresent = (UIApplication.shared.delegate as! AppDelegate).container.resolve(DetailViewController.self)!
        viewControllerPresentResponder?.present(view: controllerToPresent)
        
        ApiManager.iniciate(request: .getDetailedInfo, complition: { [weak self] isSuccess, data in
            self?.apiDetailLoadedResponder?.handleGetDetailResponse(with: data, complition: {  [weak self] data in
                DispatchQueue.main.async{  [weak self] in
                    controllerToPresent.subtitleLabel.text = data?.subtitle
                    controllerToPresent.titleLabel.text = data?.title
                    self?.detailDataChangedResponder?.tableDataChanged(to: data)
                }
            })
        })
    }
}
