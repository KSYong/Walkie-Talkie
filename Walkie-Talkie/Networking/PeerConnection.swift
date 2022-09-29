//
//  PeerConnection.swift
//  Walkie-Talkie
//
//  Created by SEUNGYONG KWON on 2022/09/08.
//

import Foundation
import Network
import AVFAudio

var sharedConnection: PeerConnection?

protocol PeerConnectionDelegate: AnyObject {
    func connectionReady()
    func connectionFailed()
    func connectionCanceled()
    func receivedAudio(data: Data)
    func displayAdvertiseError(_ error: NWError)
}

class PeerConnection {
    
    weak var delegate: PeerConnectionDelegate?
    var connection: NWConnection?
    let initiatedConnection: Bool
    
    // 유저가 워키토키 방을 만들면 outbound connection 생성
    init(endpoint: NWEndpoint, interface: NWInterface?, frequency: String, delegate: PeerConnectionDelegate) {
        self.delegate = delegate
        self.initiatedConnection = true
        
        // frequency를 인자로 하는 NWParameters를 사용해 endpoint를 향한 NWConnection 수립
        let connection = NWConnection(to: endpoint, using: NWParameters(frequency: frequency))
        self.connection = connection
        
        startConnection()
    }
    
    // 유저가 연결 요청을 받으면(다른 유저가 워키토키 방에 들어오면) inbound 연결 handle
    init(connection: NWConnection, delegate: PeerConnectionDelegate) {
        self.delegate = delegate
        self.connection = connection
        self.initiatedConnection = false
        
        startConnection()
    }
    
    // 워키토키 연결을 cancel하는 함수
    func cancel() {
        if let connection = self.connection {
            connection.cancel()
            self.connection = nil
        }
    }
    
    // inbound와 outbound 연결을 위한 p2p 연결 시작
    func startConnection() {
        guard let connection = connection else {
            return
        }
        
        connection.stateUpdateHandler = { newState in
            switch newState{
            case .ready:
                print("\(connection) established")
                
                // delegate에게 연결이 ready 상태임을 알린다
                if let delegate = self.delegate {
                    delegate.connectionReady()
                }
                
                // 동시에 오디오 수신 시작한다
                self.receiveRecordedAudio()
                
            case .failed(let error):
                print("\(connection) failed with \(error)")
                
                // 연결 실패일 경우 connection cancel
                connection.cancel()
                
                // delegate에게 연결이 실패했음을 알린다
                if let delegate = self.delegate{
                    delegate.connectionFailed()
                }
            
            case .cancelled:
                print("\(connection) canceled")
                
                if let delegate = self.delegate {
                    delegate.connectionFailed()
                }
                
            default:
                print("\(newState)")
                break
            }
        }
        
        connection.start(queue: .main)
    }
    
    /// 저장된 버퍼 데이터를 전송하는 함수이다.
    /// - Parameter buffer: 를 Data 타입으로 변환한 데이터.
    func sendRecordedBuffer(buffer: Data){
        guard let connection = connection else {
            print("connection optional unwrap failed: sendRecordedAudio")
            return
        }
        
        connection.send(content: buffer, completion: .contentProcessed({ (error) in
            if let error = error {
                print("Send buffer error: \(error)")
            }
        }))
    }
    
    /// 녹음된 파일을 전송받는 함수이다.
    func receiveRecordedAudio() {
        
        guard let connection = connection else {
            print("connection optional unwrap failed: receiveRecordedAudio")
            return
        }
        
        
        connection.receiveMessage{ (data, context, isComplete, error) in
            
            // 전송받는 data의 길이를 살펴 receiveMessage 루프 만들기
            if let incomingData = data {
                self.delegate?.receivedAudio(data: incomingData)
            }
            
            if let error = error {
                print("\(error) occurred in receiveRecordedAudio")
                connection.cancel()
            }
            
            // 에러가 없다면 다시 받기 수행
            self.receiveRecordedAudio()
        }
    }
}
