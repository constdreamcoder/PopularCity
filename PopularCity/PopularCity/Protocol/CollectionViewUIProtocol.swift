//
//  CollectionViewUIProtocol.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/10/24.
//

import Foundation

protocol CollectionViewUIProtocol: AnyObject {
    func registerCollectionViewCell()
    func setDelegateAndDatasource()
    func configureCollectionViewLayout()
}
