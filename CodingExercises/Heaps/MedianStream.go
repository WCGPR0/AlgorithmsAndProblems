/*
Median Stream

You're given a list of n integers arr[0..(n-1)]. You must compute a list output[0..(n-1)] such that, for each index i (between 0 and n-1, inclusive), output[i] is equal to the median of the elements arr[0..i] (rounded down to the nearest integer).
The median of a list of integers is defined as follows. If the integers were to be sorted, then:
If there are an odd number of integers, then the median is equal to the middle integer in the sorted order.
Otherwise, if there are an even number of integers, then the median is equal to the average of the two middle-most integers in the sorted order.
Signature
int[] findMedian(int[] arr)
Input
n is in the range [1, 1,000,000].
Each value arr[i] is in the range [1, 1,000,000].
Output
Return a list of n integers output[0..(n-1)], as described above.
Example 1
n = 4
arr = [5, 15, 1, 3]
output = [5, 10, 5, 4]
The median of [5] is 5, the median of [5, 15] is (5 + 15) / 2 = 10, the median of [5, 15, 1] is 5, and the median of [5, 15, 1, 3] is (3 + 5) / 2 = 4.
Example 2
n = 2
arr = [1, 2]
output = [1, 1]
The median of [1] is 1, the median of [1, 2] is (1 + 2) / 2 = 1.5 (which should be rounded down to 1).
*/

package main

import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type MinHeap struct {
	IntHeap
}

func (h MinHeap) Less(i, j int) bool { return h.IntHeap[i] < h.IntHeap[j] }

func findMedian(arr []int) []int {
	var findMedian []int
	minHeap := &MinHeap{}
	maxHeap := &IntHeap{}
	for index, element := range arr {
		if (index == 0) || (element < (*maxHeap)[0]) {
			heap.Push(maxHeap, element)
		} else {
			heap.Push(minHeap, element)
		}

		if maxHeap.Len() > minHeap.Len()+1 {
			element := maxHeap.Pop()
			heap.Push(minHeap, element)
		} else if minHeap.Len() > maxHeap.Len()+1 {
			element := minHeap.Pop()
			heap.Push(maxHeap, element)
		}

		var median int
		if maxHeap.Len() == minHeap.Len() {
			median = ((*maxHeap)[0] + minHeap.IntHeap[0]) / 2
		} else {
			median = (*maxHeap)[0]
			if minHeap.Len() > maxHeap.Len() {
				median = minHeap.IntHeap[0]
			}
		}

		findMedian = append(findMedian, median)
	}
	return findMedian
}
