//
//  File.swift
//  
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import PMProtocols
import SwiftUI

public final class ElementsListFeatureFactory {
    private let dependencies: ElementsListFeatureFactoryDependenciesFactoryProtocol

    public init(dependencies: ElementsListFeatureFactoryDependenciesFactoryProtocol) {
        self.dependencies = dependencies
    }

    public func createElementsListViewFactory() -> FactoryViewProtocol {
        ElementsListViewFactory(deps: ElementsListViewDependencies(deps: dependencies))
    }
}
