//
//  ViewController.swift
//  AppManage
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AppManager.shared().tokenManger.update(token: "dskfjklsdjaflkj")
        print(AppManager.shared().tokenManger.token)
        AppManager.shared().user.id = 1
        print(AppManager.shared().user.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

