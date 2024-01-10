//
//  CollectionViewCellUIProtocol.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/10/24.
//

import Foundation

protocol CollectionViewCellUIProtocol: AnyObject {
    static var identifier: String { get set }
    func configureCollectionViewCellUI()
}
