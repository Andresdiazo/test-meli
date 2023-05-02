//
//  SplashScreenViewController.swift
//  TechnicalMeli
//
//  Created by Andres Diaz  on 28/04/23.
//

import Foundation
import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var splashImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Aquí puedes personalizar la vista del splash screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Oculta la barra de navegación
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Muestra la barra de navegación en la siguiente vista
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
