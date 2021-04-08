//
//  AnswersCell.swift
//  Millionaire
//
//  Created by Daniil Kniss on 07.04.2021.
//

import UIKit

class AnswersCell: UITableViewCell {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var textFieldA: UITextField!
    @IBOutlet weak var textFieldB: UITextField!
    @IBOutlet weak var textFieldC: UITextField!
    @IBOutlet weak var textFieldD: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
