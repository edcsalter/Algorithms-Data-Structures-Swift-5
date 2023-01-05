import Foundation
import QuartzCore

public final class Benchtimer {
    @inline(__always) public static func measureBlock(executionCount: UInt = 10, closure: () -> Void) -> CFTimeInterval {
        var executionTimes: Double = 0
        
        for _ in 0..<executionCount {
            let startTime = CACurrentMediaTime()
            closure()
            let endTime = CACurrentMediaTime()
            executionTimes += (endTime - startTime)
        }
        
        return executionTimes/Double(executionCount)
    }
}

public extension CFTimeInterval {
    var formattedTime: String {
        return self >= 1000 ? String(Int(self)) + "s" // If measure greater than 1000, drop fractional part and display seconds
        : self >= 1 ? String(format: "%.3gs", self)   // If measure between 1 & 1000, show fractional part w/3 decimals (still seconds)
        : self >= 1e-3 ? String(format: "%.3gms", self * 1e3) // Between 1 millisecond and 1 second, measuring in milliseconds
        : self >= 1e-6 ? String(format: "%.3gµs", self * 1e6) // Microseconds
        : self < 1e-9 ? "0s" // nanoseconds
        : String(format: "%.3gns", self * 1e9)
    }
}

/**
 Time Value         Formatted String
 t >= 1000              1975s
 1 <= t < 1000          2.525s
 10^-3 <= t < 1         7.214ms
 10^-6 <= t < 10^-3     17.398µs
 */
