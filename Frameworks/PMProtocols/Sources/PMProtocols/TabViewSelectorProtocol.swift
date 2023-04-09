//
//  File.swift
//  
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import PMCore
import SwiftUI

public protocol TabViewTagProtocol: AnyObject {
    associatedtype TagType: TabViewTagEnumProtocol
    var tagSection: TagType { get set }
    func getBindingTag() -> Binding<Int>
}

public extension TabViewTagProtocol {
    func getBindingTag() -> Binding<Int> {
        .init(
            get: {
                self.tagSection.rawValue
            },
            set: {
                self.tagSection = .init($0) }
        )
    }
}

public protocol TabViewSelectionProtocol: AnyObject {
    func changeTagSelection(_ tag: any TabViewTagEnumProtocol)
    func getTag() -> any TabViewTagEnumProtocol
}


