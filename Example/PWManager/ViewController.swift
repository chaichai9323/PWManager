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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func click() {
        PWManager.config(
            design: "x13",
            products: ["com.abc.year"],
            source: "onboarding",
            ui: OnboardingView.self
//        )
//        PWManager.config(
//            RCPaywall: "x13",
//            products: ["com.abc.year"],
//            source: "onboarding",
//            ui: OnboardingView.self
        ).addExtraData("abc").buy { /*pid ,*/result in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
//                result?(true)
//            }
//            print("购买" + (result.isActive ? "成功" : "失败"))
        }.restore { result in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
//                result?(false)
//            }
//            print("恢复" + (result.isActive ? "成功" : "失败"))
        }.dismiss {
            print("关闭")
        }.present(in: self)
    }
 
    class OnboardingView: PWManager.PaywallView {
        override func setupUI() {
            super.setupUI()
            backgroundColor = .brown
            
            for (i, str) in ["购买","恢复","关闭"].enumerated() {
                let btn = UIButton(frame: .init(origin: .init(x: 100, y: 100 + 70 * i), size: .init(width: 60, height: 45)))
                btn.backgroundColor = .red
                btn.setTitle(str, for: .normal)
                addSubview(btn)
                btn.tag = i
                btn.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
            }
        }
        @objc func click(sender: UIButton) {
            //所有产品列表
            let products = products
            
            switch sender.tag {
            case 0: paywallActionBuy(productID: products[0])
            case 1: paywallActionRestore()
            case 2: paywallActionClose()
            default: break
            }
        }
    }
}

