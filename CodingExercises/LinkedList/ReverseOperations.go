/*
Reverse Operations

You are given a singly-linked list that contains N integers. A subpart of the list is a contiguous set of even elements, bordered either by either end of the list or an odd element. For example, if the list is [1, 2, 8, 9, 12, 16], the subparts of the list are [2, 8] and [12, 16].
Then, for each subpart, the order of the elements is reversed. In the example, this would result in the new list, [1, 8, 2, 9, 16, 12].
The goal of this question is: given a resulting list, determine the original order of the elements.
Implementation detail:
You must use the following definition for elements in the linked list:
class Node {
    int data;
    Node next;
}

Signature

Node reverse(Node head)
Constraints
1 <= N <= 1000, where N is the size of the list
1 <= Li <= 10^9, where Li is the ith element of the list

Example
Input:
N = 6
list = [1, 2, 8, 9, 12, 16]
Output:
[1, 8, 2, 9, 16, 12]
*/

package LinkedList

type Node struct {
	data int
	next *Node
}

type List struct {
	root Node
	len  int
}

func (l *List) Init() *List {
	l.root.next = &l.root
	l.len = 0
	return l
}

func New() *List {
	return new(List).Init()
}
func (l *List) PushBack(v int) *Node {
	node := &Node{
		data: v,
	}
	current := &l.root
	if l.len == 0 {
		l.root = *node
	} else {
		for current.next != nil {
			current = current.next
		}
		current.next = node
	}
	l.len++
	return node
}

func (l *List) List() []int {
	node := &l.root
	if node == nil {
		return []int{}
	}

	var result []int

	for node.next != nil {
		result = append(result, node.data)
		node = node.next
	}

	result = append(result, node.data)
	return result
}

func reverse(head Node) *List {
	l := New()
	l.root = head
	current := &l.root
	var prev *Node = nil
	var prev_odd *Node = nil
	for current.next != nil {
		if current.data%2 == 0 {
			nextTemp := current.next
			current.next = prev
			prev = current
			current = nextTemp
			//current.next, prev, current = prev, current, current.next
		} else {
			if prev_odd != nil {
				//prev_odd.next, prev_odd.next.next = prev, current
				prevTemp := prev_odd.next
				prev_odd.next = prev
				prevTemp.next = current
			}
			prev_odd = current
			prev = current
			current = current.next
		}
	}
	return l
}
