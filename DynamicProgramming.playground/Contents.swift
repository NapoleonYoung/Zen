import UIKit

/*
 70. 爬楼梯
 https://leetcode-cn.com/problems/climbing-stairs/
 */
func climbStairs(_ n: Int) -> Int {
    var prepre: Int = 1
    var pre: Int = 2
    var res: Int = 0
    for _ in 3...n {
        res = prepre + pre
        prepre = pre
        pre = res
    }
    return res
}

let a = climbStairs(3)
