//
//  MainViewDependencies.swift
//  PasswordManager
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import ElementsListFeature
import PMProtocols
import SwiftUI

protocol MainDependenciesProtocol: AnyObject {
    var tabViewSelectionViewModel: TabViewSelectionProtocol? { get set }
    func createElementsListView() -> AnyView
}

final class MainDependencies: MainDependenciesProtocol {
    weak var tabViewSelectionViewModel: TabViewSelectionProtocol?

    func createElementsListView() -> AnyView {
        let deps = ElementsListFeatureFactoryDependenciesFactory(
            tabViewSelectionViewModel: tabViewSelectionViewModel
        )
        let factory = ElementsListFeatureFactory(dependencies: deps)
        let view = factory.createElementsListViewFactory().build()
        return view
    }
}
