//
//  NYTModule.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import core_architecture

struct NYTViewModule<V: ViewProtocol>: ViewModuling {
    typealias ViewType = V
    private var input: ModuleInput
    init(input: ModuleInput) {
        self.input = input
    }
    
    struct ModuleInput: ModulingInput {
        let vm: V.ViewModelType
    }
    func view() -> V {
        V(
            viewModel: input.vm
        )
    }
}
