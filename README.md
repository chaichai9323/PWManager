# PWManager

[![CI Status](https://img.shields.io/travis/chaichai9323/PWManager.svg?style=flat)](https://travis-ci.org/chaichai9323/PWManager)
[![Version](https://img.shields.io/cocoapods/v/PWManager.svg?style=flat)](https://cocoapods.org/pods/PWManager)
[![License](https://img.shields.io/cocoapods/l/PWManager.svg?style=flat)](https://cocoapods.org/pods/PWManager)
[![Platform](https://img.shields.io/cocoapods/p/PWManager.svg?style=flat)](https://cocoapods.org/pods/PWManager)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PWManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
if 集成Revenuecat就使用
    pod 'PWManager', '~> 16.0.0'
else
    pod 'PWManager/normal', '~> 16.0.0'
end

比如需要使用OOG104工程的所有paywall
pod 'PWManager/OOG104', '~> 16.0.0'

如果只想使用OOG104工程的某一个paywall
pod 'PWManager/OOG104/sample001', '~> 16.0.0'


```
## 使用方法
```ruby
在需要展示paywall的地方调用以下方法：
let p1 = PWManager.ProductModel(productIdentifier: "com.sub.year", unit: .year, price: 35.99, freeTrialDays: 7,priceSymbol: "$")
let p2 = PWManager.ProductModel(productIdentifier: "com.sub.month", unit: .month, price: 9.99, freeTrialDays: 7,priceSymbol: "$")
        
PWManager.config(
    design: "x13",
    products: [p1, p2],
    source: "onboarding",
    ui: PWManager.OOG104_sample001.self
)
.switchLanguage(language: "de")
.textFont{ name, size in
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
        
如果工程集成的RC使用方法如下:
let p1 = PWManager.ProductModel(productIdentifier: "com.sub.year", unit: .year, price: 35.99, freeTrialDays: 7,priceSymbol: "$")
let p2 = PWManager.ProductModel(productIdentifier: "com.sub.month", unit: .month, price: 9.99, freeTrialDays: 7,priceSymbol: "$")
        
PWManager.config(
    design: "x13",
    products: [p1, p2],
    source: "onboarding",
    ui: PWManager.OOG104_sample001.self
)
.switchLanguage(language: "de")
.textFont{ name, size in
    return UIFont(name: name, size: size)
}
.addExtraData(["day": "2023-04-24", "data": "wtf"])
.customAction{ obj in
    print(obj)
}
.buy { result in
    //result.isActive
}.restore { result in
    //result.isActive
}.dismiss { clickClose in
    print("\(clickClose ? "手动点击" : "")关闭")
}.present(in: self)
```

## 开发Paywall的注意事项
```ruby
【 所有的paywall需在本pod库完成，在需要使用paywall的项目中使用pod的方式集成。强烈推荐在本pod库中完成paywall的设计！！！ 】
 1.获取图片资源方法: R.image(named: xx)
 2.获取文本本地化方法: R.string(str)
 3.获取资源路径方法: R.filePath(file)
 4.获取字体的方法: R.font("Poppins-Regular", fontSize: 20)
 5.获取产品列表方法: self.products
```
## Author

chaichai9323, chailintao@laien.io

## License

PWManager is available under the MIT license. See the LICENSE file for more info.
