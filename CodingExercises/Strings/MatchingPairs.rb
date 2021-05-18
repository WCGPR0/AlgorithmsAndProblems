=begin
:section: Matching Pairs
Given two strings s and t of length N, find the maximum number of possible matching pairs in strings s and t after swapping exactly two characters within s.
A swap is switching s[i] and s[j], where s[i] and s[j] denotes the character that is present at the ith and jth index of s, respectively. The matching pairs of the two strings are defined as the number of indices for which s[i] and t[i] are equal.
Note: This means you must swap two characters at different indices.
Signature
int matchingPairs(String s, String t)
Input
s and t are strings of length N
N is between 2 and 1,000,000
Output
Return an integer denoting the maximum number of matching pairs
Example 1
s = "abcd"
t = "adcb"
output = 4
Explanation:
Using 0-based indexing, and with i = 1 and j = 3, s[1] and s[3] can be swapped, making it  "adcb".
Therefore, the number of matching pairs of s and t will be 4.
Example 2
s = "mno"
t = "mno"
output = 1
Explanation:
Two indices have to be swapped, regardless of which two it is, only one letter will remain the same. If i = 0 and j=1, s[0] and s[1] are swapped, making s = "nmo", which shares only "o" with t.
=end

def matching_pairs(s,t)
    return -1 if s.length() != t.length()
    arr_length = s.length()
    unmapped_keys = Hash.new(0)
    (1..arr_length).each { |i|
        if s[i] != t[i]
            unmapped_keys[s[i]] += 1
            unmapped_keys[t[i]] += 1
        end
    }
    if unmapped_keys.length() == 0
        return arr_length < 3 ? 0 : 1
    end
    meaningful_swap_count = unmapped_keys.select{ |k, v| v >= 2 }.length()
    matching_pairs_count = arr_length - (unmapped_keys.values.inject(0) {|sum, v| sum + v } / 2)
    if meaningful_swap_count >= 2
        matching_pairs_count += 2
    elsif meaningful_swap_count == 1
        matching_pairs_count += 1
    end
    return matching_pairs_count
end