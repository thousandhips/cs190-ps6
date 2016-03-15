/*:
# CS 190 Problem Set #6&mdash;RSA Cryptography

[Course Home Page]( http://physics.stmarys-ca.edu/classes/CS190_S16/index.html )

## THIS IS A WORK IN PROGRESS&mdash;PLEASE DELETE YOUR FORK IF YOU ARE SEEING THIS TEXT AND FORK AGAIN IN APRIL.

Due: TBD. Probably will be Tuesday, April 5th, 2016.

## Reading that is Related to this Week's Lectures and/or This Problem Set

For this problem set, we are going to learn Rivest-Shamir-Adleman (RSA) cryptography by implementing _the first six sections_ of the Wikibook [A Basic Public Key Example]( https://en.wikibooks.org/wiki/A_Basic_Public_Key_Example ).

The Achilles heel of RSA cryptography is that you had to give your public key to somebody, and this step was susceptible to a man-in-the-middle (MITM) attack, partly because the delivery of the public key was done "in the clear" (unencrypted), and partly because the delivery of the public key was a one-time-only operation, so if that step was compromised, all communication thereafter was compromised.

So, we should also in this course at some point look at Diffie-Helman-Merkle key exchange protocol, which largely solves the problem of key exchange. Combining public-key/private-cryptography with Diffie-Helman-Merkle key exchange is the foundation of private digital communication. [Diffie and Hellman just won the Turing Award]( http://www.theregister.co.uk/2016/03/01/diffie_and_hellman_scoop_turing_award_for_key_work_on_crypto/ ) for the protocol. I'm not sure why Merkle was left out. [A British Intelligence Engineer]( https://en.wikipedia.org/wiki/James_H._Ellis ) actually discovered the method earlier, but the government's policy was to keep cryptography discoveries secret (e.g., not to publish).

With NSA-level computing resources, keys of length 1024 bits may be breakable. With the same methods, but using even larger keys, private conversations can be kept private. For example, iMessage uses these methods with 1280-bit keys. This is documented in the [iOS Security White Paper]( http://www.apple.com/business/docs/iOS_Security_Guide.pdf ). See page 39. The iOS Security White Paper is pleasant reading.

## Directions Specific to this Problem Set

The rain in Spain stays mainly in the plain.

## Some Utilities Involving Primes

The next two functions are my implementation of the Sieve of Eratosthenes

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

// This function just uses the previous one, and returns the result in a more user-friendly form.
func primes(highest: Int) -> [Int] {
    let sieve = sieveOfEratosthenes(highest)
    var result: [Int] = []
    for var i = 0; i < highest; i += 1 {
        if sieve[i] == true {
            result.append(i)
        }
    }
    return result
}

protocol Crypto {
    
    // encrypts plain text and returns cipher text
    func encrypt(plainText: String) -> String
    
    // returns the plain text
    func decrypt(cipherText: String) -> String
    
}

class RSA: Crypto {
    
    // So far this class is completely unfinished.
    
    let p: Int // In the article example, the first prime is 5
    let q: Int // In the article example, the second prime is 11
    
    // This is the first time we have used a computed property.
    // Since the computation of the modulus m might be expensive, try
    // not to do it repeatedly. E.g., don't access self.m inside a loop.
    var m: Int { return p * q } // In the article example, the modulus is 55.
    
    // The documentation we are following calls this f(n). What is n???
    var f: Int { return (p - 1) * (q - 1) }
    
    init(p: Int, q: Int) {
        // This is the first tiem we have used we have used self for disambiguation.
        self.p = p
        self.q = q
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

class SieveTestSuite: XCTestCase {
    
    // Test the primes less than 20
    func testPrimesLessThan20() {
        let expectedPrimes = [2, 3, 5, 7, 11, 13, 17, 19]
        let primesLessThan20 = primes(20)
        XCTAssertEqual(expectedPrimes, primesLessThan20, "Mismatch in list of primes less than 20.")
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

SieveTestSuite.defaultTestSuite().runTest()

