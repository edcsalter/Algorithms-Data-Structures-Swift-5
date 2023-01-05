import UIKit

var numbers = Array(0..<1000)
let sortTime = Benchtimer.measureBlock {
    numbers.sort()
}

print("Sorting took \(sortTime.formattedTime)") // Sorting took 148µs

