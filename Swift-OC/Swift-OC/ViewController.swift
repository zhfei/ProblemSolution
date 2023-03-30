//
//  ViewController.swift
//  Swift-OC
//
//  Created by zhoufei on 2023/3/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let p = Person();
        p.name = "jack";
        p.age = 11;
        
        p.myCar = Car(speed: 101.1, name: "宝马")
        
        p.say();
        p.play();
    }


}

