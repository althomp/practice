import UIKit

// Calculate factorial using recursion
func factorial(of num: Int) -> Int {
    if num == 1 {
        return 1
    } else {
        return num * factorial(of: num-1)
    }
}
factorial(of: 5)

// Calculate gcd using recursion
func gcd(of num1: Int, and num2: Int) -> Int {
    if num2 == 0 {
        return num1
    }
    return gcd(of: num2, and: num1 % num2)
}
gcd(of: 111, and: 39)

/* LINKED LISTS */
// Delete middle node from singly-linked list
class Node<T> {
    public var next: Node?
    public var value: T
    
    init(value: T, next: Node?) {
        self.value = value
        self.next = next
    }
    
    func printRemainingNodes() {
        var temp: Node? = self
        repeat {
            print(temp!.value)
            temp = temp!.next
        } while temp != nil
    }
}

let root = Node(value: 0, next: nil)
var temp = root
for i in 1...10 {
    temp.next = Node(value: i, next: nil)
    temp = temp.next!
}

temp = root
while temp.value != 6 {
    temp = temp.next!
}

var middleNode = temp

func delete(middleNode: Node<Int>) {
    guard let next = middleNode.next else { print("This is a single-node linked list!"); return }
    
    middleNode.value = next.value
    middleNode.next = next.next
}

// Check if linked list is a palindrome
func isPalindrome(head: Node<String>) -> Bool {
    var slow: Node? = head
    var fast: Node? = head
    let stack = Stack<String>()
    
    while let f = fast, let _ = f.next {
        stack.push(slow!.value)
        slow = slow!.next
        fast = fast!.next!.next
    }

    // Odd number of elements
    if let _ = fast {
        slow = slow!.next
    }
    
    while let _ = slow {
        let top = stack.pop()
        if (top != slow!.value) { return false }
        slow = slow!.next
    }

    return true
}

/* STACK */
// Design a stack which, in addition to push and pop, has a function that returns the minimum element. These should all take O(1) time
class Stack<T: Comparable> {
    private var stack: [T]
    private var minStack: [T]
    
    init() {
        stack = []
        minStack = []
    }
    
    func push(_ element: T) {
        stack.append(element)
        
        if minStack.isEmpty {
            minStack.append(element)
        } else {
            if minStack[minStack.count-1] > element {
                minStack.append(element)
            }
        }
    }
    
    func pop() -> T? {
        guard !stack.isEmpty else { return nil }
        
        let element = stack.removeLast()
        if element == minStack[minStack.count-1] {
            minStack.removeLast()
        }
        return element
    }
    
    func getMin() -> T? {
        guard !minStack.isEmpty else { return nil }
        return minStack[minStack.count-1]
    }
}

/* BINARY TREE */
class TreeNode<T> {
    var value: T
    var left: TreeNode? = nil
    var right: TreeNode? = nil
    
    init(value: T, left: TreeNode?, right: TreeNode?) {
        self.value = value
        if let left = left {
            self.left = left
        }
        if let right = right {
            self.right = right
        }
    }
}

class BinaryTree {
    func inOrderTraversal(node: TreeNode<Int>?) {
        guard let node = node else { return }
        inOrderTraversal(node: node.left)
        print("\(node.value) ")
        inOrderTraversal(node: node.right)
    }
    
    func preOrderTraversal(node: TreeNode<Int>?) {
        guard let node = node else { return }
        print("\(node.value) ")
        preOrderTraversal(node: node.left)
        preOrderTraversal(node: node.right)
    }
    
    func postOrderTraversal(node: TreeNode<Int>?) {
        guard let node = node else { return }
        postOrderTraversal(node: node.left)
        postOrderTraversal(node: node.right)
        print("\(node.value) ")
    }
}

/* QUEUE */
class Queue<T> {
    private var queue: [T] = []
    var count: Int {
        get { return queue.count }
    }
    
    func enqueue(element: T) {
        queue.append(element)
    }
    
    func dequeue() -> T? {
        guard !queue.isEmpty else { return nil }
        return queue.removeFirst()
    }
}

/* GRAPH */
class GraphNode<T: Comparable> {
    private(set) var value: T
    var visited: Bool = false
    var marked: Bool = false
    private(set) var children: [GraphNode]
    
    init(value: T, children: [GraphNode]?) {
        self.value = value
        self.children = []
        if let children = children {
            self.children += children
        }
    }
}

class Graph {
    func depthFirstSearch(root: GraphNode<Int>) {
        print("\(root.value) ")
        root.visited = true
        
        for child in root.children {
            if !child.visited {
                depthFirstSearch(root: child)
            }
        }
    }
    
    func breadthFirstSearch(root: GraphNode<Int>) {
        let queue = Queue<GraphNode<Int>>()
        root.marked = true
        queue.enqueue(element: root)
        
        while queue.count > 0 {
            let node = queue.dequeue()
            print("\(node!.value) ")
            for child in node!.children {
                if !child.marked {
                    queue.enqueue(element: child)
                }
            }
        }
    }
}

// Fibonacci: top-down dynamic programming
func topDownFibonacci(n: Int) -> Int {
    func fibonacci(n: Int, memo: [Int]) -> Int {
        var temp = memo
        if n == 0 || n == 1 {
            return n
        }
        if (temp[n] == 0) {
            temp[n] = fibonacci(n: n - 1, memo: temp) + fibonacci(n: n - 2, memo: temp)
        }
        return temp[n]
    }
    return fibonacci(n: n, memo: [n+1])
}

// Fibonacci: bottom-up dynamic programming
func bottomUpFibonacci(n: Int) -> Int {
    if n == 0 || n == 1 {
        return n
    }
    
    var a = 0, b = 1
    for _ in 2...n {
        let c = a + b
        a = b
        b = c
    }
    return a + b
}

// Mergesort
// Quicksort


