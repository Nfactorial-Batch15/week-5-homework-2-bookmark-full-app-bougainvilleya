//
//  ViewController.swift
//  BookmarkAppUIKit
//
//  Created by Leyla Nyssanbayeva on 20.01.2022.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    private var onboardingView: UIView = {
        let onboarding = UIView()
        onboarding.backgroundColor = .black
        return onboarding
    }()
    
    private var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Let's start collecting", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private var titleText: UILabel = {
        let labelText = UILabel()
        labelText.text = "Save all interesting\nlinks in one app"
        labelText.textColor = .white
        labelText.textAlignment = .left
        labelText.numberOfLines = 2
        labelText.font = .systemFont(ofSize: 36, weight: .bold)
        return labelText
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(onboardingView)
        onboardingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let backgroundImage = UIImage(named: "background.png")
        if let bgImage = backgroundImage {
            let backgroundImageView = UIImageView(image: bgImage)
            onboardingView.addSubview(backgroundImageView)
            
            backgroundImageView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.75)
            }
        }
        
        onboardingView.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.width.equalTo(onboardingView).inset(16)
            make.height.equalTo(58)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        startButton.addTarget(self, action: #selector(handlerButton), for: .touchUpInside)
        
        onboardingView.addSubview(titleText)
        titleText.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).offset(-24)
            make.leading.trailing.equalTo(startButton)
        }
    }
    
    @objc func handlerButton() {
        print(#function)
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
}
