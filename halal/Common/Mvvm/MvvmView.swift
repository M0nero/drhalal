//
//  MvvmView.swift
//  halal
//
//  Created by Damir Akbarov on 16.04.2023.
//

//import SwiftUI
//import Combine
//
//protocol Mvvm {
//    associatedtype ViewModel
//    associatedtype View
//    var disposables: Set<AnyCancellable> { get }
//    var viewModel: ViewModel! { get }
//}

//struct MvvmView<TViewModel: ViewModel>: View, Mvvm, GridConstants {
//
//    var disposables: Set<AnyCancellable> = Set<AnyCancellable>()
//    private var _viewModel: TViewModel?
//
//    var viewModelProvider: () -> TViewModel? = {
//        (UIApplication.shared.delegate as? AppDelegate)?.diContainer.resolve(TViewModel.self)
//    }
//
//    var viewModel: TViewModel! { _viewModel }
//
//    typealias ViewModel = TViewModel
//    typealias View = MvvmView<TViewModel>
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        _viewModel = viewModelProvider()
//    }
//}

