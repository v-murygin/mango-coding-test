//
//  DependencyError.swift
//  
//
//  Created by Vladislav on 1/29/23.
//

import Foundation

enum DependencyError: Error {
    case itemAlreadyExists
    case itemNotFound
    case circularDependency
    
    public var description: String {
        switch self {
        case .itemAlreadyExists:
            return "Item already exist in the dependencies."
        case .itemNotFound:
            return "Item not found."
        case .circularDependency:
            return "Circular dependency."
        }
    }
}
