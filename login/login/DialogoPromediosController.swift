//
//  DialogoPromediosController.swift
//  GestorColas
//
//  Created by RedMineSS on 05/11/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit

class DialogoPromediosController : UIViewController {
    
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
    @IBOutlet weak var switchDiez: UISwitch!
    @IBOutlet weak var switchOnce: UISwitch!
    @IBOutlet weak var switchDoce: UISwitch!
    @IBOutlet weak var switchTrece: UISwitch!
    @IBOutlet weak var switchCatorce: UISwitch!
    @IBOutlet weak var switchQuince: UISwitch!
    @IBOutlet weak var switchDieciseis: UISwitch!
    @IBOutlet weak var switchDiecisiete: UISwitch!
    @IBOutlet weak var switchDieciocho: UISwitch!
    @IBOutlet weak var switchDiecinueve: UISwitch!
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
            if boton == switchDiecinueve && state == true{
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
         1  0-4
         2  5-9
         3  10-14
         4  15-19
         5  20-24
         6  25-29
         7  30-34
         8  35-39
         9  40-44
         10 45-49
         11 50-54
         12 55-59
         13 60-64
         14 65-69
         15 70-74
         16 75-79
         17 80-84
         18 85-89
         19 90-94
         20 95-100
         */
        arregloSwitches = [switchCero, switchUno, switchDos,
                           switchTres, switchCuatro, switchCinco,
                           switchSeis, switchSiete, switchOcho,
                           switchNueve, switchDiez, switchOnce,
                            switchDoce,switchTrece ,switchCatorce,
                            switchQuince,switchDieciseis,switchDiecisiete,
                            switchDieciocho,switchDiecinueve]
    }
    
    @objc func eventoConfirmar(){
        print("Boton confirmar")
        //AQUI VA EL FOR EACH PARA RECUPERAR LOS ESTADOS
        self.mainViewController?.promedios.removeAll()
        for i in 0...arregloSwitches.count - 1{
            if arregloSwitches[i].isOn {
                self.mainViewController?.promedios.append(i+1)
            }
        }
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoCancelar(){
        print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
}
