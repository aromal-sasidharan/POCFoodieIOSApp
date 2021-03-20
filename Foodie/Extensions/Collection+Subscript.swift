//
//  Collections+Subscript.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation


public extension Collection {
    private func distance(from startIndex: Index) -> IndexDistance {
        return distance(from: startIndex, to: self.endIndex)
    }
    
    private func distance(to endIndex: Index) -> IndexDistance {
        return distance(from: self.startIndex, to: endIndex)
    }
    
    subscript(safe index: Index) -> Iterator.Element? {
        if distance(to: index) >= 0 && distance(from: index) > 0 {
            return self[index]
        }
        return nil
    }
    
    subscript(safe bounds: Range<Index>) -> SubSequence? {
        if distance(to: bounds.lowerBound) >= 0 && distance(from: bounds.upperBound) >= 0 {
            return self[bounds]
        }
        return nil
    }
    
    subscript(safe bounds: ClosedRange<Index>) -> SubSequence? {
        if distance(to: bounds.lowerBound) >= 0 && distance(from: bounds.upperBound) > 0 {
            return self[bounds]
        }
        return nil
    }
}
