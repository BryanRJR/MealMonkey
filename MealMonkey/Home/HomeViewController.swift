//
//  HomeViewController.swift
//  MealMonkey
//
//  Created by MacBook Pro on 03/04/23.
//

import UIKit

class HomeViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  weak var mostPopularCollectionView: UICollectionView?
  weak var foodCollectionView: UICollectionView?


  enum Section {
    case location
    case search
    case popular
    case mostPopular
    case foodCategory


  }

  var sections: [Section] = [.location, .search, .foodCategory, .popular, .mostPopular]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      setup()
    }
    
  func setup() {
    tableView.dataSource = self
    tableView.delegate = self
  }

  @objc func showPopularResto(_ sender: Any) {
    showPopularRestosViewCOntroller()
  }
}

extension HomeViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let value = sections[section]
    switch value {
    case .location:
      return 1
    case .search:
      return 1
    case .foodCategory:
      return 1
    case .popular:
      return 3
    case .mostPopular:
      return 1


    }

  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let value = sections[indexPath.section]
    switch value {
    case .location:
      return tableView.dequeueReusableCell(withIdentifier: "location_cell", for: indexPath)
    case .search:
      return tableView.dequeueReusableCell(withIdentifier: "search_cell", for: indexPath)
    case .foodCategory:
      let foodCell = tableView.dequeueReusableCell(withIdentifier: "food_category", for: indexPath) as! FoodCategoryViewCell

      foodCell.foodCollectionView.dataSource = self
      foodCell.foodCollectionView.delegate = self
      foodCell.foodCollectionView.reloadData()
      self.foodCollectionView = foodCell.foodCollectionView

      return foodCell
    case .popular:
      return tableView.dequeueReusableCell(withIdentifier: "popular_resto_cell", for: indexPath)
    case .mostPopular:
      let cell = tableView.dequeueReusableCell(withIdentifier: "most_popular_resto_cell", for: indexPath) as! MostPopularRestoViewCell

      cell.collectionView.dataSource = self
      cell.collectionView.delegate = self
      cell.collectionView.reloadData()
      self.mostPopularCollectionView = cell.collectionView
      return cell

    }
  }


}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let value = sections[section]
    switch value {
    case .popular, .mostPopular, .foodCategory:
      let view = UIView(frame: .zero)

      let label = UILabel(frame: .zero)
      label.textColor = UIColor(named: "PrimaryText")
      label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

      view.addSubview(label)

      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
      ])

      let button = UIButton(type: .system)
      button.tintColor = UIColor(named: "Main")
      button.setTitle("See All", for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
      view.addSubview(button)

      button.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])

      switch value {
      case .popular:
        label.text = "Popular Restaurants"
        button.addTarget(self, action: #selector(self.showPopularResto(_:)), for: .touchUpInside)
      case .mostPopular:
        label.text = "Most Popular"
      case.foodCategory:
        label.text = "Food Near You"
      default:
        break
      }

      return view

    default:
      return nil
    }
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let value = sections[section]
    switch value {
    case .popular, .mostPopular, .foodCategory:
      return 64
    default:
      return 0.0001
    }
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.0001
  }
}

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == self.mostPopularCollectionView {
      return 5
    } else {
      return 10
    }

  }


  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == self.mostPopularCollectionView {
      return collectionView.dequeueReusableCell(withReuseIdentifier: "resto_cell", for: indexPath)
    } else {
      return collectionView.dequeueReusableCell(withReuseIdentifier: "food_cell", for: indexPath)
    }
  }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == self.mostPopularCollectionView {
      
      return CGSize(width: 228, height: 180)
    } else {
      return CGSize(width: 88, height: 120)
    }

  }

}





