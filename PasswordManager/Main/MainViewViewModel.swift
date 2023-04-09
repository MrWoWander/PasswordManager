//
//  MainViewViewModel.swift
//  PasswordManager
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import SwiftUI
import ElementsListFeature

// sourcery: AutoMockable
protocol MainViewViewModelProtocol: ObservableObject {
    var tabSelection: Int { get set }
    var elementsListView: AnyView { get }
}

final class MainViewViewModel: MainViewViewModelProtocol {
    init() { print("init") }
    @Published var tabSelection: Int = 0

    var elementsListView: AnyView { AnyView(elementsListViewAny) }

    var elementsListViewAny: some View {
        createElementsListView()
            .tabItem {
                Label("Elements List", image: "")
            }.tag(1)
    }
}

private extension MainViewViewModel {
    func createElementsListView() -> AnyView {
        let deps = ElementsListFeatureFactoryDependenciesFactory()
        let factory = ElementsListFeatureFactory(dependencies: deps)
        let view = factory.createElementsListViewFactory().build()
        return view
    }
}
