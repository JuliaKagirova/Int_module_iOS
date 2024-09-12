//
//  Mapper.swift
//  Navigation
//
//  Created by Юлия Кагирова on 18.04.2024.
//

import Foundation

protocol IMapper {
    func serialize(_data: Data, completion: @escaping([String: Any]) -> Void)
}
