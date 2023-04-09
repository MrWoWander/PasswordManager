//
//  File.swift
//  
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import SwiftUI

// sourcery: AutoMockable
protocol ElementsListViewDependenciesProtocol: AnyObject {}

final class ElementsListViewDependencies: ElementsListViewDependenciesProtocol {
    private let deps: ElementsListFeatureFactoryDependenciesFactoryProtocol

    init(deps: ElementsListFeatureFactoryDependenciesFactoryProtocol) {
        self.deps = deps
    }
}
