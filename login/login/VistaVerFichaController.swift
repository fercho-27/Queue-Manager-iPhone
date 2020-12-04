//
//  VistaVerFichaController.swift
//  GestorColas
//
//  Created by RedMineSS on 29/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit
import QuartzCore

class VistaVerFichaController: UIViewController {
    
    @IBOutlet var vista: UIView!
    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!

    @IBOutlet weak var etiquetaDia: UILabel!
    @IBOutlet weak var etiquetaNota: UILabel!
    @IBOutlet weak var etiquetaRequisitos: UILabel!
    @IBOutlet weak var etiquetaHora: UILabel!
    @IBOutlet weak var etquetaLugar: UILabel!
    @IBOutlet weak var etiquetaNombre: UILabel!
    @IBOutlet weak var botonRegresar: UIButton!
    @IBOutlet weak var botonCancelar: UIButton!
    @IBOutlet weak var altura: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Estoy en la vista de ver ficha")
        
        //BOTON CANCELAR
        botonRegresar.layer.cornerRadius = 10.0
        botonRegresar.layer.borderWidth = 2
        botonRegresar.layer.borderColor = UIColor.yellow.cgColor
        botonRegresar.addTarget(self, action: #selector(eventoRegresar), for: UIControlEvents.touchUpInside)
        
        //BOTON REGRESAR
        botonCancelar.layer.cornerRadius = 10.0
        botonCancelar.layer.borderWidth = 2
        botonCancelar.layer.borderColor = UIColor.red.cgColor
        botonCancelar.addTarget(self, action: #selector(eventoCancelar), for: UIControlEvents.touchUpInside)
        
        //RECUPERAR INFO DE LA BD
        etiquetaNombre.text = etiquetaNombre.text! + "Becas"
        
        etquetaLugar.text = etquetaLugar.text! + "Raul Limon"
        
        etiquetaDia.text = etiquetaDia.text! + "15/10/2019"
        
        etiquetaHora.text = etiquetaHora.text! + "10:30 am"
        
        etiquetaRequisitos.text = etiquetaRequisitos.text! + "\nTraer copia de acta de nacimiento"
        
        etiquetaNota.text = etiquetaNota.text! + "\nLlegar 5 minutos antes."
        
        var aux = 0
        for _ in etiquetaRequisitos.text! {
            aux+=2
        }
        for _ in etiquetaNota.text! {
            aux+=2
        }
        altura.constant = CGFloat(600 + aux)
        print(600 + aux)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @objc func eventoCancelar(){
        print("Cancelar Ficha")
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Confirmacion", message: "¿Quieres cancelar tu ficha?", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (_) in
            //CANCELAR FICHA
            //regresar a la vista anterior
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func eventoRegresar(){
        print("Operacion Cancelada")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

