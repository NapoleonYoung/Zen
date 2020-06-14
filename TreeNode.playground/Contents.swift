import Cocoa

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(val: Int) {
        self.val = val
    }
}

class Solution {
    
    /// 1. 前序遍历: 栈方式
    func preorderTraversalStack(root: TreeNode?) -> [Int] {
        var node = root
        var stack = [TreeNode]()
        var res = [Int]()
        
        while !stack.isEmpty || node != nil {
            if node != nil {
                res.append(node!.val)
                stack.append(node!)
                node = node!.left
            } else {
                node = stack.removeLast().right
            }
        }
        
        return res
    }

    /// 2. 中序遍历： 栈方式
    func inorderTraversal(root: TreeNode?) -> [Int] {
        var node = root
        var stack = [TreeNode]()
        var res = [Int]()
        
        while !stack.isEmpty || node != nil {
            if node != nil {
                stack.append(node!)
                node = node!.left
            } else {
                node = stack.removeLast()
                res.append(node!.val)
                node = node!.right
            }
        }
        
        return res
    }
    
    ///3.  层级遍历
    func levelPrint(root: TreeNode?) -> [[Int]] {
        var queue = [TreeNode]()
        var result = [[Int]]()
        
        if let root = root {
            queue.append(root)
        }
        while queue.count > 0 {
            let count = queue.count
            
            var level = [Int]()
            for _ in 0..<count {
                let node = queue.removeFirst()
                level.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            result.append(level)
        }
        return result
    }
    
    /// 4. 之字形遍历，需要使用两个栈
    func zhiPrint(root: TreeNode?) -> [[Int]] {
        var res = [[Int]]()
        guard root != nil else {
            return res
        }
        var stack1 = [TreeNode]()
        var stack2 = [TreeNode]()
        var isOdd = true
        stack1.append(root!)
        
        while !stack1.isEmpty || !stack2.isEmpty {
            let count = isOdd ? stack1.count : stack2.count
            var temp = [Int]()
            
            for _ in 0..<count {
                if isOdd {
                    let node = stack1.removeFirst()
                    temp.append(node.val)
                    if node.left != nil {
                        stack2.append(node.left!)
                    }
                    if node.right != nil {
                        stack2.append(node.right!)
                    }
                } else {
                    let node = stack2.removeFirst()
                    temp.append(node.val)
                    if node.right != nil {
                        stack1.append(node.right!)
                    }
                    if node.left != nil {
                        stack1.append(node.left!)
                    }
                }
            }
            isOdd = !isOdd
            res.append(temp)
        }
        return res
    }
}

func zhiPrint2(root: TreeNode?) {
    guard root != nil else {
        return
    }
    
    var stackArray = [[TreeNode](), [TreeNode]()]
    
    var current = 0
    var next = 1
    stackArray[current].append(root!)
    while !stackArray[0].isEmpty || !stackArray[1].isEmpty {
        let node = stackArray[current].removeFirst()
        print(node.val)
        if current == 0 {
            if node.left != nil {
                stackArray[next].append(node.left!)
            }
            if node.right != nil {
                stackArray[next].append(node.right!)
            }
        } else {
            if node.right != nil {
                stackArray[next].append(node.right!)
            }
            if node.left != nil {
                stackArray[next].append(node.left!)
            }
        }
        if !stackArray[current].isEmpty {
            print("\n")
            current = 1 - current
            next = 1 - next
        }
    }

    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }

        var stack: [[Int]] = []
        var queue: [TreeNode] = [root]
        while !queue.isEmpty {
            var tempArray: [TreeNode] = []
            var val: [Int] = []
            for node in queue {
                val.append(node.val)
                if let left = node.left {
                    tempArray.append(left)
                }
                if let right = node.right {
                    tempArray.append(right)
                }
            }
            queue = tempArray
            if !stack.isEmpty {
                stack.insert(val, at: 0)
            } else {
                stack.append(val)
            }
        }
        return stack
    }
    
}

func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
    guard let root = root else {
        return false
    }
    var stack = [root]
    var sumStack = [sum - root.val]
    while !stack.isEmpty {
        let node = stack.remove(at: 0)
        let curSum = sumStack.remove(at: 0)
        if curSum == 0 && node.left == nil && node.right == nil {
            return true
        }
        if let right = node.right {
            stack.append(right)
            sumStack.append(curSum - right.val)
        }
        if let left = node.left {
            stack.append(left)
            sumStack.append(curSum - left.val)
        }
    }
    return false
}

func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
    if p == nil && q == nil { return true }
    if p == nil || q == nil  { return false }
    return isSameTree(p!.left, q!.left) && isSameTree(p!.right, q!.right)
}

func isSymmetric(_ root: TreeNode?) -> Bool {
    guard let root = root else {
        return true
    }
    guard let left = root.left, let right = root.right else {
        if root.left == nil && root.right == nil {
            return true
        } else {
            return false
        }
    }
    var queue: [TreeNode] = [left, right]
    while !queue.isEmpty {
        if queue.count / 2 != 0 {
            return false
        }
        let first = queue.removeFirst()
        let second = queue.removeFirst()
        if first.val != second.val {
            return false
        }
        if let left = first.left, let right = second.right {
            queue.append(left)
            queue.append(right)
        } else {
            if first.left != nil || second.right != nil {
                return false
            }
        }
        if let right = first.right, let left = second.left {
            queue.append(right)
            queue.append(left)
        } else {
            if first.right != nil || second.left != nil {
                return false
            }
        }
    }
    return true
}

/*
 5. 111. 二叉树的最小深度:https://leetcode-cn.com/problems/minimum-depth-of-binary-tree/
 */
func minDepth(_ root: TreeNode?) -> Int {
    guard let root = root else {
        return 0
    }
    var tempArray = [root]
    var depth: Int = 1
    while !tempArray.isEmpty {
        var array: [TreeNode] = []
        for node in tempArray {
            if node.left != nil || node.right != nil {
                if let left = node.left {
                    array.append(left)
                }
                if let right = node.right {
                    array.append(right)
                }
            } else {
                return depth
            }
        }
        depth += 1
        tempArray = array
    }
    return depth
}
