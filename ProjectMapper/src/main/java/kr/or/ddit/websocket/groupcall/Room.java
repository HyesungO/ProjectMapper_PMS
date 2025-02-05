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
//import java.io.Closeable;
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.Collection;
//import java.util.List;
//import java.util.concurrent.ConcurrentHashMap;
//import java.util.concurrent.ConcurrentMap;
//
//import javax.annotation.PreDestroy;
//
//import org.kurento.client.Continuation;
//import org.kurento.client.MediaPipeline;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.web.socket.WebSocketSession;
//
//import com.google.gson.JsonArray;
//import com.google.gson.JsonElement;
//import com.google.gson.JsonObject;
//import com.google.gson.JsonPrimitive;
//
///**
// * @author Ivan Gracia (izanmail@gmail.com)
// * @since 4.3.1
// */
//public class Room implements Closeable {
//  private final Logger log = LoggerFactory.getLogger(Room.class);
//
//  private final ConcurrentMap<String, UserSession> participants = new ConcurrentHashMap<>();
//  private final MediaPipeline pipeline;
//  private final String name;
//
//  public String getName() {
//    return name;
//  }
//
//  public Room(String roomName, MediaPipeline pipeline) {
//    this.name = roomName;
//    this.pipeline = pipeline;
//    log.info("ROOM {} has been created", roomName);
//  }
//
//  @PreDestroy
//  private void shutdown() {
//    this.close();
//  }
////방에 참가자 투입
//  public UserSession join(String userName, WebSocketSession session) throws IOException {
//    log.info("ROOM {}: adding participant {}", userName, userName);
//    //새로운참가자 Usersession 생성 
//    final UserSession participant = new UserSession(userName, this.name, session, this.pipeline);
//    //방에 참가자 투입 및 기존참가자들에게 들어왔다고 알리기 
//    joinRoom(participant);
//    participants.put(participant.getName(), participant);
//    //기존의 참가자 리스트를 나한테 보내기 
//    sendParticipantNames(participant);
//    //내 그런데 이채팅방에 해당되는 pipeline을 들고있는 usersession다시보내기 
//    return participant;
//  }
//
//  public void leave(UserSession user) throws IOException {
//    log.debug("PARTICIPANT {}: Leaving room {}", user.getName(), this.name);
//    this.removeParticipant(user.getName());
//    user.close();
//  }
//
//  private Collection<String> joinRoom(UserSession newParticipant) throws IOException {
//    final JsonObject newParticipantMsg = new JsonObject();
//    //새로운 차마가자인거 생성
//    newParticipantMsg.addProperty("id", "newParticipantArrived");
//    //새로운참가자이름 등록
//    newParticipantMsg.addProperty("name", newParticipant.getName());
//    
//    //기존참가자방 리스트 형식으로 들고오기 
//    final List<String> participantsList = new ArrayList<>(participants.values().size());
//    log.debug("ROOM {}: notifying other participants of new participant {}", name,
//        newParticipant.getName());
//    
//    for (final UserSession participant : participants.values()) {
//      try {
//    	//기존 참가자들에게 새로운 참가자왔다고 알림
//        participant.sendMessage(newParticipantMsg);
//      } catch (final IOException e) {
//        log.debug("ROOM {}: participant {} could not be notified", name, participant.getName(), e);
//      }
//      //기존 참가자리스트에 이름 넣기
//      participantsList.add(participant.getName());
//    }
//
//    return participantsList;
//  }
//
//  private void removeParticipant(String name) throws IOException {
//    participants.remove(name);
//
//    log.debug("ROOM {}: notifying all users that {} is leaving the room", this.name, name);
//
//    final List<String> unnotifiedParticipants = new ArrayList<>();
//    final JsonObject participantLeftJson = new JsonObject();
//    participantLeftJson.addProperty("id", "participantLeft");
//    participantLeftJson.addProperty("name", name);
//    for (final UserSession participant : participants.values()) {
//      try {
//        participant.cancelVideoFrom(name);
//        participant.sendMessage(participantLeftJson);
//      } catch (final IOException e) {
//        unnotifiedParticipants.add(participant.getName());
//      }
//    }
//
//    if (!unnotifiedParticipants.isEmpty()) {
//      log.debug("ROOM {}: The users {} could not be notified that {} left the room", this.name,
//          unnotifiedParticipants, name);
//    }
//
//  }
//
//  public void sendParticipantNames(UserSession user) throws IOException {
//
//    final JsonArray participantsArray = new JsonArray();
//    for (final UserSession participant : this.getParticipants()) {
//      if (!participant.equals(user)) {
//    	  //josn으로 참가자이름 하나하나 participantsArray에 넣기
//        final JsonElement participantName = new JsonPrimitive(participant.getName());
//        participantsArray.add(participantName);
//      }
//    }
//
//    final JsonObject existingParticipantsMsg = new JsonObject();
//    existingParticipantsMsg.addProperty("id", "existingParticipants");
//    existingParticipantsMsg.add("data", participantsArray);
//    log.debug("PARTICIPANT {}: sending a list of {} participants", user.getName(),
//        participantsArray.size());
//    user.sendMessage(existingParticipantsMsg);
//  }
//
//  public Collection<UserSession> getParticipants() {
//    return participants.values();
//  }
//
//  public UserSession getParticipant(String name) {
//    return participants.get(name);
//  }
//
//  @Override
//  public void close() {
//    for (final UserSession user : participants.values()) {
//      try {
//        user.close();
//      } catch (IOException e) {
//        log.debug("ROOM {}: Could not invoke close on participant {}", this.name, user.getName(),
//            e);
//      }
//    }
//
//    participants.clear();
//
//    pipeline.release(new Continuation<Void>() {
//
//      @Override
//      public void onSuccess(Void result) throws Exception {
//        log.trace("ROOM {}: Released Pipeline", Room.this.name);
//      }
//
//      @Override
//      public void onError(Throwable cause) throws Exception {
//        log.warn("PARTICIPANT {}: Could not release Pipeline", Room.this.name);
//      }
//    });
//
//    log.debug("Room {} closed", this.name);
//  }
//
//}
