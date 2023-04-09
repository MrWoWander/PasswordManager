//
//  ContentView.swift
//  PasswordManager
//
//  Created by Mikhail Ivanov on 01.04.23.
//

import SwiftUI
import MainModels

struct MainView<ViewModel: MainViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        TabView(selection: viewModel.tag) {
            Color(.blue)
                .tabItem {
                    Label("Color", image: "")
                }
                .tag(MainTabSections.color.rawValue)
            viewModel.elementsListView
                .tabItem {
                    Label("ElementsListView", image: "")
                }
                .tag(MainTabSections.elementsList.rawValue)
        }
    }
}
