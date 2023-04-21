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
        let p1 = PWManager.ProductModel(productIdentifier: "com.sub.year", unit: .year, price: 35.99)
        let p2 = PWManager.ProductModel(productIdentifier: "com.sub.month", unit: .month, price: 9.99)
        
        PWManager.config(
            design: "x13",
            products: [p1, p2],
            source: "onboarding",
            ui: PWManager.Paywall_u8enjsbh.self
        )
        .switchLanguage(language: "de")
        .addExtraData("abc")
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

