=begin
:section: Rotational Cipher
One simple way to encrypt a string is to "rotate" every alphanumeric character by a certain amount. Rotating a character means replacing it with another character that is a certain number of steps away in normal alphabetic or numerical order.
For example, if the string "Zebra-493?" is rotated 3 places, the resulting string is "Cheud-726?". Every alphabetic character is replaced with the character 3 letters higher (wrapping around from Z to A), and every numeric character replaced with the character 3 digits higher (wrapping around from 9 to 0). Note that the non-alphanumeric characters remain unchanged.
Given a string and a rotation factor, return an encrypted string.
Signature
string rotationalCipher(string input, int rotationFactor)
Input
1 <= |input| <= 1,000,000
0 <= rotationFactor <= 1,000,000
Output
Return the result of rotating input a number of times equal to rotationFactor.
Example 1
input = Zebra-493?
rotationFactor = 3
output = Cheud-726?
Example 2
input = abcdefghijklmNOPQRSTUVWXYZ0123456789
rotationFactor = 39
output = nopqrstuvwxyzABCDEFGHIJKLM9012345678
=end

def rotational_cipher(input, rotation_factor)
    input = rotational_cipher_helper(input, rotation_factor, /[A-Z]/, 'A', 'Z')
    input = rotational_cipher_helper(input, rotation_factor, /[a-z]/, 'a', 'z')
    input = rotational_cipher_helper(input, rotation_factor, /[0-9]/, '0', '9')
end

def rotational_cipher_helper(input, rotation_factor, regex, start_char, end_char)
    input.gsub(regex){ |input_char|
         (((input_char.ord + rotation_factor - start_char.ord) % (end_char.ord - start_char.ord + 1)) + start_char.ord).chr 
    }
end

=begin
Hints
:section: Complexity
1. We need to process every character, even if only to check whether or not it's alphanumeric, so no solution can be faster than O(n) where, n is the number of characters in the input string. Within each character processing, however, consider how you might transform it optimally.
2. Since every character can be handled independently, we just need an O(1) operation for transforming a character into its ciphered version. In particular, we don’t want to use O(rotationFactor) steps for each character.
If your solution involves iterating through rotations one at a time (e.g. if a rotationFactor of 6 causes your code to consider transforming A to B to C to D to E to F to G without skipping directly from A to G), then you should consider how you might cut out those steps in between. If reducing the time complexity means you now use a meaningful amount of additional space, then you should consider how you might avoid using that space.

:section: Edge Cases
1. Does your code correctly handle all non-alphanumeric characters? The list of non-alphanumeric characters is harder to define, so it’s much easier to check if a character is alphanumeric rather than the other way around.
2. Does your code work correctly if rotationFactor is greater than 25? How about a rotationFactor of 0?

:section Approach
1. Let us first note that, for alphabetic characters, any rotationFactor greater than 25 can be reduced to a factor in the range [0, 25] since rotating 26 times is the same as rotating 0 times. Similarly, when rotating a numeric character, any rotationFactor greater than 9 can be reduced to the range [0, 9]. Subtracting 26 (or 10) repeatedly is a slow way to reduce the factor, so we can instead use modular arithmetic.
In most languages, the % operator is the modulo operator. A % B returns the remainder after dividing A by B, which is the same as subtracting B repeatedly until you have a value in the range [0, B). Some languages have an explicit mod(A, B) function instead of a first-class operator.
2. Once we’ve reduced our factor to a small value, there are a few ways to achieve O(1) rotations per character. Some of these take additional (though constant) space such as making a series of hash tables that map an input character to a ciphered character, one for each level of rotation from 0 to 25. But instead, we can take advantage of the fact that the characters a-z, A-Z, and 0-9 all exist in a contiguous range of ASCII values. Most languages let you convert characters to and from ASCII values, and many let you perform arithmetic directly on characters. If you want to rotate ‘E’ by 5, you can simply compute 'E' + 5 = 'J'.
3. We must take care, however, to wrap around if we go past the last character. We don’t want to do 'Z' + 4 = '^'! We can use modular arithmetic once more to avoid this problem. Consider this pseudocode:
rotateCharacter(c, rotationFactor) {
    return ((c - 'A' + rotationFactor) % 26) + 'A';
}
c - 'A' will let us represent each letter as a number from [0, 25]. This step is necessary because the ASCII value of ‘A’ is not 0. We then add the rotation factor (and note that it isn’t actually necessary to reduce it beforehand) and then take this sum modulo 26 to get the [0, 25]-representation of the rotated character. We add ‘A’ back in at the end to translate this value back into the ASCII range of A-Z.
You can extend this code to properly handle characters in the ranges a-z and 0-9 as well.
=end