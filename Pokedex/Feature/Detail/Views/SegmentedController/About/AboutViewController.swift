//
//  AboutViewController.swift
//  Pokedex
//
//  Created by Budi Darmawan on 23/10/22.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemon: PokemonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon?.name?.capitalized
        heightLabel.text = String(pokemon?.height ?? 0)
        weightLabel.text = String(pokemon?.weight ?? 0)
        typesLabel.text = pokemon?.types?.joined(separator: ", ")
        abilitiesLabel.text = pokemon?.abilities?.joined(separator: ", ")
    }

}
