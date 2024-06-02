import UIKit
func swap_2_no(number1:Double, number2:Double)
-> (Double, Double){
    print("before: x= \(x), y = \(y)")
    var x = x+y
    let y = x-y
    x = x-y
    print("after: x= \(x), y = \(y)")
    return (x, y)
}
var x = 20.4
var y = 30.0
swap_2_no(number1: x, number2: y)


func swap_2_no_1(number1:Double, number2:Double)
-> (Double, Double){
    var first = number1
    var second = number2
    
    let c = first
    first = second
    second = c
    return (first, second)
}
//let x=20.4
//let y=30.0

//print("before: x=,\(x),y = \(y)")
print(swap_2_no_1(number1: 60, number2: 80))
