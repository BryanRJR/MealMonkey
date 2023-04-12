//
//  PopularRestosViewController.swift
//  MealMonkey
//
//  Created by MacBook Pro on 10/04/23.
//

import UIKit
import Kingfisher

class PopularRestosViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!

  @IBOutlet weak var segmentedControl: UISegmentedControl!

  var allRestos: [Restaurant] = []
  weak var refresh: UIRefreshControl!
  var restos: [Restaurant] = []
  var categories: [String] = [
    "All",
    "Western",
    "Indian",
    "Coffee",
    "Italian",
    "Sri Lankan",
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    setup()
    refresh.beginRefreshing()
    loadRestos()
  }

  func loadRestos() {
    ApiService.shared.loadPopularRestos { [weak self] (restos) in
      self?.refresh.endRefreshing()
      self?.allRestos = restos
      self?.filterRestos()
      self?.collectionView.reloadData()
    }
  }
    
  func setup() {
    title = "Popular Restaurants"
    collectionView.dataSource = self
    collectionView.delegate = self

    let refreshControl = UIRefreshControl()
    collectionView.refreshControl = refreshControl
    self.refresh = refreshControl
    refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)

    segmentedControl.removeAllSegments()
    for i in 0..<categories.count {
      segmentedControl.insertSegment(withTitle: categories[i], at: i, animated: false)
    }
    segmentedControl.selectedSegmentIndex = 0
  }

  func filterRestos() {
    let category = categories[segmentedControl.selectedSegmentIndex]
    if category == "All" {
      restos = allRestos
    } else {
      restos = allRestos.filter({ restaurant in
        return restaurant.categoryName == category
      })
    }
  }

  @IBAction func filterChanged(_ sender: Any) {
    filterRestos()
    collectionView.reloadData()
  }

  @objc func refresh(_ sender: Any) {
    loadRestos()
  }

}

extension PopularRestosViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return restos.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resto_cell", for: indexPath) as! PopularRestosItemViewCell

    let resto = restos[indexPath.item]
    cell.imageView.kf.setImage(with: URL(string: resto.imageUrl))
    cell.nameLabel.text = resto.name
    cell.ratingLabel.text = "4.8"
    cell.restoCategoryLabel.text = "Café"
    cell.foodCategoryLabel.text = resto.categoryName

    return cell
  }
}

extension PopularRestosViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 12
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 12
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let column: CGFloat = 2
    let spacing: CGFloat = 12
    let inset: CGFloat = 20
    let screenWidth = UIScreen.main.bounds.width
    let totalWidth = screenWidth - (2 * inset) - ((column - 1) * spacing)
    let width = floor(totalWidth / column)

    return CGSize(width: width, height: width)
  }
}

extension UIViewController {
  func showPopularRestosViewCOntroller() {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "PopularRestosViewController") as! PopularRestosViewController

    navigationController?.pushViewController(viewController, animated: true)
  }
}
