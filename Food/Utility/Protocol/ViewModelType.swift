//
//  ViewModelType.swift
//  Food
//
//  Created by J on 2022/12/28.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
