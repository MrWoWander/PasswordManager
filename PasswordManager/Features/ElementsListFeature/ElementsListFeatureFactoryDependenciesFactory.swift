//
//  ElementsListFeatureFactoryDependenciesFactory.swift
//  PasswordManager
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import PMProtocols
import ElementsListFeature

final class ElementsListFeatureFactoryDependenciesFactory: ElementsListFeatureFactoryDependenciesFactoryProtocol {
    private let tabViewSelectionViewModel: TabViewSelectionProtocol?

    init(tabViewSelectionViewModel: TabViewSelectionProtocol?) {
        self.tabViewSelectionViewModel = tabViewSelectionViewModel
    }

    func getTabViewSelectionViewModel() -> TabViewSelectionProtocol? {
        tabViewSelectionViewModel
    }
}
