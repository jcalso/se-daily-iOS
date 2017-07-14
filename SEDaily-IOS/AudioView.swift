//
//  AudioView.swift
//  SEDaily-IOS
//
//  Created by Craig Holliday on 6/30/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

// MARK: - PlayerDelegate

/// Player delegate protocol
public protocol AudioViewDelegate: NSObjectProtocol {
    func playButtonPressed()
    func pauseButtonPressed()
    func stopButtonPressed()
    func skipForwardButtonPressed()
    func skipBackwardButtonPressed()
}

class AudioView: UIView {
    open weak var delegate: AudioViewDelegate?
    
    var activityView: UIActivityIndicatorView!
    
    var podcastLabel = UILabel()
    fileprivate var containerView = UIView()
    fileprivate var stackView = UIStackView()
    var skipForwardButton = UIButton()
    var skipBackwardbutton = UIButton()
    var playButton = UIButton()
    var pauseButton = UIButton()
    var stopButton = UIButton()
    
    var progressView: UIProgressView?
    var progressLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.performLayout()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
    
    fileprivate func performLayout() {
        containerView.backgroundColor = .white
        self.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(podcastLabel)
        
        podcastLabel.snp.makeConstraints { (make) -> Void in
            make.left.right.equalToSuperview().inset(15.calculateWidth())
            make.centerY.equalToSuperview().inset(-30.calculateHeight())
            make.centerX.equalToSuperview()
        }
        
        podcastLabel.font = UIFont.systemFont(ofSize: 16.calculateWidth())
        podcastLabel.numberOfLines = 0
        podcastLabel.textAlignment = .center
        
        containerView.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(70.calculateHeight())
            make.width.equalTo((50 * 5).calculateHeight())
            make.top.equalTo(podcastLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        stackView.addArrangedSubview(skipBackwardbutton)
        stackView.addArrangedSubview(stopButton)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(pauseButton)
        stackView.addArrangedSubview(skipForwardButton)
        
        let iconHeight = (70 / 2).calculateHeight()
        
        skipBackwardbutton.setImage(#imageLiteral(resourceName: "Backward"), for: .normal)
        skipBackwardbutton.height = iconHeight
        skipBackwardbutton.tintColor = Stylesheet.Colors.secondaryColor
        
        playButton.setIcon(icon: .fontAwesome(.play), iconSize: iconHeight, color: Stylesheet.Colors.secondaryColor, forState: .normal)
        pauseButton.setIcon(icon: .fontAwesome(.pause), iconSize: iconHeight, color: Stylesheet.Colors.secondaryColor, forState: .normal)
        stopButton.setIcon(icon: .fontAwesome(.stop), iconSize: iconHeight, color: Stylesheet.Colors.secondaryColor, forState: .normal)
        
        skipForwardButton.setImage(#imageLiteral(resourceName: "Forward"), for: .normal)
        skipForwardButton.height = iconHeight
        skipForwardButton.tintColor = Stylesheet.Colors.secondaryColor
        
        skipBackwardbutton.addTarget(self, action: #selector(self.skipBackwardButtonPressed), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(self.playButtonPressed), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(self.pauseButtonPressed), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(self.stopButtonPressed), for: .touchUpInside)
        skipForwardButton.addTarget(self, action: #selector(self.skipForwardButtonPressed), for: .touchUpInside)
        
        playButton.isHidden = true
        
        setupActivityIndicator()
        addControls()
    }
    
    func addControls() {
        // Create Progress View Control
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        progressView?.tintColor = Stylesheet.Colors.secondaryColor
        self.addSubview(progressView!)
        
        progressView?.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.height.equalTo(5.calculateHeight())
            make.left.right.equalToSuperview()
        }

        // Add Label
        self.addSubview(progressLabel)
        
        progressLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.height.width.equalTo(50.calculateHeight())
        }
        
        progressLabel.text = "0.0"
    }
    
    func updateDownloadProgress(progress: Int) {
        progressLabel.text = String(progress) + "%"
    }
    
    func updateCurrentTimeProgress(progress: Float) {
        progressView?.progress = progress
    }

    
    public func animateIn() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.frame.origin.y -= self.height
            self.frame = self.frame
        })
    }
    
    public func animateOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.frame.origin.y += self.height
            self.frame = self.frame
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    public func setText(text: String?) {
        podcastLabel.text = text ?? ""
    }
    
    func setupActivityIndicator() {
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.containerView.addSubview(activityView)
        
        activityView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10.calculateWidth())
        }
    }
    
    func setProgress() {
    
    }
}


extension AudioView {
    // MARK: Function
    func playButtonPressed() {
        delegate?.playButtonPressed()
    }
    
    func pauseButtonPressed() {
        delegate?.pauseButtonPressed()
    }
    
    func stopButtonPressed() {
        delegate?.stopButtonPressed()
    }
    
    func skipForwardButtonPressed() {
        delegate?.skipForwardButtonPressed()
    }
    
    func skipBackwardButtonPressed() {
        delegate?.skipBackwardButtonPressed()
    }
}


