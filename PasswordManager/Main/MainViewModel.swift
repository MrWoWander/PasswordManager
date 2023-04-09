//
//  MainViewViewModel.swift
//  PasswordManager
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import MainModels
import PMCore
import PMProtocols
import ElementsListFeature
import SwiftUI

// sourcery: AutoMockable
protocol MainViewModelProtocol: ObservableObject, TabViewTagProtocol, TabViewSelectionProtocol {
    var elementsListView: AnyView { get }
    var tag: Binding<Int> { get }
}

final class MainViewModel: MainViewModelProtocol {
    var tagSection: MainTabSections = .elementsList {
        didSet {
            tag.wrappedValue = tagSection.rawValue
        }
    }
    lazy var elementsListView: AnyView = deps.createElementsListView()

    lazy var tag: Binding<Int> = getBindingTag()

    private let deps: MainDependenciesProtocol

    init(deps: MainDependenciesProtocol) {
        self.deps = deps
        deps.tabViewSelectionViewModel = self
    }
}

extension MainViewModel {
    func changeTagSelection(_ tag: any TabViewTagEnumProtocol) {
        guard let tag = tag as? MainTabSections else { return }
        tagSection = tag
    }

    func getTag() -> any TabViewTagEnumProtocol {
        tagSection
    }
}
