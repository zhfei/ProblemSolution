//
//  Car.swift
//  Swift-OC
//
//  Created by zhoufei on 2023/3/31.
//

import Foundation


@objcMembers class Car: NSObject {
    var speed: Float;
    var name: String;
    
    init(speed: Float, name: String) {
        self.speed = speed;
        self.name = name;
    }
    
    func run() -> Void {
        print("出发，时速：\(self.speed)")
    }
}

extension Car {
    func circleRun() {
        print("跑圈，时速：\(self.speed)")
    }
}
