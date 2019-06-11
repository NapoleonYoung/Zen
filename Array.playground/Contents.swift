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

/*
 2.
 title: 数组中数字出现的次数
 from：剑指 Offer 56 题
 description: 一个整型数组里除两个数字之外，其他数字都出现了两次。请写程序找出这两个只出现一次的数字。
 要求时间复杂度是 O(n)，空间复杂度是 O(1)。
 */
func findNumsAppearOnce(desArray: [Int]) -> [Int] {
    var numOne: Int = 0
    var numTwo: Int = 0
    guard desArray.count > 1 else {
        return [numOne, numTwo]
    }
    // 1. 求出数组中所有数字的异或结果
    var exclusizeOr: Int = 0
    for index in 0..<desArray.count {
        exclusizeOr ^= desArray[index]
    }
    // 2. 找到异或结果中第一个 1 的位置
    var indexOfBits: Int = 0
    while exclusizeOr % 2 == 0 {
        indexOfBits += 1
    }
    // 2. 根据异或结果，按照数组中某一位为 1 或者 0 分为两组，每组异或结果即为要找的数
    
    for item in desArray {
        if ((item >> indexOfBits) & 1) == 1 {
            numOne ^= item
        } else {
            numTwo ^= item
        }
    }
    return [numOne, numTwo]
}
//let testArray = [1, 1, 2, 2, 3, 4, 4, 5, 5, 6]
let testArray = [1]
findNumsAppearOnce(desArray: testArray)


