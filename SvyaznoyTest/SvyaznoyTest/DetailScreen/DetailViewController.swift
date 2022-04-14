//
//  DetailViewController.swift
//  SvyaznoyTest
//
//  Created by Иван Жилин on 14.04.2022.
//

import UIKit

class DetailViewController: UIViewController, DetailDataChangesResponder {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var titleStr: String = ""
    var subtitleStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableDataChanged(to data: ElementDetail?) {
        self.titleStr = data!.title
        self.subtitleStr = data!.subtitle
    }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
