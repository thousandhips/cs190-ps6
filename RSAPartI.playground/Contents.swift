/*:
# CS 190 Problem Set #6&mdash;RSA Cryptography Part I

[Course Home Page]( http://physics.stmarys-ca.edu/classes/CS190_S16/index.html )

Due: Tuesday, April 5th, 2016.

## Reading that is Related to this Week's Lectures and/or This Problem Set

For this problem set, we are going to learn Rivest-Shamir-Adleman (RSA) cryptography by implementing _the first six sections_ of the Wikibook [A Basic Public Key Example]( https://en.wikibooks.org/wiki/A_Basic_Public_Key_Example ). For convenience I snarfed a printable copy of those six sections into this project.

The Achilles heel of RSA cryptography is that you had to give your public key to somebody, and this step was susceptible to a man-in-the-middle (MITM) attack, partly because the delivery of the public key was done "in the clear" (unencrypted), and partly because the delivery of the public key was a one-time-only operation, so if that step was compromised, all communication thereafter was compromised.

So, if we have time, we could look at the Diffie-Helman-Merkle key exchange protocol, which largely solves the problem of key exchange. Combining public-key/private-cryptography with Diffie-Helman-Merkle key exchange is the foundation of private digital communication. [Diffie and Hellman just won the Turing Award]( http://www.theregister.co.uk/2016/03/01/diffie_and_hellman_scoop_turing_award_for_key_work_on_crypto/ ) for the protocol. (Why was Merkle left out?)

With NSA-level computing resources, keys of length 1024 bits may be breakable. With the same methods, but using even larger keys, private conversations can be kept private. For example, iMessage uses these methods with 1280-bit keys. This is documented in the [iOS Security White Paper]( http://www.apple.com/business/docs/iOS_Security_Guide.pdf ). See page 39. The iOS Security White Paper is pretty easy-going reading given the complexity of the issues.

## Directions Specific to this Problem Set

This is the first of two Problem Sets on RSA cryptography. We need a bunch of utilities involving primes, so that's what you'll build first.
 
Implement the following functions:
 
1. (2 pts) primes(highest: Int) -> [Int]

2. (2 pts) factor(h: Int, candidates: [Int]) -> Int?

3. (2 pts) factors(g: Int, candidates: [Int]) -> [Int]
 
4. (2 pts) factors(g: Int) -> [Int]

5. (2 pts) coprimes(f: Int) -> [Int]
 
If you do them in order and do them correctly, each time you finish a function, some more unit tests will pass.
 
I have created skeleton implementations for each of these functions. They just return nil or an empty array. Those skeleton functions are what you must re-implement.
 
Be sure to read the comments around each function.

The hardest function would have been the first one, but I already implemented a lot of it by implementing sieveOfEratosthenes, which you can just use.
 
## General Directions for all Problem Sets
 
1. Fork this repository to create a repository in your own Github account. Then clone your fork to whatever machine you are working on.
 
2. These problem sets are created with the latest version of Xcode and Mac OS X: Xcode 7.3 and OS X 10.11.4. I haven't tested how well this problem set will work under Xcode 7.2.1, but it probably will.
 
3. Under no circumstances copy-and-paste any part of a solution from another student in the class. Also, under no circumstances ask outsiders on Stack Exchange or other programmers' forums to help you create your solution. It is however fine&mdash;especially when you are truly stuck&mdash;to ask others to help you with your solution, provided you do all of the typing. They should only be looking over your shoulder and commenting. It is of course also fine to peruse StackExchange and whatever other resources you find helfpul.
 
4. Your solution should be clean and exhibit good style. At minimum, Xcode should not flag warnings of any kind. Your style should match Apple's as shown by their examples and declarations. Use the same indentation and spacing around operators as Apple uses. Use their capitalization conventions. Use parts of speech and grammatical number the same way as Apple does. Use descriptive names for variables. Avoid acronyms or abbreviations. I am still coming up to speed on good Swift style. When there appears to be conflict my style and Apple's, copy Apple's, not mine.
 
5. When completed, before the class the problem set is due, commit your changes to your fork of the repository. I should be able to simply clone your fork, build it and execute it in my environment without encountering any warnings, adding any dependencies or making any modifications.
 
###### _The contents of this repository are licensed under the_ [Creative Commons Attribution-ShareAlike License](http://creativecommons.org/licenses/by-sa/3.0/)

*/

// Returns an array of booleans of length highest, where each boolean says whether that number is prime.
func sieveOfEratosthenes(highest: Int) -> [Bool] {
    // Initially the sieve is agnostic as to whether any number is prime or not (initialized to all nil):
    var sieve = [Bool?](count: highest, repeatedValue: nil)
    // By convention, 0 and 1 are not prime, so we can mark those:
    sieve[0] = false
    sieve[1] = false
    var idx = 2
    repeat {
        // Increment the index until we come to one that is not marked:
        while idx < highest && sieve[idx] != nil {
            idx += 1
        }
        // Either we found another prime or we completed the search:
        if idx < highest {
            // found another prime
            sieve[idx] = true
            // now mark all multiples of that prime as non-prime
            var idx2 = 2 * idx
            while idx2 < highest {
                sieve[idx2] = false
                idx2 += idx
            }
        } else {
            // completed the search
            break
        }
    } while true
    return sieve.map { $0! } // this last is just to unwrap Bool? to Bool
}

// This function is easy to create using previous one, and returns the result in a more user-friendly form.
// You just need to return an ascending list of primes using the result from sieveOfEratosthenes
func primes(highest: Int) -> [Int] {
    return []
}

// Given a list of candidate factors, this should return the first factor of h. If none of the candidate factors are factors of h, then return nil.
func factor(h: Int, candidates: [Int]) -> Int? {
    return nil
}

// Given a list of candidate factors, this should return all the factors of g. You just repeatedly call the previous function, and if you get a factor, you append it to the list and divide g by that factor. Repeat until there are no more factors.
func factors(g: Int, candidates: [Int]) -> [Int] {
    return []
}

// This function should first generate a list of primes that are candidates to divide g. HINT: the largest prime that could possibly divide g is less than or equal to the square root of g. Once you have the list of candidates, just call the previous function.
func factors(g: Int) -> [Int] {
    return []
}

// This function returns all coprimes of a given integer f that are smaller than f. Basically, you need to first factor f. Then you need to look at all the numbers in the range 2..<f. For each of those numbers, test whether any of the factors of f divides the number.
func coprimes(f: Int) -> [Int] {
    return []
}

protocol Crypto {
    
    // encrypts plain text and returns cipher text
    func encrypt(plainText: String) -> String
    
    // returns the plain text
    func decrypt(cipherText: String) -> String
    
}

struct PublicKey {
    let encryptionExponent: Int
    let modulus: Int
}

struct PrivateKey {
    let decryptionExponent: Int
    let modulus: Int
}

class RSA: Crypto {
    
    let p: Int // In the article example, the first prime is 5.
    let q: Int // In the article example, the second prime is 11.
    
    init(p: Int, q: Int) {
        self.p = p
        self.q = q
    }
    
    func publicKey() -> PublicKey {
        let modulus = p * q // In the article exapmle, this turns out to be 55.
        let f_n = (p - 1) * (q - 1) // In the article example, this turns out to be 40.
        let coprimeOptions = coprimes(f_n)
        // Here I am just choosing the 2nd value to match up with the document example.
        // I am sure that is weak and evil in practice.
        let encryptionExponent = coprimeOptions.count >= 2 ? coprimeOptions[1] : 0
        return PublicKey(encryptionExponent: encryptionExponent, modulus: modulus)
    }
    
    // The remaining functions are not yet implemented.
    
    func privateKey() -> PrivateKey {
        return PrivateKey(decryptionExponent: 0, modulus: 0)
    }
    
    // encrypts plain text and returns cipher text
    func encrypt(plainText: String) -> String {
        return ""
    }
    
    // returns the plain text
    func decrypt(cipherText: String) -> String {
        return ""
    }
    
}

/*:
The rest of this file contains the unit tests that run automatically as you edit the code. 
*/

import XCTest

class CryptoTestSuite: XCTestCase {
    
    // Test the primes less than 20
    func testPrimes() {
        let expectedPrimes = [2, 3, 5, 7, 11, 13, 17, 19]
        let primesLessThan20 = primes(20)
        XCTAssertEqual(expectedPrimes, primesLessThan20, "Mismatch in list of primes less than 20.")
    }
    
    // Given the candidate factors [3, 8, 11], find an 8 in 1408.
    func testFactorFound() {
        let result = factor(1408, candidates: [3, 8, 11])
        let expectedResult = 8
        XCTAssertEqual(expectedResult, result, "Mismatch in factor in 1408.")
    }
    
    // Given the candidate factors [3, 8, 11], find no factor of 1409.
    func testFactorNotFound() {
        let result = factor(1409, candidates: [3, 8, 11])
        let expectedResult: Int? = nil
        XCTAssertEqual(expectedResult, result, "Mismatch in factor of 1409.")
    }
    
    // Given the candidate factors [3, 8, 11], factor 4224 into 3 * 8 * 8 * 11.
    // the remaining factor of 2 is not among the candidates and will not be found.
    func testFactorsGivenCandidates() {
        let result = factors(4224, candidates: [3, 8, 11])
        let expectedResult = [3, 8, 8, 11]
        XCTAssertEqual(expectedResult, result, "Mismatch in factors of 4224.")
    }
    
    // Fator 4224 into 2 * 3 * 8 * 8 * 11.
    func testFactors() {
        let result = factors(4224)
        let expectedResult = [2, 2, 2, 2, 2, 2, 2, 3, 11]
        XCTAssertEqual(expectedResult, result, "Mismatch in factors of 4224.")
    }
    
    // Test the coprimes of 40.
    func testCoprimes() {
        // These are the expected coprimes of 40 according to the documentation we are following.
        let expectedCoprimes = [3, 7, 9, 11, 13, 17, 19, 21, 23, 27, 29, 31, 33, 37, 39]
        let coprimesOf40 = coprimes(40)
        XCTAssertEqual(expectedCoprimes, coprimesOf40, "Mismatch in list of coprimes of 40.")
    }
    
    // See if we generate the public key given in the example.
    func testPublicKey() {
        let rsa511 = RSA(p: 5, q: 11)
        let expectedPublicKey = PublicKey(encryptionExponent: 7, modulus: 55)
        let publicKey = rsa511.publicKey()
        XCTAssertEqual(expectedPublicKey.encryptionExponent, publicKey.encryptionExponent, "Mismatch in public key encryptionExponent.")
        XCTAssertEqual(expectedPublicKey.modulus, publicKey.modulus, "Mismatch in public key modulus.")
    }

}

/*:
The last bit of arcana is necessary to support the execution of unit tests in a playground, but isn't documented in [Apple's XCTest Library]( https://github.com/apple/swift-corelibs-xctest ). I gratefully acknowledge Stuart Sharpe for sharing it in his blog post, [TDD in Swift Playgrounds]( http://initwithstyle.net/2015/11/tdd-in-swift-playgrounds/ ).
*/

class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(description)")
    }
}

XCTestObservationCenter.sharedTestObservationCenter().addTestObserver(PlaygroundTestObserver())

CryptoTestSuite.defaultTestSuite().runTest()

