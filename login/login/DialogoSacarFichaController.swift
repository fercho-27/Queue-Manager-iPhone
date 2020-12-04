//
//  DialogoSacarFichaController.swift
//  GestorColas
//
//  Created by RedMineSS on 29/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit

class DialogoSacarFichaController : UIViewController {
    
    var fila = ""
    
    let transitioner = CAVTransitioner()
    var mainViewController:VistaSacarFichaController?
    
    @IBOutlet weak var etiquetaFila: UILabel!
    @IBOutlet weak var botonCancelar: UIButton!
    @IBOutlet weak var botonConfirmar: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var altura: NSLayoutConstraint!
    
    var arregloSwitches: [UISwitch] = []
    
    /*@IBAction func eventoCambiar(_ sender: UISwitch) {
        for boton in arregloSwitches{
            if boton != sender {
                boton.setOn(false, animated: true)
            }
        }
    }*/
    
    @objc func eventoCambiar(_ sender: UISwitch){
        for boton in arregloSwitches{
            if boton != sender {
                boton.setOn(false, animated: true)
            }
        }
    }
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init(fila: String) {
        self.init(nibName:nil, bundle:nil)
        self.fila = fila
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        etiquetaFila.text? = "Fila: " + fila
        etiquetaFila.font = UIFont(name: "Arial", size: 14.0)
        
        botonConfirmar.addTarget(self, action: #selector(eventoConfirmar), for: UIControlEvents.touchUpInside)
        botonCancelar.addTarget(self, action: #selector(eventoCancelar), for: UIControlEvents.touchUpInside)
        //OBTENER EL HORARIO
        var y = 10
        var min = 0
        for _ in 1...20{
            //SWITCH HORA
            let boton = UISwitch()
            boton.frame = CGRect(x:20,y:y,width:49,height:31)
            boton.addTarget(self, action: #selector(eventoCambiar), for: UIControlEvents.valueChanged)
            //ETIQUETA HORA
            let etiqueta = UILabel()
            etiqueta.text = "12:\(min)0"
            etiqueta.textAlignment = NSTextAlignment.left
            etiqueta.textColor = UIColor.black
            min+=1
            etiqueta.font = UIFont(name: "Arial", size: 12.0)
            etiqueta.numberOfLines = 0
            etiqueta.frame = CGRect(x:0,y:0,width:50,height:50)
            etiqueta.center = CGPoint(x:100,y:y+17)
            y+=40
            //AGREGAR AL SCROLL
            arregloSwitches.append(boton)
            vistaScroll.addSubview(boton)
            vistaScroll.addSubview(etiqueta)
        }
        //Ajustar el scroll
        altura.constant = CGFloat(y+20)
    }
    
    @objc func eventoConfirmar(){
        print("Boton confirmar")
        //mainViewController?.setDiaInicio(fecha: año)
        //AQUI VA EL FOR EACH PARA RECUPERAR LOS ESTADOS
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoCancelar(){
        print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
}
