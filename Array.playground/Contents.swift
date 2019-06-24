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
 title: 数组中只出现一次的两个数字
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
    // 3. 根据异或结果，按照数组中某一位为 1 或者 0 分为两组，每组异或结果即为要找的数
    
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

/*
 3.
 title: 数组 max sum-distance
 from：https://stackoverflow.com/questions/32067492/maximize-sum-distance-for-integer-array#
 description: Int 数组，对 A[i] + A[j] + (i - j) 求最大值，其中 i>=j
 solution: 即为求 A[i] + i + A[j] - j ，因此每次访问数组，都要找当前最大的 A[j] - j
 */
func maxRes(desArray: [Int]) -> Int {
    var left: Int = 0
    var res: Int = desArray.first! * 2
    for index in 0..<desArray.count {
        let tem = desArray[index] + index + desArray[left] - left
        let temp = desArray[index] * 2
        let sum = tem > temp ? tem : temp
        res = res > sum ? res : sum
        if desArray[index] - index > desArray[left] - left {
            left = index
        }
    }
    
    return res
}

let max = maxRes(desArray: [1, 0, -1, 2, 10])
