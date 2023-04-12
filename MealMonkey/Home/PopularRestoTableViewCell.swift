//
//  PopularRestoTableViewCell.swift
//  MealMonkey
//
//  Created by MacBook Pro on 03/04/23.
//

import UIKit

class PopularRestoTableViewCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var foodCategoryLabel: UILabel!
  @IBOutlet weak var restoCategoryLabel: UILabel!
  @IBOutlet weak var ratingCountLabel: UILabel!
  @IBOutlet weak var ratingAverageLabel: UILabel!
  @IBOutlet weak var restoImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
