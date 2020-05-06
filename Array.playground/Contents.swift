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
    
    for index in 0..<array.count {
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

/*
 4.
 title: 旋转矩阵
 from: https://leetcode-cn.com/problems/rotate-matrix-lcci/
 description: 给你一幅由 N × N 矩阵表示的图像，其中每个像素的大小为 4 字节。请你设计一种算法，将图像旋转 90 度。
 不占用额外内存空间能否做到？
 solution: 先沿对角线翻转，再左右旋转
 */
func rotate(_ matrix: inout [[Int]]) {
    let n = matrix.count
    for i in 0..<(n-1) {
        for j in (i+1)..<n {
            let temp = matrix[i][j]
            matrix[i][j] = matrix[j][i]
            matrix[j][i] = temp
        }
    }
    for i in 0..<n {
        for j in 0..<(n/2) {
            let temp = matrix[i][j]
            matrix[i][j] = matrix[i][n-j-1]
            matrix[i][n-j-1] = temp
        }
    }
}

/*
 5.
 title: 移动零
 from: https://leetcode-cn.com/problems/move-zeroes/
 description: 给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
 说明: 1. 必须在原数组上操作，不能拷贝额外的数组。
      2. 尽量减少操作次数。
 solution: 双指针，遇到非零就传值
 */
func moveZeroes(_ nums: inout [Int]) {
    var j: Int = 0
    for i in 0..<nums.count {
        if nums[i] != 0 {
            nums[j] = nums[i]
            j += 1
        }
    }
    while j < nums.count {
        nums[j] = 0
        j += 1
    }
}

/*
6.
title:  翻转字符串里的单词
from: https://leetcode-cn.com/problems/reverse-words-in-a-string/
description: 给定一个字符串，逐个翻转字符串中的每个单词。
说明: 1. 无空格字符构成一个单词。
     2. 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
     3. 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。
solution: 按空格找到单词，翻转数组
*/
func reverseWords(_ s: inout String) -> String {
    let array = s.split(separator: " ").reversed().joined(separator: " ")

    return array
}

func reverseStr(chars: inout [Character], start: Int, end: Int) {
    var start = start
    var end = end
    while start < end {
        let temp = chars[start]
        chars[start] = chars[end]
        chars[end] = temp
        start += 1
        end -= 1
    }
}

/*
7.
title:  找到所有数组中消失的数字
from: https://leetcode-cn.com/problems/find-all-numbers-disappeared-in-an-array/
description: 给定一个范围在  1 ≤ a[i] ≤ n ( n = 数组大小 ) 的整型数组，数组中的元素一些出现了两次，另一些只出现一次。
             找到所有在 [1, n] 范围之间没有出现在数组中的数字。
说明: 您能在不使用额外空间且时间复杂度为O(n)的情况下完成这个任务吗? 你可以假定返回的数组不算在额外空间内。
 示例： 输入：[4,3,2,7,8,2,3,1] 输出：[5,6]
solution: 将数组元素作为数组下标对应的元素设为负值，最后数组中的正值所谓的索引即为结果值
*/
func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
    guard nums.count > 0 else { return [] }

    var res = nums
    for index in 0..<res.count {
        let i = abs(res[index]) - 1
        res[i] = -abs(res[i])
    }
    var temp: [Int] = []
    for index in 0..<res.count {
        if res[index] > 0 {
            temp.append(index + 1)
        }
    }
    return temp
}

/*
8.
title:  一周中的第几天
from: https://leetcode-cn.com/problems/day-of-the-week/
description: 给你一个日期，请你设计一个算法来判断它是对应一周中的哪一天。输入为三个整数：day、month 和 year，分别表示日、月、年。您返回的结果必须是这几个值中的一个 {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}。
solution:
         1. 计算出总天数，除以 7
         2. 基姆拉尔森公式
*/
func dayOfTheWeek(_ day: Int, _ month: Int, _ year: Int) -> String {
    var days: Int = 0
    for yearIndex in 1971..<year {
        if isLeapYear(year: yearIndex) {
            days += 366
        } else {
            days += 365
        }
    }
    var months: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if isLeapYear(year: year) {
       months[1] = 29
    }

    for monthIndex in 1..<month {
        days += months[monthIndex - 1]
    }
    days += (day - 1)

    let week = ["Friday", "Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"]
    return week[days % 7]
}

private func isLeapYear(year: Int) -> Bool {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400) == 0
}

/// 基姆拉尔森公式
func dayOfTheWeek_2(_ day: Int, _ month: Int, _ year: Int) -> String {
    var month = month
    var year = year
    if month < 3 {
        month += 12
        year -= 1
    }
    let weekDay = (day + 2*month + 3*(month + 1)/5 + year + year/4 - year/100 + year/400 + 1) % 7
    let week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    return week[weekDay]
}

/*
9.
title:  按奇偶排序数组
from: https://leetcode-cn.com/problems/sort-array-by-parity/
description: 给定一个非负整数数组 A，返回一个数组，在该数组中， A 的所有偶数元素之后跟着所有奇数元素。你可以返回满足此条件的任何数组作为答案。
 示例：输入：[3,1,2,4]
      输出：[2,4,3,1]
      输出 [4,2,3,1]，[2,4,1,3] 和 [4,2,1,3] 也会被接受。
solution:
         1. 双指针
*/
func sortArrayByParity(_ A: [Int]) -> [Int] {
    var resArray = A
    var left: Int = 0
    var right: Int = resArray.count - 1
    while left < right {
        while left < right && resArray[left] % 2 == 0 {
            left += 1
        }
        while left < right && resArray[right] % 2 != 0 {
            right -= 1
        }
        if left < right {
            let temp = resArray[left]
            resArray[left] = resArray[right]
            resArray[right] = temp
        }
    }
    return resArray
}

/*
10.
title: 按奇偶排序数组 II
from: https://leetcode-cn.com/problems/sort-array-by-parity-ii/
description: 给定一个非负整数数组 A， A 中一半整数是奇数，一半整数是偶数。对数组进行排序，以便当 A[i] 为奇数时，i 也是奇数；当 A[i] 为偶数时， i 也是偶数。你可以返回任何满足上述条件的数组作为答案。
输入：[4,2,5,7]
输出：[4,5,2,7]
解释：[4,7,2,5]，[2,5,4,7]，[2,7,4,5] 也会被接受。
solution:
         1. 双指针
*/
func sortArrayByParityII(_ A: [Int]) -> [Int] {
    var resArray = A
    var i: Int = 0
    var j: Int = 1
    while i < resArray.count && j < resArray.count {
        while i < resArray.count && resArray[i] % 2 == 0 {
            i += 2
        }
        while j < resArray.count && resArray[j] % 2 == 1 {
            j += 2
        }
        if i < resArray.count && j < resArray.count  {
            let temp = resArray[i]
            resArray[i] = resArray[j]
            resArray[j] = temp
        }
    }
    return resArray
}

/*
11.
title: 复写零
from: https://leetcode-cn.com/problems/duplicate-zeros/
description: 给你一个长度固定的整数数组 arr，请你将该数组中出现的每个零都复写一遍，并将其余的元素向右平移。
注意：请不要在超过该数组长度的位置写入元素。
要求：请对输入的数组 就地 进行上述修改，不要从函数返回任何东西。
示例 1：
 输入：[1,0,2,3,0,4,5,0]
 输出：null
 解释：调用函数后，输入的数组将被修改为：[1,0,0,2,3,0,0,4]
提示：
 1 <= arr.length <= 10000
 0 <= arr[i] <= 9
solution:
 1. 双指针
*/
func duplicateZeros(_ arr: inout [Int]) -> [Int] {
    var i = 0
    var j = 0
    while j < arr.count {
        if arr[i] == 0 {
            j += 1
        }
        i += 1
        j += 1
    }
    i -= 1
    j -= 1
    while i >= 0 {
        // 当输入数组为 [0] 是，第一次进入时，j = 1，因此应当判断下 j < arr.count ?
        if j < arr.count {
            arr[j] = arr[i]
        }
        j -= 1
        if arr[i] == 0 {
            arr[j] = 0
            j -= 1
        }
        i -= 1
    }
    return arr
}

/*
12.
title: 玩筹码
from: https://leetcode-cn.com/problems/play-with-chips/
description: 数轴上放置了一些筹码，每个筹码的位置存在数组 chips 当中。你可以对 任何筹码 执行下面两种操作之一（不限操作次数，0 次也可以）：将第 i 个筹码向左或者右移动 2 个单位，代价为 0。将第 i 个筹码向左或者右移动 1 个单位，代价为 1。最开始的时候，同一位置上也可能放着两个或者更多的筹码。返回将所有筹码移动到同一位置（任意位置）上所需要的最小代价。

示例 2：
 输入：chips = [2,2,2,3,3]
 输出：2
 解释：第四和第五个筹码移动到位置二的代价都是 1，所以最小总代价为 2
solution:
 1. 阅读理解
*/
func minCostToMoveChips(_ chips: [Int]) -> Int {
    var even = 0
    var odd = 0
    for item in chips {
        print(item)
        if item % 2 == 0 {
            even += 1
        } else {
            odd += 1
        }
    }
    return min(even, odd)
}

let aaaa = minCostToMoveChips([2, 2, 2, 3, 3])
