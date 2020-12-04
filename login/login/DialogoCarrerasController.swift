//
//  DialogoCarrerasController.swift
//  GestorColas
//
//  Created by RedMineSS on 18/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit

class DialogoCarrerasController : UIViewController {
    
    let transitioner = CAVTransitioner()
    var mainViewController:VistaCrearFilaController?
    
    @IBOutlet weak var botonCancelar: UIButton!
    @IBOutlet weak var botonConfirmar: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var switchBQ: UISwitch!
    @IBOutlet weak var switchSC: UISwitch!
    @IBOutlet weak var switchE: UISwitch!
    @IBOutlet weak var switchEN: UISwitch!
    @IBOutlet weak var switchER: UISwitch!
    @IBOutlet weak var switchGE: UISwitch!
    @IBOutlet weak var switchI: UISwitch!
    @IBOutlet weak var switchME: UISwitch!
    @IBOutlet weak var switchMN: UISwitch!
    @IBOutlet weak var switchQ: UISwitch!
    @IBOutlet weak var switchA: UISwitch!
    @IBOutlet weak var switchTodos: UISwitch!
    var arregloSwitches: [UISwitch] = []
    
    @IBAction func eventoTodos(_ sender: UISwitch) {
        let estado = switchTodos.isOn
        for boton in arregloSwitches{
            boton.setOn(estado, animated: true)
        }
    }
    
    @IBAction func eventoCambiar(_ sender: UISwitch) {
        let estado = sender.isOn
        if estado == false {
            switchTodos.setOn(false, animated: true)
        }
        for boton in arregloSwitches{
            let state = boton.isOn
            if state == false{
                break
            }
            if boton == switchGE && state == true{
                switchTodos.setOn(true, animated: true)
            }
        }
    }
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        botonConfirmar.addTarget(self, action: #selector(eventoConfirmar), for: UIControlEvents.touchUpInside)
        botonCancelar.addTarget(self, action: #selector(eventoCancelar), for: UIControlEvents.touchUpInside)
        /*
         1 Licenciatura en Administración
         2 IngenierÌa Bioquímica
         3 IngenierÌa Electrica
         4 IngenierÌa Electronica
         5 IngenierÌa Industrial
         6 IngenierÌa Mecantronica
         7 IngenierÌa Mecanica
         8 IngenierÌa Quimica
         9 IngenierÌa en Sistemas Computacionales
         10 IngenierÌa en Energias Renovalbes
         11 IngenierÌa en Gestion Empresarial
         */
        arregloSwitches = [switchA, switchBQ, switchE,
                           switchEN, switchI, switchMN,
                           switchME, switchQ, switchSC,
                           switchER, switchGE]
    }
    
    @objc func eventoConfirmar(){
        print("Boton confirmar")
        //AQUI VA EL FOR EACH PARA RECUPERAR LOS ESTADOS
        self.mainViewController?.carreras.removeAll()
        for i in 0...arregloSwitches.count - 1 {
            if arregloSwitches[i].isOn {
                self.mainViewController?.carreras.append(i+1)
            }
        }
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoCancelar(){
        print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
}
