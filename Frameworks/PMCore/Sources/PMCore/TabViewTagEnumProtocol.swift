//
//  TabViewTagEnumProtocol.swift
//  
//
//  Created by Mikhail Ivanov on 09.04.23.
//

public protocol TabViewTagEnumProtocol: RawRepresentable<Int>, CaseIterable {
    init(_ tag: Int)
}

public extension TabViewTagEnumProtocol {
    init(_ tag: Int) {
        if Self.allCases.isEmpty {
            assertionFailure()
        }
        let item = Self.allCases.first(where: { $0.rawValue == tag })
        self = item ?? Self.allCases[Self.allCases.startIndex]
    }
}
