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
    
    /// 前序遍历: 栈方式
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
    
    /// 前序遍历: 递归方式
//    func preorderTraversalRecursive(root: TreeNode?) -> [Int] {
//        var res = [Int]()
//        if <#condition#> {
//            <#code#>
//        }
//
//    }
    
    /// 中序遍历： 栈方式
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
    
    /// 后序遍历： 栈方式
//    func postorderTraversal(root: TreeNode?) -> [Int] {
//        var node = root
//        var stack = [TreeNode]()
//        var res = [Int]()
//
//        while !stack.isEmpty() || node != nil {
//            if node != nil {
//                <#code#>
//            } else {
//
//            }
//        }
//    }
    
    /// 层级遍历    
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
    
    /// 之字形遍历，需要使用两个栈
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
    
}
