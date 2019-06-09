import Cocoa

/*
 1.
 title：连续子数组的最大和
 from：剑指 Offer 42 题
 description：输入一个整型数组，数组里有正数也有负数。数组中的一个
 或连续多个整数组成一个子数组。求所有s子数组的和的最大值。
 要求时间复杂度为 O(n)。
 */
func findGreatestSumOfSubArray(destinatedArray: [Int]?) -> Int {
    guard destinatedArray != nil else { return 0 }
    guard destinatedArray!.count > 1 else { return destinatedArray!.first! }
    
    let array = destinatedArray!
    var max: Int = 0
    var curSum: Int = 0
    
    for index in 0..<(array.count - 1) {
        if curSum <= 0 {
            curSum = array[index]
        } else {
            curSum += array[index]
        }
        if curSum > max {
            max = curSum
        }
    }
    
    return max
}

let a = findGreatestSumOfSubArray(destinatedArray: [1, -2, 3, 10, -4, 7, 2, -5])
