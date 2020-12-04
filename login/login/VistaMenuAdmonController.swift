//
//  VistaController.swift
//  login
//
//  Created by RedMineSS on 07/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit
import QuartzCore

class VistaMenuAdmonController: UIViewController {
    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var etiquetaAdmon: UILabel!
    @IBOutlet weak var botonFila: UIButton!
    @IBOutlet weak var etiquetaCrear: UILabel!
    @IBOutlet weak var botonAdministrar: UIButton!
    @IBOutlet weak var etiquetaAdministrar: UILabel!
    @IBOutlet weak var botonsalir: UIButton!
    @IBOutlet weak var botonAdvertencia: UIButton!
    @IBOutlet weak var etiquetaSalir: UILabel!
    
    var numControlAdmin = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Estoy en la otra vista ADMINITRADOR MENU HOLA PAPU")
        
        botonFila.addTarget(self, action: #selector(eventoCrearFila), for: UIControlEvents.touchUpInside)
        
        botonAdministrar.addTarget(self, action: #selector(eventoAdministrarFila), for: UIControlEvents.touchUpInside)
        
        botonsalir.addTarget(self, action: #selector(eventoSalir), for: UIControlEvents.touchUpInside)
        
        botonAdvertencia.addTarget(self, action: #selector(eventoAdvertencia), for: UIControlEvents.touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func eventoCrearFila(){
            let viewController:VistaCrearFilaController = UIStoryboard(name: "VistaCrearFila", bundle: nil).instantiateViewController(withIdentifier: "VistaCrearFila") as! VistaCrearFilaController
            // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
            viewController.numControlAdmin = self.numControlAdmin
            self.present(viewController, animated: false, completion: nil)
    }
    
    @objc func eventoAdministrarFila(){
        let viewController:VistaAdminFilaController = UIStoryboard(name: "VistaAdminFila", bundle: nil).instantiateViewController(withIdentifier: "VistaAdminFila") as! VistaAdminFilaController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        viewController.numControlAdmin = self.numControlAdmin
        self.present(viewController, animated: false, completion: nil)
    }
    
    @objc func eventoSalir(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func eventoAdvertencia(){
        print("Imprimiste el boton de Advertencia")
        print("Se implementara despues")
    }
    
}
