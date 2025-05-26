//
//  viewModel.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/5/24.
//

import Combine

class MVVMUserViewModel: ObservableObject {
    @Published var user = User(name: "Jimmy")
    
    func changeName() {
        user.name = "Jimmy \(Int.random(in: 1...100))"
    }
}
