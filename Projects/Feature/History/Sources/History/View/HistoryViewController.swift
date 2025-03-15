//
//  HistoryViewController.swift
//  FeatureCalendar
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import FeatureHistoryInterfaces

public class HistoryViewController<VM: HistoryViewModel>: DailogViewController<VM> {
    
    
    public override func configure() {
        super.configure()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = HistoryFilterViewController<DefaultHistoryFilterViewModel>(viewModel: DefaultHistoryFilterViewModel())
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    public override func bind() {
        super.bind()
    }
}
