//
//  PopularCityViewController.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/9/24.
//

import UIKit
import Kingfisher

final class PopularCityViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    let wholeCityList: [City] = CityInfo().city
    var sortedCityList: [City] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTopViewUI()
        configureCollectionView()
        
        initializeCityList()
    }
    
    // MARK: - UI Methods
    private func configureTopViewUI() {
        topImageView.image = UIImage(systemName: "ellipsis")
        topImageView.tintColor = .lightGray
        topImageView.contentMode = .scaleAspectFit
        
        topTitleLabel.text = "인기 도시"
        topTitleLabel.textAlignment = .center
        topTitleLabel.font = .systemFont(ofSize: 22.0, weight: .bold)
        
        separatorView.backgroundColor = .systemGray5
    }
    
    private func configureCollectionView() {
        
        registerCollectionViewCell()
        
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        configureCollectionViewLayout()
        
        cityCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func registerCollectionViewCell() {
        let xib = UINib(nibName: PopularCityCollectionViewCell.identifier, bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: PopularCityCollectionViewCell.identifier)
    }
    
    private func configureCollectionViewLayout() {
        let spacing: CGFloat = 24
        
        let layout = UICollectionViewFlowLayout()
        let itemSize = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: itemSize / 2, height: (itemSize / 2) * 1.5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        cityCollectionView.collectionViewLayout = layout
    }
    
    private func initializeCityList() {
        sortedCityList = wholeCityList
    }
    
    // MARK: - CollectionView Delegate, DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedCityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCityCollectionViewCell.identifier, for: indexPath) as! PopularCityCollectionViewCell
        
        let city = sortedCityList[indexPath.item]
        
        let imageUrl = URL(string: city.city_image)
        cell.cityImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "no_image"))
        cell.cityNameLabel.text = "\(city.city_name) | \(city.city_english_name)"
        cell.cityDescriptionLabel.text = city.city_explain

        // 방법 1
//        DispatchQueue.main.async {
//            cell.cityImageView.layer.cornerRadius = cell.cityImageView.frame.width / 2
//        }

        return cell
    }
    
    // MARK: - User Event Methods
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        guard let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
        
        initializeCityList()
        
        if selectedTitle == SegmentControlTitle.domestic.rawValue {
            sortedCityList = wholeCityList.filter { $0.domestic_travel }
        } else if selectedTitle == SegmentControlTitle.overseas.rawValue {
            sortedCityList = wholeCityList.filter { $0.domestic_travel == false }
        }
        
        cityCollectionView.reloadData()
    }
}