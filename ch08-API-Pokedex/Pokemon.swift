//
//  Pokemon.swift
//  ch08-API-Pokedex
//
//  Created by Stanley on 5/24/16.
//  Copyright © 2016 Stanley. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextevolutionTxt: String!
    private var _nextevolutionId: String!
    private var _nextevolutionLvl: String!
    private var _pokemonUrl: String!
    private var _moves: String!
    
    var description: String {
        
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextevolutionTxt: String {
        
        if _nextevolutionTxt == nil {
            _nextevolutionTxt = ""
        }
        return _nextevolutionTxt
    }
    
    var nextevolutionId: String {
        
        if _nextevolutionId == nil {
            _nextevolutionId = ""
        }
        return _nextevolutionId
    }
    
    var nextevolutionLvl: String {
        get {
            if _nextevolutionLvl == nil {
                _nextevolutionLvl = ""
            }
            return _nextevolutionLvl
        }
    }
    
    var moves: String {
        if _moves == nil {
            _moves = ""
        }
        return _moves
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                     }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"]{
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                }
                            }
                            
                            completed()
                        }
                    }
                
                } else {
                    self._description = ""
                }
                print(dict)
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>]
                where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {

                        //Ninetails,Electabuzz, Jynx, Starmie shows next evolutions
                        //Possible API error, info is incorrect
                        if dict["name"] as? String == "Ninetales" || dict["name"] as? String == "Starmie"
                        || dict["name"] as? String == "Jynx" || dict["name"] as? String == "Electabuzz" {
                            return
                        }
                        
                        //Can't support mega pokemon right now but
                        //api still has mega data
                        if to.rangeOfString("mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextevolutionId = num
                                self._nextevolutionTxt = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextevolutionLvl = "\(lvl)"
                                }
                            }
                        }
                    }
                    
                }
                if let moves = dict["moves"] as? [Dictionary<String, AnyObject>] where moves.count > 0 {
                    
                    if let name = moves[0]["name"] {
                        self._moves = " 1. " + (name as! String)
                    }
                    
                    if moves.count > 1 {
                        for var x = 1; x < moves.count; x++ {
                            if let name = moves[x]["name"] {
                                self._moves! += "\n \(x + 1). \(name)"
                            }
                        }
                    }
                }
            }
        }
    }
}