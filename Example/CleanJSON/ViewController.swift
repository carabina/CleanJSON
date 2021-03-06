//
//  ViewController.swift
//  CleanJSON
//
//  Created by Pircate on 10/12/2018.
//  Copyright (c) 2018 Pircate. All rights reserved.
//

import UIKit
import CleanJSON

struct TestModel<T: Codable>: Codable {
    let boolean: Int
    let integer: Float
    let double: String
    let string: Double
    let array: [String]
    let nested: Nested
    let keyNotFound: T
    let snakeCase: String
    let optional: String?
    
    struct Nested: Codable {
        let a: String
        let b: Bool
        let c: Int
    }
    
    struct NotPresent: Codable {
        let a: String
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let json = """
             {
                 "boolean": true,
                 "integer": 1,
                 "double": -3.14159265358979323846,
                 "string": "string",
                 "array": [1, 2.1, "3", true],
                 "snake_case": "convertFromSnakeCase",
                 "nested": {
                     "a": "alpha",
                     "b": "bravo",
                     "c": "charlie"
                 }
             }
        """.data(using: .utf8)!
        
        do {
            let decoder = CleanJSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(TestModel<Bool>.self, from: json)
            debugPrint(model.boolean)
            debugPrint(model.integer)
            debugPrint(model.double)
            debugPrint(model.string)
            debugPrint(model.array)
            debugPrint(model.nested.a)
            debugPrint(model.nested.b)
            debugPrint(model.nested.c)
            debugPrint(model.keyNotFound)
            debugPrint(model.snakeCase)
            debugPrint(model.optional ?? "nil")
        } catch {
            debugPrint(error)
        }
    }
}

