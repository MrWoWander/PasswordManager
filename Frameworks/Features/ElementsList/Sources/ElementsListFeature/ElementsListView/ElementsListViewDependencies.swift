//
//  File.swift
//  
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import PMProtocols
import SwiftUI

// sourcery: AutoMockable
protocol ElementsListViewDependenciesProtocol: AnyObject {
    func getTabViewSelectionViewModel() -> TabViewSelectionProtocol?
}

final class ElementsListViewDependencies: ElementsListViewDependenciesProtocol {
    private let deps: ElementsListFeatureFactoryDependenciesFactoryProtocol

    init(deps: ElementsListFeatureFactoryDependenciesFactoryProtocol) {
        self.deps = deps
    }

    func getTabViewSelectionViewModel() -> TabViewSelectionProtocol? {
        deps.getTabViewSelectionViewModel()
    }
}
