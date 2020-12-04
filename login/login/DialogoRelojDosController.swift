//
//  DialogoRelojDosController.swift
//  GestorColas
//
//  Created by RedMineSS on 25/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit

class DialogoRelojDosController : UIViewController {
    var opcion = 0
    
    let transitioner = CAVTransitioner()
    var mainViewController: VistaGestionarFilaController?
    
    @IBOutlet weak var botonCancelar: UIButton!
    @IBOutlet weak var botonConfirmar: UIButton!
    @IBOutlet weak var reloj: UIDatePicker!
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init(opcion: Int) {
        self.init(nibName:nil, bundle:nil)
        self.opcion = opcion
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        botonConfirmar.addTarget(self, action: #selector(eventoConfirmar), for: UIControlEvents.touchUpInside)
        botonCancelar.addTarget(self, action: #selector(eventoCancelar), for: UIControlEvents.touchUpInside)
    }
    
    @objc func eventoConfirmar(){
        print("Boton confirmar")
        print(reloj.date.description)
        let año = reloj.date.description
        print(año)
        //VistaCrearFilaController().setDiaInicio(fecha: año)
        //mainViewController?.setDiaInicio(fecha: año)
        if opcion == 1{
            mainViewController?.etiquetaHoraInicio.text! = "Hora de inicio" + ": \(año)"
        }
        else if opcion == 2{
            mainViewController?.etiquetaHoraFinal.text! = "Hora de finalización" + ": \(año)"
        }
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoCancelar(){
        print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
    
}


