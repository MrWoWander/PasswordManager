//
//  File.swift
//  
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import PMProtocols
import SwiftUI

final class ElementsListViewFactory: FactoryViewProtocol {
    private let deps: ElementsListViewDependenciesProtocol

    init(deps: ElementsListViewDependenciesProtocol) {
        self.deps = deps
    }

    func build() -> AnyView {
        let viewModel = ElementsListViewViewModel()
        let view = ElementsListView(viewModel: viewModel)
        return .init(view)
    }
}
