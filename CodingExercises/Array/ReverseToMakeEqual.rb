=begin

:section: Reverse To Make Equal

Given two arrays A and B of length N, determine if there is a way to make A equal to B by reversing any subarrays from array B any number of times.
Signature
bool areTheyEqual(int[] arr_a, int[] arr_b)
Input
All integers in array are in the range [0, 1,000,000,000].
Output
Return true if B can be made equal to A, return false otherwise.
Example
A = [1, 2, 3, 4]
B = [1, 4, 3, 2]
output = true
After reversing the subarray of B from indices 1 to 3, array B will equal array A.

=end

#Implementation

def are_they_equal(arr_a, arr_b)
  return arr_a.group_by{|e| e}.map{|k,v| [k, v.length]}.to_h == arr_b.group_by{|e| e}.map{|k,v| [k, v.length]}.to_h
end


# Tests
fail if not are_they_equal([1,2,3,4],[1,4,3,2])
