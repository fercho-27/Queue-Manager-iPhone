//
//  VistaCrearFilaController.swift
//  GestorColas
//
//  Created by RedMineSS on 14/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit
import QuartzCore

class VistaCrearFilaController: UIViewController, UITextFieldDelegate {
    
    let allowedCharacters = CharacterSet(charactersIn:"-_0123456789abcdefghijklmnopqrstuvwxyz").inverted
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let components = string.components(separatedBy: allowedCharacters)
        let filtered = components.joined(separator: "")
        
        if string == filtered {
            return true
            
        } else {
            return false
        }
    }
    
    @IBOutlet var vista: UIView!
    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var etiquetaNombreFila: UILabel!
    @IBOutlet weak var campoNombreFila: UITextField!
    @IBOutlet weak var etiquetaDiaInicio: UILabel!
    @IBOutlet weak var botonDiaInicio: UIButton!
    @IBOutlet weak var etiquetaDiaFinal: UILabel!
    @IBOutlet weak var botonDiaFinal: UIButton!
    @IBOutlet weak var etiquetaLugarFila: UILabel!
    @IBOutlet weak var campoLugarFila: UITextField!
    @IBOutlet weak var etiquetaHoraInicio: UILabel!
    @IBOutlet weak var botonHoraInicio: UIButton!
    @IBOutlet weak var etiquetaHoraFinal: UILabel!
    @IBOutlet weak var botonHoraFinal: UIButton!
    @IBOutlet weak var etiquetaHoraInicioDescanso: UILabel!
    @IBOutlet weak var botonHoraInicioDescanso: UIButton!
    @IBOutlet weak var etiquetaHoraFinalDescanso: UILabel!
    @IBOutlet weak var botonHoraFinalDescanso: UIButton!
    @IBOutlet weak var etiquetaTiempoBloque: UILabel!
    @IBOutlet weak var campoTiempoBloque: UITextField!
    @IBOutlet weak var etiquetaCapacidadBloque: UILabel!
    @IBOutlet weak var campoCapacidadBloque: UITextField!
    @IBOutlet weak var botonCarreras: UIButton!
    @IBOutlet weak var botonSemestres: UIButton!
    @IBOutlet weak var botonPromedios: UIButton!
    @IBOutlet weak var etiquetaRequisitos: UILabel!
    @IBOutlet weak var campoRequisitos: UITextField!
    @IBOutlet weak var etiquetaNotas: UILabel!
    @IBOutlet weak var campoNotas: UITextField!
    @IBOutlet weak var botonConfirmar: UIButton!
    @IBOutlet weak var botonCancelar: UIButton!
    
    var numControlAdmin = ""
    var fechaInicio: Date = Date.init()
    var fechaFinal: Date = Date.init()
    var nombreFila = ""
    var diaInicio = -1
    var mesInicio = -1
    var añoInicio = -1
    var diaFinal = -1
    var mesFinal = -1
    var añoFinal = -1
    var lugarFila = ""
    var horaInicio = -1
    var horaFinal = -1
    var horaInicioDescanso = -1
    var horaFinalDescanso = -1
    var tiempoBloque = 0
    var capacidadBloque = 0
    var carreras: [Int] = []
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
    var semestres: [Int] = []
    /*
     PRIMER SEMESTRE = 1
     SEGUNDO SEMESTRE = 2
     .
     .
     .
     NOVENO SEMESTRE = 9
     OTROS SEMESTRES = 10 (semestre 10 - semestre 15)
     SEMESTRE CERO 16
     */
    var promedios: [Int] = []
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
    var requisitos = ""
    var notas = ""
    
    func imprimir(){
        print("***********************")
        print("Nombre de la fila: "+nombreFila)
        print("Dia inicio: \(diaInicio)")
        print("Mes inicio: \(mesInicio)")
        print("Año inicio: \(añoInicio)")
        print("Dia final: \(diaFinal)")
        print("Mes final: \(mesFinal)")
        print("Año final: \(añoFinal)")
        print("Lugar de la fila: "+lugarFila)
        print("Hora inicio: \(horaInicio/60):\(horaInicio%60)")
        print("Hora final: \(horaFinal/60):\(horaFinal%60)")
        print("Hora inicio descanso: \(horaInicioDescanso/60):\(horaInicioDescanso%60)")
        print("Hora final descanso: \(horaFinalDescanso/60):\(horaFinalDescanso%60)")
        print("Tiempo de Bloque: \(tiempoBloque)")
        print("Capacidad por Bloque: \(capacidadBloque)")
        for i in carreras{
            print("Carreras: \(i)")
        }
        for i in semestres{
            print("Semestres: \(i)")
        }
        for i in promedios{
            print("Promedios: \(i)")
        }
        print("Requisitos: "+requisitos)
        print("Notas: "+notas)
        print("***********************")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Estoy en la vista de crear fila")
        
        //CAMPO NOMBRE
        let bottomLineNombreFila = CALayer()
        bottomLineNombreFila.frame = CGRect(x: 0.0, y: campoNombreFila.frame.height, width: vista.frame.width * 0.9, height: 1.0)
        bottomLineNombreFila.backgroundColor = UIColor.white.cgColor
        campoNombreFila.layer.addSublayer(bottomLineNombreFila)
        //TECLADO ESPECIAL
        campoNombreFila.delegate=self
        
        //BOTONDIAINICIO
        botonDiaInicio.layer.cornerRadius = 10.0
        botonDiaInicio.layer.borderWidth = 2
        botonDiaInicio.layer.borderColor = UIColor.yellow.cgColor
        botonDiaInicio.addTarget(self, action: #selector(eventoDiaInicio), for: UIControlEvents.touchUpInside)
        
        //BOTONDIAFINAL
        botonDiaFinal.layer.cornerRadius = 10.0
        botonDiaFinal.layer.borderWidth = 2
        botonDiaFinal.layer.borderColor = UIColor.yellow.cgColor
        botonDiaFinal.addTarget(self, action: #selector(eventoDiaFinal), for: UIControlEvents.touchUpInside)
        
        //CAMPO LUGAR FILA
        let bottomLineLugarFila = CALayer()
        bottomLineLugarFila.frame = CGRect(x: 0.0, y: campoLugarFila.frame.height, width: vista.frame.width * 0.9, height: 1.0)
        bottomLineLugarFila.backgroundColor = UIColor.white.cgColor
        campoLugarFila.layer.addSublayer(bottomLineLugarFila)
        
        //BOTON HORA INICIO
        botonHoraInicio.layer.cornerRadius = 10.0
        botonHoraInicio.layer.borderWidth = 2
        botonHoraInicio.layer.borderColor = UIColor.yellow.cgColor
        botonHoraInicio.addTarget(self, action: #selector(eventoHoraInicio), for: UIControlEvents.touchUpInside)
        
        //BOTON HORA FINAL
        botonHoraFinal.layer.cornerRadius = 10.0
        botonHoraFinal.layer.borderWidth = 2
        botonHoraFinal.layer.borderColor = UIColor.yellow.cgColor
        botonHoraFinal.addTarget(self, action: #selector(eventoHoraFinal), for: UIControlEvents.touchUpInside)
        
        //BOTON HORA INICIO DESCANSO
        botonHoraInicioDescanso.layer.cornerRadius = 10.0
        botonHoraInicioDescanso.layer.borderWidth = 2
        botonHoraInicioDescanso.layer.borderColor = UIColor.yellow.cgColor
        botonHoraInicioDescanso.addTarget(self, action: #selector(eventoHoraInicioDescanso), for: UIControlEvents.touchUpInside)
        
        //BOTON HORA FINAL DESCANSO
        botonHoraFinalDescanso.layer.cornerRadius = 10.0
        botonHoraFinalDescanso.layer.borderWidth = 2
        botonHoraFinalDescanso.layer.borderColor = UIColor.yellow.cgColor
        botonHoraFinalDescanso.addTarget(self, action: #selector(eventoHoraFinalDescanso), for: UIControlEvents.touchUpInside)
        
        //CAMPO TIEMPO BLOQUE
        let bottomLineTiempoBloque = CALayer()
        bottomLineTiempoBloque.frame = CGRect(x: 0.0, y: campoTiempoBloque.frame.height, width: vista.frame.width * 0.9, height: 1.0)
        bottomLineTiempoBloque.backgroundColor = UIColor.white.cgColor
        campoTiempoBloque.layer.addSublayer(bottomLineTiempoBloque)
        //TECLADO NUMERICO
        campoTiempoBloque.keyboardType = UIKeyboardType.numberPad
        
        //CAMPO CAPACIDAD BLOQUE
        let bottomLineCapacidadBloque = CALayer()
        bottomLineCapacidadBloque.frame = CGRect(x: 0.0, y: campoCapacidadBloque.frame.height, width: vista.frame.width * 0.9, height: 1.0)
        bottomLineCapacidadBloque.backgroundColor = UIColor.white.cgColor
        campoCapacidadBloque.layer.addSublayer(bottomLineCapacidadBloque)
        //TECLADO NUMERICO
        campoCapacidadBloque.keyboardType = UIKeyboardType.numberPad
        
        //BOTON CARRERAS
        botonCarreras.layer.cornerRadius = 10.0
        botonCarreras.layer.borderWidth = 2
        botonCarreras.layer.borderColor = UIColor.yellow.cgColor
        botonCarreras.addTarget(self, action: #selector(eventoCarreras), for: UIControlEvents.touchUpInside)
        
        //BOTON SEMESTRES
        botonSemestres.layer.cornerRadius = 10.0
        botonSemestres.layer.borderWidth = 2
        botonSemestres.layer.borderColor = UIColor.yellow.cgColor
        botonSemestres.addTarget(self, action: #selector(eventoSemestres), for: UIControlEvents.touchUpInside)
        
        //BOTON SEMESTRES
        botonPromedios.layer.cornerRadius = 10.0
        botonPromedios.layer.borderWidth = 2
        botonPromedios.layer.borderColor = UIColor.yellow.cgColor
        botonPromedios.addTarget(self, action: #selector(eventoPromedios), for: UIControlEvents.touchUpInside)
        
        //CAMPO REQUISITOS
        let bottomLineRequisitos = CALayer()
        bottomLineRequisitos.frame = CGRect(x: 0.0, y: campoRequisitos.frame.height, width: vista.frame.width * 0.9, height: 1.0)
        bottomLineRequisitos.backgroundColor = UIColor.white.cgColor
        campoRequisitos.layer.addSublayer(bottomLineRequisitos)
        
        //CAMPO NOTAS
        let bottomLineNotas = CALayer()
        bottomLineNotas.frame = CGRect(x: 0.0, y: campoNotas.frame.height, width: vista.frame.width * 0.9, height: 1.0)
        bottomLineNotas.backgroundColor = UIColor.white.cgColor
        campoNotas.layer.addSublayer(bottomLineNotas)
        
        //BOTON SEMESTRES
        botonConfirmar.layer.cornerRadius = 10.0
        botonConfirmar.layer.borderWidth = 2
        botonConfirmar.layer.borderColor = UIColor.red.cgColor
        botonConfirmar.addTarget(self, action: #selector(eventoConfirmar), for: UIControlEvents.touchUpInside)
        
        //BOTON SEMESTRES
        botonCancelar.layer.cornerRadius = 10.0
        botonCancelar.layer.borderWidth = 2
        botonCancelar.layer.borderColor = UIColor.red.cgColor
        botonCancelar.addTarget(self, action: #selector(eventoCancelar), for: UIControlEvents.touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func eventoDiaInicio(){
        print("Dia de inicio")
        let dialogo = DialogoCalendarioController(opcion: 1)
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
        //etiquetaDiaInicio.text! = "Día de inicio" + ": \(fechita)"
    }
    
    @objc func eventoDiaFinal(){
        print("Dia de final")
        let dialogo = DialogoCalendarioController(opcion: 2)
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
        //etiquetaDiaFinal.text! = "Día de finalización" + ": \(fechita)"
    }
    
    @objc func eventoHoraInicio(){
        print("Hora de inicio")
        let dialogo = DialogoRelojController(opcion: 1)
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
        //etiquetaHoraInicio.text! = "Hora de inicio" + ": 10:00"
    }
    
    @objc func eventoHoraFinal(){
        print("Hora de final")
        let dialogo = DialogoRelojController(opcion: 2)
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
        //etiquetaHoraFinal.text! = "Hora de finalización" + ": 15:00"
    }
    
    @objc func eventoHoraInicioDescanso(){
        print("Hora de inicio descanso")
        let dialogo = DialogoRelojController(opcion: 3)
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
        //etiquetaHoraInicioDescanso.text! = "Hora de inicio descanso (opcional)" + ": 12:00"
    }
    
    @objc func eventoHoraFinalDescanso(){
        print("Hora de final descanso")
        let dialogo = DialogoRelojController(opcion: 4)
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
       // etiquetaHoraFinalDescanso.text! = "Hora de finalización descanso (opcional)" + ": 13:00"
    }
    
    @objc func eventoCarreras(){
        print("Selecciona una carrera")
        let dialogo = DialogoCarrerasController()
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
    }
    
    @objc func eventoSemestres(){
        print("Selecciona una semestre")
        let dialogo = DialogoSemestresController()
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
    }
    
    @objc func eventoPromedios(){
        print("Selecciona un promedio")
        let dialogo = DialogoPromediosController()
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
    }
    
    @objc func eventoConfirmar(){
        print("Boton confirmar")
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Confirmacion", message: "¿Quieres crear esta fila?", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (_) in
            //crear la fila en la BD o ficticio aqui
            var bandera = false
            var banderaCarreras = false
            if self.carreras.count == 0 {
                banderaCarreras = true
            }
            var banderaSemestres = false
            if self.semestres.count == 0 {
                banderaSemestres = true
            }
            var banderaPromedios = false
            if self.promedios.count == 0 {
                banderaPromedios = true
            }
            var banderaFecha = false
            if self.diaInicio == -1 || self.diaFinal == -1 {
                banderaFecha = true
            }
            var banderaHora = false
            if self.horaInicio == -1 || self.horaFinal == -1 {
                banderaHora = true
            }
            
            var banderaHoraOpcional = true
            if self.horaInicioDescanso == -1 && self.horaFinalDescanso == -1 {
                banderaHoraOpcional = false
            }
            else if self.horaInicioDescanso != -1 && self.horaFinalDescanso != -1 {
                banderaHoraOpcional = false
            }
            
            self.nombreFila = self.campoNombreFila.text!
            if self.nombreFila == "" {
                bandera = true
            }
            
            self.lugarFila = self.campoLugarFila.text!
            if self.lugarFila == "" {
                bandera = true
            }
            
            var aux1: Int? = Int(self.campoTiempoBloque.text!)
            var banderaBloque = false
            if aux1 == nil || aux1 == 0 {
                aux1 = -1
                banderaBloque = true
            }
            self.tiempoBloque = Int(aux1!)
            
            var aux2: Int? = Int(self.campoCapacidadBloque.text!)
            var banderaCapacidad = false
            if aux2 == nil || aux2 == 0 {
                aux2 = -1
                banderaCapacidad = true
            }
            self.capacidadBloque = Int(aux2!)
            
            self.requisitos = self.campoRequisitos.text!
            if self.requisitos == "" {
                bandera = true
            }
            
            self.notas = self.campoNotas.text!
            if self.notas == "" {
                bandera = true
            }
            
            if bandera {
                self.showInputDialog(mensaje: "Un campo obligatorio está vacío")
                return
            }
            if banderaBloque {
                self.showInputDialog(mensaje: "El campo Tiempo Bloque solo permite números")
                return
            }
            if banderaCapacidad {
                self.showInputDialog(mensaje: "El campo Capacidad Bloque solo permite números")
                return
            }
            if banderaFecha {
                self.showInputDialog(mensaje: "No se ha seleccionado una fecha de inicio o finalización")
                return
            }
            if banderaHora {
                self.showInputDialog(mensaje: "No se ha seleccionado una hora de inicio o finalización")
                return
            }
            if banderaHoraOpcional {
                self.showInputDialog(mensaje: "No se ha seleccionado ambas horas de descanso")
                return
            }
            if banderaCarreras {
                self.showInputDialog(mensaje: "No se ha seleccionado una carrera")
                return
            }
            if banderaSemestres {
                self.showInputDialog(mensaje: "No se ha seleccionado un semestre")
                return
            }
            if banderaPromedios {
                self.showInputDialog(mensaje: "No se ha seleccionado un promedio")
                return
            }
            if self.añoFinal <= self.añoInicio {
                if self.añoFinal < self.añoInicio {
                    self.showInputDialog(mensaje: "El año de finalización es menor que el de inicio")
                    return
                }
                if self.mesFinal <= self.mesInicio {
                    if self.mesFinal < self.mesInicio {
                        self.showInputDialog(mensaje: "El mes de finalización es menor que el de inicio")
                        return
                    }
                    if self.diaFinal < self.diaInicio {
                        self.showInputDialog(mensaje: "El día de finalización es menor que el de inicio")
                        return
                    }
                }
            }
            if self.horaFinal <= self.horaInicio {
                self.showInputDialog(mensaje: "La hora de finalización no es mayor que la de inicio")
                return
            }
            var horaInicioDescansoString = ""
            var horaFinalDescansoString = ""
            if self.horaFinalDescanso == -1 {
                horaFinalDescansoString = "-11:11:11"
                horaInicioDescansoString = horaFinalDescansoString
            }
            else {
                horaInicioDescansoString = "\(self.horaInicioDescanso/60):\(self.horaInicioDescanso%60):00"
                horaFinalDescansoString = "\(self.horaFinalDescanso/60):\(self.horaFinalDescanso%60):00"
                if self.horaFinalDescanso <= self.horaInicioDescanso {
                    self.showInputDialog(mensaje: "La hora de finalización del descanso no es mayor que la de inicio")
                    return
                }
                if self.horaInicioDescanso <= self.horaInicio || self.horaFinalDescanso >= self.horaFinal {
                    self.showInputDialog(mensaje: "Las horas de descanso no están en un rango permitido")
                    return
                }
            }
            /**************/
            self.imprimir()
            var fechas: [String] = []
            var horas: [Int] = []
            var fecha = self.fechaInicio
            var hora = self.horaInicio
            var banderaBloques = true
            while hora < self.horaFinal {
                print(hora)
                horas.append(hora)
                hora = hora + self.tiempoBloque
                if !horaInicioDescansoString.starts(with: "-") && hora >= self.horaInicioDescanso && banderaBloques {
                    if hora > self.horaInicioDescanso {
                        self.showInputDialog(mensaje: "El tiempo por bloque no concuerda con las horas de descanso.")
                        return
                    }
                    hora = self.horaFinalDescanso
                    banderaBloques = false
                }
                if hora > self.horaFinal {
                    self.showInputDialog(mensaje: "El tiempo por bloque no concuerda con la hora de finalización.")
                    return
                }
            }
            print("//////////////////")
            for hora in horas {
                print("\(hora/60):\(hora%60):00")
            }
            print("·····················")
            repeat {
                print(fecha.description)
                //fechas.append(fecha)
                let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
                let myComponents = myCalendar.components(.weekday, from: fecha)
                let weekDay = myComponents.weekday
                if weekDay! > 1 && weekDay! < 7 {
                    fechas.append(String(fecha.description.split(separator: " ")[0]))
                }
                fecha = fecha.addingTimeInterval(TimeInterval(60*60*24))
            }while fecha < self.fechaFinal
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            for dia in fechas {
                for hora in horas {
                    print("\(hora/60):\(hora%60):00 - \(dia.description.split(separator: " ")[0])")
                }
            }
            /**************/
                //CONSULTA BD
                //self.imprimir()
                //CHECHAR SI EL NOMBRE DE LA FILA YA EXISTE
                // create the request
                let url1 = URL(string: "http://*IP*/api/comprobarFila/\(self.nombreFila)")!
                let task1 = URLSession.shared.dataTask(with: url1) { (data, response, error) in
                    if error != nil {
                        print("ERROR DE URL")
                    }
                    else {
                        if let content = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                print(json)
                                let existe = String.init(describing: (json["existe"]!)!)
                                print("existe: "+existe)
                                if existe == "1" {
                                    OperationQueue.main.addOperation {
                                        self.showInputDialog(mensaje: "El nombre de la fila ya existe")
                                    }
                                }
                                else {
                                    // prepare json data
                                    var carreritas = "\(self.carreras[0])"
                                    for i in self.carreras {
                                        if i == self.carreras[0] {
                                            continue
                                        }
                                        carreritas.append(",\(i)")
                                    }
                                    var semestritos = "\(self.semestres[0])"
                                    for i in self.semestres {
                                        if i == self.semestres[0] {
                                            continue
                                        }
                                        semestritos.append(",\(i)")
                                    }
                                    var promediitos = "\(self.promedios[0])"
                                    for i in self.promedios {
                                        if i == self.promedios[0] {
                                            continue
                                        }
                                        promediitos.append(",\(i)")
                                    }
                                    /*************************************************/
                                    let json: [String: String] =
                                        ["nombre_fila":self.nombreFila,
                                        "dia_inicio":"\(self.añoInicio)-\(self.mesInicio)-\(self.diaInicio)",
                                        "dia_final":"\(self.añoFinal)-\(self.mesFinal)-\(self.diaFinal)",
                                        "lugar":self.lugarFila,
                                        "hora_inicio":"\(self.horaInicio/60):\(self.horaInicio%60):00",
                                        "hora_final":"\(self.horaFinal/60):\(self.horaFinal%60):00",
                                        
                                        "descanso_inicio":horaInicioDescansoString,
                                        "descanso_final":horaFinalDescansoString,
                                        "tiempo_bloque":"\(self.tiempoBloque)",
                                        "capacidad_bloque":"\(self.capacidadBloque)",
                                        "carreras":carreritas,
                                        
                                        "semestres":semestritos,
                                        "promedios":promediitos,
                                        "requisitos":self.requisitos,
                                        "notas":self.notas,
                                        "numero_control_admin":self.numControlAdmin]
                                    /**********************************************/
                                    
                                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                                    
                                    // create post request
                                    let url = URL(string: "http://187.243.246.24:8071/api/crearFila")!
                                    var request = URLRequest(url: url)
                                    request.httpMethod = "POST"
                                    
                                    // insert json data to the request
                                    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                                    request.httpBody = jsonData!
                                    /*let x = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
                                     if let x = x as? [String: String] {
                                     print(x)
                                     }*/
                                    
                                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                                        guard let data = data, error == nil else {
                                            print(error?.localizedDescription ?? "No data")
                                            return
                                        }
                                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                                        if let responseJSON = responseJSON as? [String: Any] {
                                            print(responseJSON)
                                            //obtener ID_FILA
                                            // create the request
                                            let url3 = URL(string: "http://*IP*/api/getFila/\(self.nombreFila)")!
                                            let task3 = URLSession.shared.dataTask(with: url3) { (data, response, error) in
                                                if error != nil {
                                                    print("ERROR DE URL")
                                                }
                                                else {
                                                    if let content = data {
                                                        do {
                                                            let json3 = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [NSDictionary]
                                                            print(json3)
                                                            let id_fila = json3[0]["id_fila"]
                                                            if id_fila == nil {
                                                                OperationQueue.main.addOperation {
                                                                    self.showInputDialog(mensaje: "Hubo un error al crear la fila.")
                                                                }
                                                            }
                                                            else {
                                                                /*************************************************/
                                                                var json2: [[String: String]] = []
                                                                for dia in fechas {
                                                                    for hora in horas {
                                                                        //print("\(hora/60):\(hora%60):00 - \(dia.description.split(separator: " ")[0])")
                                                                        let hora_inicio = hora/60
                                                                        let minuto_inicio = hora%60
                                                                        var hora_final = hora/60
                                                                        var minuto_final = (hora%60)+self.tiempoBloque
                                                                        if minuto_final >= 60 {
                                                                            minuto_final = minuto_final - 60
                                                                            hora_final = (hora_final + 1) % 24
                                                                        }
                                                                        let diccionario =
                                                                            ["dia":dia,
                                                                             "hora_inicio":"\(hora_inicio):\(minuto_inicio):00",
                                                                                "hora_final":"\(hora_final):\(minuto_final):00",
                                                                                "capacidad_bloque":"\(self.capacidadBloque)",
                                                                                "registrados":"0",
                                                                                "id_fila":"\(id_fila!)"]
                                                                        json2.append(diccionario)
                                                                    }
                                                                }
                                                                /**********************************************/
                                                                
                                                                let jsonData2 = try? JSONSerialization.data(withJSONObject: json2)
                                                                
                                                                // create post request
                                                                let url2 = URL(string: "http://*IP*/api/crearBloques")!
                                                                var request2 = URLRequest(url: url2)
                                                                request2.httpMethod = "POST"
                                                                
                                                                // insert json data to the request
                                                                request2.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                                                                request2.httpBody = jsonData2!
                                                                
                                                                let task2 = URLSession.shared.dataTask(with: request2) { data, response, error in
                                                                    guard let data = data, error == nil else {
                                                                        print(error?.localizedDescription ?? "No data")
                                                                        return
                                                                    }
                                                                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                                                                    if let responseJSON = responseJSON as? [String: Any] {
                                                                        print(responseJSON)
                                                                        //regresar a la vista anterior
                                                                        OperationQueue.main.addOperation {
                                                                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                                                                        }
                                                                    }
                                                                    else {
                                                                        print("ERROR DE CREACION DE BLOQUES")
                                                                    }
                                                                } //TASK2
                                                                task2.resume()
                                                                
                                                            } //ELSE
                                                        } //DO
                                                        catch {}
                                                    } //IF LET
                                                } //ELSE
                                            } // TASK3
                                            task3.resume()
                                            
                                            
                                        } //IF LET
                                        else {
                                            print("ERROR DE CREACION DE FILAS")
                                        }
                                    } //TASK
                                    task.resume()
                                    
                                } //ELSE
                            } //DO
                            catch {}
                        } //IF LET
                    } //ELSE
                } // TASK1
                task1.resume()
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func eventoCancelar(){
        print("Operacion Cancelada")
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Cancelar", message: "¿Quieres salir?", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (_) in
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
    
    func showInputDialog(mensaje: String) {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Error!", message: mensaje, preferredStyle: .alert)
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Confirmar", style: .cancel) { (_) in }

        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
}

