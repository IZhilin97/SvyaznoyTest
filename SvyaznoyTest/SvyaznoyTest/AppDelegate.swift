//
//  AppDelegate.swift
//  SvyaznoyTest
//
//  Created by Иван Жилин on 13.04.2022.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureContainer(container)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window = window
        window.makeKeyAndVisible()
        window.rootViewController = container.resolve(TableViewController.self)
        
        return true
    }

    func configureContainer(_ container: Container){
        container.register(TableModel.self) { (_) -> TableModel in
            return TableModel()
        }
        
        container.register(TableViewModel.self) { (_) -> TableViewModel in
            return TableViewModel()
        }.initCompleted { (r, c: TableViewModel) in
            c.apiListLoadedResponder = r.resolve(TableModel.self)
            c.apiDetailLoadedResponder = r.resolve(DetailModel.self)
            c.tableDataChangesResponder = r.resolve(TableViewController.self)
            c.viewControllerPresentResponder = r.resolve(TableViewController.self)
            c.detailDataChangedResponder = r.resolve(DetailViewController.self)
        }
        
        container.register(TableViewController.self) { (_) -> TableViewController in
            return UIStoryboard(name: "TableStoryboard", bundle: nil).instantiateViewController(withIdentifier: String(describing: TableViewController.self)) as! TableViewController
        }.initCompleted { (r, c: TableViewController) in
            c.loadViewResponder = r.resolve(TableViewModel.self)
            c.tableListCellClickResponder = r.resolve(TableViewModel.self)
        }
        
        container.register(DetailViewController.self) { (_) -> DetailViewController in
            return UIStoryboard(name: "DetailStoryboard", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        }.initCompleted { (r, c: DetailViewController) in
            
        }
        
        container.register(DetailModel.self) { (_) -> DetailModel in
            return DetailModel()
        }
        
        container.register(DetailViewModel.self) { (_) -> DetailViewModel in
            return DetailViewModel()
        }.initCompleted { (r, c: DetailViewModel) in
            
        }
    }
}

