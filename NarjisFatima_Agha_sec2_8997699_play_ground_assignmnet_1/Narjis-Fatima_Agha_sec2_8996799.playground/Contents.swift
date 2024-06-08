import UIKit
//Sum of Two numbers
func twoSum(_ x: Int, _ y: Int) -> Double {
    return Double(x + y)
}

print(twoSum(20, 30))


//function to check if student exists in the array
func studentExists(_ array_of_students: [String], _ name: String) -> Bool {
    return array_of_students.contains(name)
}

let array_of_students = ["Harry", "Nick", "Donald", "Mike"]
print(studentExists(array_of_students, "Donald"))


//Sum of numbers in an array
func reduce(_ numbers: [Int]) -> Int {
    return numbers.reduce(0, +)
}

let numbers = [7, 5, 12, 28, 44]
print(reduce(numbers))


//Pythagoras Theorm
func hypotenuse(_ a: Double, _ b: Double) -> Double {
    let c = sqrt(pow(a, 2) + pow(b, 2))
    return c
}

//let c = hypotenuse(3.0, 4.0)
print("The length of the hypotenuse is ", hypotenuse(4.0,3.0))


//Dictionary
func match(key: String, dictionary: [String: Any]) -> Any? {
    return dictionary[key]
}

let dictionaryData: [String : Any] = ["name": "Mike", "studentNumber": 5544, "Campus": "Waterloo"]
if let matchedValue = match(key: "Campus", dictionary: dictionaryData) {
    print("The value for the given key is: \(matchedValue)")
} else {
    print("Key not found in dictionary")
}



