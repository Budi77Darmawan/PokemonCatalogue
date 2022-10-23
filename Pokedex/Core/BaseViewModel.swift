//
//  BaseViewModel.swift
//  Pokedex
//
//  Created by Budi Darmawan on 20/10/22.
//

import Foundation
import RxCocoa

class BaseViewModel {
    let _isLoading = BehaviorRelay<Bool>(value: false)
    let _errorMessage = BehaviorRelay<String?>(value: nil)
    
    var isLoading: Bool { return _isLoading.value }
    var errorMessage: String? { return _errorMessage.value }
}
