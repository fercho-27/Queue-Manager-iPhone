//
//  DialogoSemestresController.swift
//  GestorColas
//
//  Created by RedMineSS on 18/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit

class DialogoSemestresController : UIViewController {
    
    let transitioner = CAVTransitioner()
    var mainViewController:VistaCrearFilaController?
    
    @IBOutlet weak var botonCancelar: UIButton!
    @IBOutlet weak var botonConfirmar: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var switchCero: UISwitch!
    @IBOutlet weak var switchUno: UISwitch!
    @IBOutlet weak var switchDos: UISwitch!
    @IBOutlet weak var switchTres: UISwitch!
    @IBOutlet weak var switchCuatro: UISwitch!
    @IBOutlet weak var switchCinco: UISwitch!
    @IBOutlet weak var switchSeis: UISwitch!
    @IBOutlet weak var switchSiete: UISwitch!
    @IBOutlet weak var switchOcho: UISwitch!
    @IBOutlet weak var switchNueve: UISwitch!
    @IBOutlet weak var switchOtros: UISwitch!
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
            if boton == switchOtros && state == true{
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
        arregloSwitches = [switchCero, switchUno, switchDos,
                           switchTres, switchCuatro, switchCinco,
                           switchSeis, switchSiete, switchOcho,
                           switchNueve, switchOtros]
    }
    
    @objc func eventoConfirmar(){
        print("Boton confirmar")
        //AQUI VA EL FOR EACH PARA RECUPERAR LOS ESTADOS
        self.mainViewController?.semestres.removeAll()
        for i in 0...arregloSwitches.count - 1{
            if arregloSwitches[i].isOn {
                if i == 10 {
                    self.mainViewController?.semestres.append(10)
                    self.mainViewController?.semestres.append(11)
                    self.mainViewController?.semestres.append(12)
                    self.mainViewController?.semestres.append(13)
                    self.mainViewController?.semestres.append(14)
                    self.mainViewController?.semestres.append(15)
                    continue
                }
                else if i == 0 {
                    self.mainViewController?.semestres.append(16)
                    continue
                }
                self.mainViewController?.semestres.append(i)
            }
        }
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoCancelar(){
        print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
}
