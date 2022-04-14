//
//  ViewController.swift
//  SvyaznoyTest
//
//  Created by Иван Жилин on 13.04.2022.
//

import UIKit

protocol LoadViewResponder: AnyObject {
    func loadViewTriggered()
}

protocol TableDataChangesResponder: AnyObject {
    func tableDataChanged(to: ElementsData?)
}

protocol TableListCellClickResponder: AnyObject {
    func cellClicked(with data: String)
}

class TableViewController: UIViewController, TableDataChangesResponder, ViewControllerPresentResponder, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var loadViewResponder: LoadViewResponder?
    weak var tableListCellClickResponder: TableListCellClickResponder?
    var dataList: ElementsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
    }

    override func loadView() {
        loadViewResponder?.loadViewTriggered()
        super.loadView()
    }
    
    func tableDataChanged(to: ElementsData?) {
        dataList = to
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func present(view controller: UIViewController) {
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath)
        cell.textLabel!.text = dataList?.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = dataList?.list[indexPath.row] {
            tableListCellClickResponder?.cellClicked(with: data)
        }
    }
}
