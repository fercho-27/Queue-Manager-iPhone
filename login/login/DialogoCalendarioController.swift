//
//  dialogoCalendarioController.swift
//  GestorColas
//
//  Created by RedMineSS on 16/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//


import UIKit

class DialogoCalendarioController : UIViewController {
    var opcion = 0
    
    let transitioner = CAVTransitioner()
    var mainViewController:VistaCrearFilaController?
    
    @IBOutlet weak var botonCancelar: UIButton!
    @IBOutlet weak var botonConfirmar: UIButton!
    @IBOutlet weak var calendario: UIDatePicker!
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
        
        calendario.minimumDate = calendario.date
    }
    
    @objc func eventoConfirmar(){
        print("Boton confirmar")
        print(calendario.date.description)
        /*let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        calendario.date = calendario.date.addingTimeInterval(TimeInterval(60*60*24))
        let myComponents = myCalendar.components(.weekday, from: calendario.date)
        let weekDay = myComponents.weekday
        print("\(weekDay!)")*/
        let contenido = calendario.date.description.split(separator: " ")
        for cad in contenido{
            print(cad)
        }
        let fecha = contenido[0].split(separator: "-")
        let año: Int? = Int(fecha[0])
        let mes: Int? = Int(fecha[1])
        let dia: Int? = Int(fecha[2])
        //VistaCrearFilaController().setDiaInicio(fecha: año)
        //mainViewController?.setDiaInicio(fecha: año)
        if opcion == 1 {
            mainViewController?.etiquetaDiaInicio.text! = "Día de inicio" + ": \(dia!)/\(mes!)/\(año!)"
            mainViewController?.diaInicio = dia!
            mainViewController?.mesInicio = mes!
            mainViewController?.añoInicio = año!
            mainViewController?.fechaInicio = calendario.date
        }
        else{
            mainViewController?.etiquetaDiaFinal.text! = "Día de finalización" + ": \(dia!)/\(mes!)/\(año!)"
            mainViewController?.diaFinal = dia!
            mainViewController?.mesFinal = mes!
            mainViewController?.añoFinal = año!
            mainViewController?.fechaFinal = calendario.date
        }
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoCancelar(){
            print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
