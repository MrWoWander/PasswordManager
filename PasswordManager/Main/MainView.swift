//
//  ContentView.swift
//  PasswordManager
//
//  Created by Mikhail Ivanov on 01.04.23.
//

import SwiftUI

struct MainView<ViewModel: MainViewViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        TabView(selection: $viewModel.tabSelection) {
            Color(.blue)
                .tabItem {
                    Label("Color", image: "")
                }
                .tag(0)
            viewModel.elementsListView
        }
    }
}
