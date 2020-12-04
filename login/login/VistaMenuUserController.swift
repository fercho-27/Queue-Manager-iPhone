//
//  VistaMenuUserController.swift
//  GestorColas
//
//  Created by RedMineSS on 25/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit
import QuartzCore

class VistaMenuUserController: UIViewController {
    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var etiquetaUsuario: UILabel!
    @IBOutlet weak var botonSacar: UIButton!
    @IBOutlet weak var etiquetaSacar: UILabel!
    @IBOutlet weak var botonVer: UIButton!
    @IBOutlet weak var etiquetaVer: UILabel!
    @IBOutlet weak var botonsalir: UIButton!
    @IBOutlet weak var botonAdvertencia: UIButton!
    @IBOutlet weak var etiquetaSalir: UILabel!
    @IBOutlet weak var botonContraseña: UIButton!
    @IBOutlet weak var etiquetaContraseña: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Estoy en la otra vista USUARIO MENU HOLA PAPU")
        
        botonSacar.addTarget(self, action: #selector(eventoSacar), for: UIControlEvents.touchUpInside)
        
        botonVer.addTarget(self, action: #selector(eventoVer), for: UIControlEvents.touchUpInside)
        
        botonContraseña.addTarget(self, action: #selector(eventoCambiarContraseña), for: UIControlEvents.touchUpInside)
        
        botonsalir.addTarget(self, action: #selector(eventoSalir), for: UIControlEvents.touchUpInside)
        
        botonAdvertencia.addTarget(self, action: #selector(eventoAdvertencia), for: UIControlEvents.touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func eventoSacar(){
        print("Sacar ficha")
        let viewController:UIViewController = UIStoryboard(name: "VistaSacarFicha", bundle: nil).instantiateViewController(withIdentifier: "VistaSacarFicha") as UIViewController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func eventoVer(){
        print("Ver ficha")
        let viewController:UIViewController = UIStoryboard(name: "VistaVerFicha", bundle: nil).instantiateViewController(withIdentifier: "VistaVerFicha") as UIViewController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func eventoCambiarContraseña(){
        print("Cambiar contraseña")
    }
    
    @objc func eventoSalir(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func eventoAdvertencia(){
        print("Imprimiste el boton de Advertencia")
        print("Se implementara despues")
    }
    
}

