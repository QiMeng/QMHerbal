//
//  DetailsViewController.swift
//  QMHerbal
//
//  Created by QiMENG on 15/6/26.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    var infoModel:Model!
    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = infoModel.title
        infoLabel.text = infoModel.info
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
