//
//  sing.swift
//  reproductormusica
//
//  Created by Erik Basto Segovia on 03/09/17.
//  Copyright © 2017 Erik Basto Segovia. All rights reserved.
//

import Foundation

class Sing
{
    var Name: String = ""
    var Cover: String = ""
    var Path : String = ""
    
    init()
    {
        Name = ""
        Cover = ""
        Path = ""
    }
    
    init(name: String, cover: String, path: String)
    {
        self.Name = name
        self.Cover = cover
        self.Path = path
    }
}
