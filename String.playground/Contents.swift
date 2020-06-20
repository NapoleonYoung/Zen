import UIKit
/*
 13. 罗马数字转整数
 from: https://leetcode-cn.com/problems/roman-to-integer/
 */
func romanToInt(_ s: String) -> Int {
    let tempArray = Array(s).reversed()
    var res: Int = 0
    var lastValue: Int = 0
    for char in tempArray {
        var curValue: Int = 0
        switch char {
        case "I":
            curValue = 1
            break
        case "V":
            curValue = 5
            break
        case "X":
            curValue = 10
            break
        case "L":
            curValue = 50
            break
        case "C":
            curValue = 100
            break
        case "D":
            curValue = 500
            break
        case "M":
            curValue = 1000
            break
        default:
            break
        }
        if curValue < lastValue {
            res -= curValue
        } else {
            res += curValue
        }
        lastValue = curValue
    }
    return res
}

let a = romanToInt("MCMXCIV")
