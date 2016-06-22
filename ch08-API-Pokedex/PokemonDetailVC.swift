//
//  PokemonDetailVC.swift
//  ch08-API-Pokedex
//
//  Created by Stanley on 6/8/16.
//  Copyright © 2016 Stanley. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var segmentcontroller: UISegmentedControl!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainIMG: UIImageView!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentevolveIMG: UIImageView!
    @IBOutlet weak var nextevolveIMG: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainIMG.image = img
        currentevolveIMG.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        pokedexLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        baseAttack.text = pokemon.attack
        
        if pokemon.nextevolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextevolveIMG.hidden = true
        } else {
            nextevolveIMG.hidden = false
            nextevolveIMG.image = UIImage(named: pokemon.nextevolutionId)
            var str = "Next Evolution: \(pokemon.nextevolutionTxt)"
            
            if pokemon.nextevolutionLvl != "" {
                str += " - LVL \(pokemon.nextevolutionLvl)"
            }
            evoLbl.text = str
        }
        
    }
    

    @IBAction func backBTNpressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func segControlChange(sender: AnyObject) {
        
        if segmentcontroller.selectedSegmentIndex == 0 {
            descriptionLbl.text = pokemon.description
        }
        if segmentcontroller.selectedSegmentIndex == 1 {
            descriptionLbl.text = pokemon.moves
        }
    }
}
