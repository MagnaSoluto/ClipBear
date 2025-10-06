#!/usr/bin/env swift

// Simple test to verify basic Swift syntax
import Foundation

print("✅ Basic Swift compilation working")

// Test string interpolation
let testString = "Hello, World!"
print("✅ String interpolation: \(testString)")

// Test basic data structures
let testArray = [1, 2, 3, 4, 5]
print("✅ Array creation: \(testArray)")

let testDict: [String: Any] = ["key": "value", "number": 42]
print("✅ Dictionary creation: \(testDict)")

// Test basic functions
func testFunction() -> String {
    return "Function works!"
}

print("✅ Function call: \(testFunction())")

print("🎉 Basic Swift functionality verified!")
