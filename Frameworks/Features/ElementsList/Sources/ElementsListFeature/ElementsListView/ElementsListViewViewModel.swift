//
//  File.swift
//  
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import PMProtocols
import MainModels
import SwiftUI

// sourcery: AutoMockable
protocol ElementsListViewViewModelProtocol: ObservableObject {
    func changeSelection(_ tag: MainTabSections)
}

final class ElementsListViewViewModel: ElementsListViewViewModelProtocol {
    private weak var tabViewSelectionViewModel: TabViewSelectionProtocol?

    init(tabViewSelectionViewModel: TabViewSelectionProtocol?) {
        self.tabViewSelectionViewModel = tabViewSelectionViewModel
    }

    func changeSelection(_ tag: MainTabSections) {
        tabViewSelectionViewModel?.changeTagSelection(tag)
    }
}
