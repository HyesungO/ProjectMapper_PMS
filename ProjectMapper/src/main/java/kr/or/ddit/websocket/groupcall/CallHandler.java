///*
// * (C) Copyright 2014 Kurento (http://kurento.org/)
// *
// * Licensed under the Apache License, Version 2.0 (the "License");
// * you may not use this file except in compliance with the License.
// * You may obtain a copy of the License at
// *
// *   http://www.apache.org/licenses/LICENSE-2.0
// *
// * Unless required by applicable law or agreed to in writing, software
// * distributed under the License is distributed on an "AS IS" BASIS,
// * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// * See the License for the specific language governing permissions and
// * limitations under the License.
// *
// */
//
//package kr.or.ddit.websocket.groupcall;
//
//import java.io.IOException;
//
//import org.kurento.client.IceCandidate;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.socket.CloseStatus;
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import com.google.gson.JsonObject;
//
///**
// * 
// * @author Ivan Gracia (izanmail@gmail.com)
// * @since 4.3.1
// */
//public class CallHandler extends TextWebSocketHandler {
//
//  private static final Logger log = LoggerFactory.getLogger(CallHandler.class);
//
//  private static final Gson gson = new GsonBuilder().create();
//
//  @Autowired
//  private RoomManager roomManager;
//
//  @Autowired
//  private UserRegistry registry;
//
//  @Override
//  public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//    final JsonObject jsonMessage = gson.fromJson(message.getPayload(), JsonObject.class);
//    
//    //데이터베이스에 넣은 userSession들고오기 (파라미터 websocketsession)
//    final UserSession user = registry.getBySession(session);
//
//    if (user != null) {
//      log.debug("Incoming message from user '{}': {}", user.getName(), jsonMessage);
//    } else {
//      log.debug("Incoming message from new user: {}", jsonMessage);
//    }
//
//    switch (jsonMessage.get("id").getAsString()) {
//      case "joinRoom":
//    	//방에 참가하기 
//    	//message로 받은거 json으로 받은거
//        joinRoom(jsonMessage, session);
//        break;
//        //다른사람이 보낸 비디오 받기
//      case "receiveVideoFrom":
//    	  //보낸사람
//        final String senderName = jsonMessage.get("sender").getAsString();
//        //보낸사람의  userSession들고오기 
//        final UserSession sender = registry.getByName(senderName);
////        //미디어 타입: 오디오, 비디오, 데이터 채널 등 어떤 종류의 미디어를 전송할지 명시합니다.
////        코덱 정보: 사용 가능한 오디오 및 비디오 코덱 정보가 포함됩니다.
////        네트워크 정보: 후보 네트워크 주소(ICE candidates)와 연결 프로토콜(TCP/UDP, IP 주소 등)을 포함합니다.
////        암호화 정보: 미디어 스트림 보안을 위한 DTLS-SRTP 등 암호화 정보가 포함됩니다.
//        //webrtc 객체만들때 같이 들어간 정보
//        final String sdpOffer = jsonMessage.get("sdpOffer").getAsString();
//        //나의 user객체안에 비디오받기 메서드 호출 
//        user.receiveVideoFrom(sender, sdpOffer);
//        break;
//      case "leaveRoom":
//        leaveRoom(user);
//        break;
//      case "onIceCandidate":
//        JsonObject candidate = jsonMessage.get("candidate").getAsJsonObject();
//
//        if (user != null) {
//          IceCandidate cand = new IceCandidate(candidate.get("candidate").getAsString(),
//              candidate.get("sdpMid").getAsString(), candidate.get("sdpMLineIndex").getAsInt());
//          user.addCandidate(cand, jsonMessage.get("name").getAsString());
//        }
//        break;
//      default:
//        break;
//    }
//  }
//
//  //서버연결이 끊길때 사용
//  @Override
//  public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//    UserSession user = registry.removeBySession(session);
//    roomManager.getRoom(user.getRoomName()).leave(user);
//  }
//  //
//  private void joinRoom(JsonObject params, WebSocketSession session) throws IOException {
//    final String roomName = params.get("room").getAsString();
//    final String name = params.get("name").getAsString();
//    log.info("PARTICIPANT {}: trying to join room {}", name, roomName);
//    //방이있는지 채크하고 없으면 새로생성
//    Room room = roomManager.getRoom(roomName);
//    //방에있는 기존의 참가자들에게 새로운 사람왔다고 websocket으로 전송 그리고 참가자리스트에 저장
//    final UserSession user = room.join(name, session);
//    registry.register(user);
//  }
//
//  private void leaveRoom(UserSession user) throws IOException {
//    final Room room = roomManager.getRoom(user.getRoomName());
//    room.leave(user);
//    if (room.getParticipants().isEmpty()) {
//      roomManager.removeRoom(room);
//    }
//  }
//}
