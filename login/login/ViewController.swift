//
//  ViewController.swift
//  login
//
//  Created by RedMineSS on 04/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//
// @author: Fernando Guerrero Montero

import UIKit
import QuartzCore

class ViewController: UIViewController, UITextFieldDelegate {
    
    let allowedCharacters = CharacterSet(charactersIn:"-_*0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").inverted
    
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
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var etiquetaUsuario: UILabel!
    @IBOutlet weak var campoUsuario: UITextField!
    @IBOutlet weak var etiquetaContraseña: UILabel!
    @IBOutlet weak var campoContraseña: UITextField!
    @IBOutlet weak var botonIngresar: UIButton!
    @IBOutlet weak var etiquetaInformacion: UILabel!
    @IBOutlet weak var etiquetaEnviar: UILabel!
    @IBOutlet weak var botonAdvertencia: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //CAMPO USUARIO: MAYUSCULAS Y NUMEROS
        let bottomLineUsuario = CALayer()
        bottomLineUsuario.frame = CGRect(x: 0.0, y: campoUsuario.frame.height, width: vista.frame.width * 0.7, height: 1.0)
        bottomLineUsuario.backgroundColor = UIColor.white.cgColor
        campoUsuario.layer.addSublayer(bottomLineUsuario)
        campoUsuario.delegate = self
        
        //CAMPO CONTRASEÑA: MAYUSCULAS, MINUSCULAS Y NUMEROS
        let bottomLineContraseña = CALayer()
        bottomLineContraseña.frame = CGRect(x: 0.0, y: campoContraseña.frame.height, width: vista.frame.width * 0.7, height: 1.0)
        bottomLineContraseña.backgroundColor = UIColor.white.cgColor
        campoContraseña.layer.addSublayer(bottomLineContraseña)
        campoContraseña.delegate = self
    
        botonIngresar.layer.cornerRadius = 10.0
        botonIngresar.layer.borderWidth = 2
        botonIngresar.layer.borderColor = UIColor.yellow.cgColor
        botonIngresar.addTarget(self, action: #selector(eventoIngresar), for: UIControlEvents.touchUpInside)
        
        botonAdvertencia.addTarget(self, action: #selector(eventoAdvertencia), for: UIControlEvents.touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func eventoIngresar(){
        let textoUsuario = campoUsuario.text
        let textoContraseña = campoContraseña.text
        campoContraseña.text! = ""
        
        if textoUsuario! == "" {
            self.showInputDialog(mensaje: "El usuario y/o contraseña son incorrectos.")
            return
        }
        if textoUsuario!.starts(with: "A") {
            // ADMON
            // create the request
            let url = URL(string: "http://*IP*/api/checarPasswordAdmin/\(textoUsuario!)")!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    OperationQueue.main.addOperation {
                        self.showInputDialog(mensaje: "Hubo un error de conexión.")
                    }
                }
                else {
                    if let content = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(json)
                            let ERROR = String.init(describing: (json["error"]!)!)
                            let password = String.init(describing: (json["password"]!)!)
                            print("ERROR: "+ERROR)
                            print("PASSWORD: "+password)
                            if ERROR == "0" && password == textoContraseña! {
                                OperationQueue.main.addOperation {
                                    let viewController:VistaMenuAdmonController = UIStoryboard(name: "VistaMenuAdmon", bundle: nil).instantiateViewController(withIdentifier: "VistaMenuAdmon") as! VistaMenuAdmonController
                                    // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
                                    viewController.numControlAdmin = textoUsuario!
                                    self.present(viewController, animated: true, completion: nil)
                                }
                            }
                            else {
                                OperationQueue.main.addOperation {
                                    self.showInputDialog(mensaje: "El usuario y/o contraseña son incorrectos.")
                                }
                            }
                        }
                        catch {
                            
                        }
                    }
                }
            }
            task.resume()
            
        }
        else {
            // USUARIO
            // create the request
            let url = URL(string: "http://*IP*/api/checarPasswordEstandar/\(textoUsuario!)")!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    OperationQueue.main.addOperation {
                        self.showInputDialog(mensaje: "Hubo un error de conexión.")
                    }
                }
                else {
                    if let content = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(json)
                            let ERROR = String.init(describing: (json["error"]!)!)
                            let password = String.init(describing: (json["password"]!)!)
                            print("ERROR: "+ERROR)
                            print("PASSWORD: "+password)
                            if ERROR == "0" && password == textoContraseña! {
                                OperationQueue.main.addOperation {
                                    let viewController:UIViewController = UIStoryboard(name: "VistaMenuUser", bundle: nil).instantiateViewController(withIdentifier: "VistaMenuUser") as UIViewController
                                    // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
                                    
                                    self.present(viewController, animated: true, completion: nil)
                                }
                            }
                            else {
                                OperationQueue.main.addOperation {
                                    self.showInputDialog(mensaje: "El usuario y/o contraseña son incorrectos.")
                                }
                            }
                        }
                        catch {
                            
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    @objc func eventoAdvertencia(){
        print("Imprimiste el boton de Advertencia")
        print("Se implementara despues")
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
