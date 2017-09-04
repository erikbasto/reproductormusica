//
//  ViewController.swift
//  reproductormusica
//
//  Created by Erik Basto Segovia on 02/09/17.
//  Copyright © 2017 Erik Basto Segovia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var playList = [Sing]()
    private var player: AVAudioPlayer!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var playListPicker: UIPickerView!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //load data into array
        playList.append(Sing(name: "Vivaldi - Four Seasons (Winter)", cover: "vivaldi", path: "Vivaldi-FourSeasons-Winter"))
        playList.append(Sing(name: "Epica - Universal Death Squad", cover: "epica", path: "Epica-UniversalDeathSquad"))
        playList.append(Sing(name: "Beethoven - 5ta Sinfonia", cover: "beethoven", path: "Beethoven-QuintaSinfonia"))
        playList.append(Sing(name: "Wagner - Cabalgata de las Valquirias", cover: "wagner", path: "Wagner-CabalgataValquirias"))
        playList.append(Sing(name: "Queen - Bohemian Rhapsody", cover: "queen", path: "Queen-BohemianRhapsody"))
        playList.append(Sing(name: "LoR - Knife in the Dark", cover: "lor", path: "LoR-KnifeInDark"))
        
        //delegates
        self.playListPicker.delegate = self
        self.playListPicker.dataSource = self
        
        //audioplayer
        let soundUrl = Bundle.main.url(forResource: "Vivaldi-FourSeasons-Winter", withExtension: "mp3")
        do{
            try player = AVAudioPlayer(contentsOf: soundUrl!)
        }catch{
            print("No se cargo el archivo.")
        }
        
        volumeSlider.setValue(0.5, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //numero de columnas de informacion
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //numero de filas en el arreglo
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return playList[row].Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        LoadSong(position: row)
    }

    @IBAction func Play(_ sender: Any) {
        if(!player.isPlaying)
        {
            player.play()
        }
    }

    @IBAction func Pause(_ sender: Any) {
        if(player.isPlaying)
        {
            player.pause()
        }
    }

    @IBAction func Stop(_ sender: Any) {
        if(player.isPlaying)
        {
            player.stop()
            player.currentTime = 0.0
        }
    }

    @IBAction func Shuffle(_ sender: Any) {
        let index: Int = Int(arc4random_uniform(6))
        playListPicker.selectRow(index, inComponent: 0, animated: true)
    }
    
    @IBAction func volumeDidChange(_ sender: Any){
        player.volume = volumeSlider.value
    }
    
    
    func LoadSong(position: Int)
    {
        nameLabel.text = playList[position].Name
        coverImage.image = UIImage(named: playList[position].Cover)
        
        let soundUrl = Bundle.main.url(forResource:playList[position].Path, withExtension: "mp3")
        do{
            try player = AVAudioPlayer(contentsOf: soundUrl!)
        }catch{
            let alert = UIAlertController(title: "Aviso", message: "No se ha cargado el audio. Favor de reintentar más tarde.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.Play(self)
        
    }
   
}

