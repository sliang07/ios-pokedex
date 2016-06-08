//
//  PokemonDetailVC.swift
//  ch08-API-Pokedex
//
//  Created by Stanley on 6/8/16.
//  Copyright © 2016 Stanley. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
    }
    

}
