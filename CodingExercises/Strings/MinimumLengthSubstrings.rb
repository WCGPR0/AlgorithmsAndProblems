=begin
:section: Minimum Length Substrings
You are given two strings s and t. You can select any substring of string s and rearrange the characters of the selected substring. Determine the minimum length of the substring of s such that string t is a substring of the selected substring.
Signature
int minLengthSubstring(String s, String t)
Input
s and t are non-empty strings that contain less than 1,000,000 characters each
Output
Return the minimum length of the substring of s. If it is not possible, return -1
Example
s = "dcbefebce"
t = "fd"'
output = 5
Explanation:
Substring "dcbef" can be rearranged to "cfdeb", "cefdb", and so on. String t is a substring of "cfdeb". Thus, the minimum length required is 5.
=end

def min_length_substring(s,t)
    min_length_substring = -1
    counter = Hash[t.split('').group_by{ |c| c}.map{ |k, v| [k, v.size] }]
    counter.default = 0
    l = 0
    t_matches = 0
    s.each_char.with_index{ |c, index| 
        counter[c] -= 1
        t_matches += 1 if counter[c] >= 0
        while t_matches == t.length()
            window_length = index - l + 1
            min_length_substring = min_length_substring == -1 ? window_length : [min_length_substring, window_length].min
            counter[c] += 1
            t_matches -= 1 if counter[c] > 0 
            l += 1
        end
    }
    return min_length_substring
end