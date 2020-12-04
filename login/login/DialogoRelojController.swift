//
//  DialogoRelojController.swift
//  GestorColas
//
//  Created by RedMineSS on 17/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit

class DialogoRelojController : UIViewController {
    var opcion = 0
    
    let transitioner = CAVTransitioner()
    var mainViewController: VistaCrearFilaController?
    
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
        let contenido = reloj.date.description.split(separator: " ")
        for cad in contenido{
            print(cad)
        }
        let fecha = contenido[1].split(separator: ":")
        var hora: Int? = Int(fecha[0])! - 6
        if hora! < 0 {
            hora! = hora! + 24
        }
        let minuto: Int? = Int(fecha[1])
        var ceroHora = ""
        var ceroMinuto = ""
        if hora! < 10 {
            ceroHora = "0"
        }
        if minuto! < 10 {
            ceroMinuto = "0"
        }
        //let segundo: Int? = Int(fecha[2])
        //VistaCrearFilaController().setDiaInicio(fecha: año)
        //mainViewController?.setDiaInicio(fecha: año)
        if opcion == 1{
            mainViewController?.etiquetaHoraInicio.text! = "Hora de inicio" + ": \(ceroHora)\(hora!):\(ceroMinuto)\(minuto!)"
            mainViewController?.horaInicio = hora! * 60 + minuto!
        }
        else if opcion == 2{
            mainViewController?.etiquetaHoraFinal.text! = "Hora de finalización" + ": \(ceroHora)\(hora!):\(ceroMinuto)\(minuto!)"
            mainViewController?.horaFinal = hora! * 60 + minuto!
        }
        else if opcion == 3{
            mainViewController?.etiquetaHoraInicioDescanso.text! = "Hora de inicio descanso (opcional)" + ": \(ceroHora)\(hora!):\(ceroMinuto)\(minuto!)"
            mainViewController?.horaInicioDescanso = hora! * 60 + minuto!
        }
        else{
            mainViewController?.etiquetaHoraFinalDescanso.text! = "Hora de finalización descanso (opcional)" + ": \(ceroHora)\(hora!):\(ceroMinuto)\(minuto!)"
            mainViewController?.horaFinalDescanso = hora! * 60 + minuto!
        }
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoCancelar(){
        print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
    
}

