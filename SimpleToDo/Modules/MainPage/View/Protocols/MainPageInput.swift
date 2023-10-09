//
//  MainPageInput.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 05.10.2023.
//

import Foundation

protocol MainPageInput: AnyObject {
    func success()
    func failure(error: Error)
}
