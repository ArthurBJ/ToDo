//
//  DetailPageInput.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 06.10.2023.
//

import Foundation

protocol DetailPageInput: AnyObject {
    func success()
    func failure(error: Error)
}
