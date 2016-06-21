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
    @IBOutlet weak var mainIMG: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!

    @IBOutlet weak var currentevolveIMG: UIImageView!
    
    @IBOutlet weak var nextevolveIMG: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
        mainIMG.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
            
        }
    }
    

    @IBAction func backBTNpressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
