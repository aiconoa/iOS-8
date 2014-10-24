// Playground - noun: a place where people can play

import UIKit
import XCPlayground

var str = "Hello, playground"

println(str)

let 🐶🐮 = "dogcow"

println(🐶🐮)

countElements(🐶🐮)

var uni = "🐶🐮"

countElements(uni)
uni.utf16Count

let http404Error = (404, "Not Found")

let (statusCode, statusMessage) = http404Error

print(statusCode)

http404Error.0
http404Error.1

println("le code est \(http404Error.1)")

var serverResponseCode: Int? = 404

//serverResponseCode = nil

println(serverResponseCode!)

if let code = serverResponseCode {
  println(code)
}

var code = serverResponseCode ?? 404

for index in 1..<5 {
    XCPCaptureValue("toto", index)
    println("\(index) times 5 is \(index * 5)")
}

for x in -500...500 {
    XCPCaptureValue("parabole", x*x)
}

var shoppingList = ["Eggs", "Milk"]

shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
shoppingList[4..<6] = ["Bananas", "Apples"]

shoppingList.count
shoppingList

for (index, value) in enumerate(shoppingList) {
    println("Item \(index + 1): \(value)")
}



struct Resolution {
    var width: Int
    var height: Int
}


var r = Resolution(width: 0, height: 12)

struct SomeStruct {
    var x:Int
    var y:String
}

class SomeClass {
    var x:Int
    var y:String
    init(x:Int){
        self.x = x
        self.y = "3"
    }
    
    convenience init(y:String, x:Int) {
        self.init(x:x)
        self.y = y
    }
    
}

var a = SomeClass(x:3)







