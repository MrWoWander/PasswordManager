//
//  MainViewFactory.swift
//  PasswordManager
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import PMProtocols
import SwiftUI

final class MainViewFactory: FactoryViewProtocol {
    func build() -> AnyView {
        let viewModel = MainViewViewModel()
        let view = MainView(viewModel: viewModel)
        return .init(view)
    }
}
