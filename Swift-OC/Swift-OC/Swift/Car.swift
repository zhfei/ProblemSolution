//
//  Car.swift
//  Swift-OC
//
//  Created by zhoufei on 2023/3/31.
//

import Foundation


@objcMembers class Car: NSObject {
    var speed: Float;
    @objc(bigName) //重写暴露给OC的方法
    var name: String;
    
    init(speed: Float, name: String) {
        self.speed = speed;
        self.name = name;
    }
    
     func run() -> Void {
        print("出发，时速：\(self.speed)")
    }
    
    func runPerform() -> Void {
        perform(#selector(run))
    }
    
    dynamic func fillOil() -> Void {
        print("加油")
    }
}

extension Car {
    @objc(bigRun)
    func circleRun() {
        print("跑圈，时速：\(self.speed)")
    }
}

// Swift中@objc的使用

// Swift中被@objc 修改的协议可以被OC实现



// Swift的类中中被@objc dynamic 修改的方法 走runtime的那套消息发送机制

class Computer: NSObject {
    @objc dynamic func work(num: Int) {
        print("工作时长：\(num)")
    }
}

// Swift的类中中被@objc dynamic 修改的属性可以进行KVC/KVO
class Person: NSObject {
    @objc dynamic var age: Int = 10
    
    override init() {
        super.init()
        self.addObserver(self, forKeyPath: "age", options: .new, context: nil)
    }
    
    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("observer回调：\(change!)")
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "age")
    }
}

