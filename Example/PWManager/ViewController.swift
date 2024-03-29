//
//  ViewController.swift
//  PWManager
//
//  Created by chaichai9323 on 04/19/2023.
//  Copyright (c) 2023 chaichai9323. All rights reserved.
//

import UIKit
import PWManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(named: "main")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func click() {
        let p1 = PWManager.ProductModel(productIdentifier: "com.sub.year", unit: .year, price: 35.99, freeTrialDays: 7)
        let p2 = PWManager.ProductModel(productIdentifier: "com.sub.month", unit: .month, price: 9.99, freeTrialDays: 0, priceCode: "USD" ,priceSymbol: "$")
        
        PWManager.config(
            design: "x13",
            products: [p1, p2],
            source: "onboarding",
            ui: PWManager.OOG104_example.self
        )
        .switchLanguage(language: "de")
        .textFont{ name, size in
            ///比如可以在这里重定向字体
            return UIFont(name: name, size: size)
        }
        .addExtraData(["day": "2023-04-24", "data": "wtf"])
        .customAction{ obj in
            print(obj)
        }
        .buy { pid ,result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                result?(true)
            }
        }.restore { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                result?(false)
            }
        }.dismiss { clickClose in
            print("\(clickClose ? "手动点击" : "")关闭")
        }.present(in: self)
    }
}

