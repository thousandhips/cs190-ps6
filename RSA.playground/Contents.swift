/*:
# CS 190 Problem Set #6&mdash;RSA Cryptography

[Course Home Page]( http://physics.stmarys-ca.edu/classes/CS190_S16/index.html )

[My St. Mary's Home Page]( http://physics.stmarys-ca.edu/lecturers/brianrhill/index.html )

Due: Tuesday, March 29th, 2016.

## Reading that is Related to this Week's Lectures and/or This Problem Set

### Cryptography

For this problem set, we are going to learn Rivest-Shamir-Adleman (RSA) cryptography by implementing _the first six sections_ of the Wikibook [A Basic Public Key Example]( https://en.wikibooks.org/wiki/A_Basic_Public_Key_Example ).

The Achilles heal of RSA cryptography is that you had to give your public key to somebody, and this step was susceptible to a man-in-the-middle (MITM) attack, partly because the delivery of the public key was done "in the clear" (unencrypted), and partly because the delivery of the public key was a one-time operation, so if that step was compromised, everything that occurred thereafter was compromised.

So, we should also in this course at some point look at Diffie-Helman-Merkle key exchange protocol, which largely solves the problem of key exchange. Combining public-key/private-cryptography with Diffie-Helman-Merkle key exchange is the foundation of private digital communication.

With NSA-level computing resources, keys of length 1024 bits may be breakable. With the same methods, but using even larger keys, private conversations can be kept private. For example, iMessage uses these methods with 1280-bit keys. This is documented in the [iOS Security White Paper]( http://www.apple.com/business/docs/iOS_Security_Guide.pdf ). See page 39.

## Directions Specific to this Problem Set

Here is the protocol from last time:

*/

protocol Crypto {
    
    // encrypts plain text and returns cipher text
    func encrypt(plainText: String) -> String
    
    // returns the plain text
    func decrypt(cipherText: String) -> String
    
}

class RSA: Crypto {
}

/*:
The rest of this file contains the unit tests that run automatically as you edit the code. You shouldn't have to mess with the unit tests unless I made a mistake writing them.
*/

import XCTest

class RSATestSuite: XCTestCase {
    
    // Mary Poppins
    func testRSA13EncryptAllCaps() {
        let crypto = RSA() as Crypto
        let plainText = "SUPERCALIFRAGILISTICEXPIALIDOCIOUS"
        let cipherText = crypto.encrypt(plainText)
        let expectedCipherText = "FHCREPNYVSENTVYVFGVPRKCVNYVQBPVBHF"
        XCTAssertEqual(expectedCipherText, cipherText, "Oh-oh.")
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

RSATestSuite.defaultTestSuite().runTest()

