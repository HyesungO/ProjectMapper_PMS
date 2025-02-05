/*
 * (C) Copyright 2014 Kurento (http://kurento.org/)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

var ws = null;
var participants = null;
var name;
const PROTOCOL = location.href.startsWith("https")?"wss":"ws";

window.onbeforeunload = function() {
   ws.close();
};

function init(){
   participants = {};
   ws = new WebSocket(PROTOCOL+'://' + location.host + '/PM/groupcall');
   ws.onclose=function(){
      init();
   }
   ws.onmessage = function(message) {
      var parsedMessage = JSON.parse(message.data);
      console.info('Received message: ' + message.data);

      switch (parsedMessage.id) {
      
      case 'existingParticipants':
      //나의 비디오는 서버에보내주고 참가자의 데이터는 foreach로 받아서 화면에 보여준다
         onExistingParticipants(parsedMessage);
         break;
      case 'newParticipantArrived':
      //새로운 참가자가 발생하면 새로운 참가자 정보받아서 비디오에 출력
         onNewParticipant(parsedMessage);
         break;
      case 'participantLeft':
      //참가자가 나가면 
         onParticipantLeft(parsedMessage);
         break;
      case 'receiveVideoAnswer':
      //보낼때 바로 호출 ; 받은 webrtc객체를 참가자목록에서 한명의webtrc에 삽입
         receiveVideoResponse(parsedMessage);
         break;
      case 'iceCandidate':
         participants[parsedMessage.name].rtcPeer.addIceCandidate(parsedMessage.candidate, function (error) {
              if (error) {
               console.error("Error adding candidate: " + error);
               return;
              }
          });
          break;
      default:
         console.error('Unrecognized message', parsedMessage);
      }
   }
}

init();
document.addEventListener('DOMContentLoaded', function () {
	register();
})


//데이터베이스의 나의 이름하고 roomname입력하고 들어가기 
function register() {
   name =  document.body.dataset.user;
   var room = document.body.dataset.pjid;

   document.getElementById('room-header').innerText = '영상회의방 : ' + room;
   document.getElementById('join').style.display = 'none';
   document.getElementById('room').style.display = 'block';
   //이름하고 방이름
   var message = {
      id : 'joinRoom',
      name : name,
      room : room,
   }
   sendMessage(message);
}
//새로운 참가자 비디오 수신
function onNewParticipant(request) {
   receiveVideo(request.name);
}


function receiveVideoResponse(result) {
   //서버에서 받은 webrtc 비디오 데이터 참가자 한명에게 넣어주기 
   participants[result.name].rtcPeer.processAnswer (result.sdpAnswer, function (error) {
      if (error) return console.error (error);
   });
}

function callResponse(message) {
   if (message.response != 'accepted') {
      console.info('Call not accepted by peer. Closing call');
      stop();
   } else {
      webRtcPeer.processAnswer(message.sdpAnswer, function (error) {
         if (error) return console.error (error);
      });
   }
}
//나의 정보는 서버에 전달하고 기존에있는 참가자들은 나한테 보여준다
function onExistingParticipants(msg) {
   var constraints = {
      audio : true,
      video : {
         mandatory : {
            maxWidth : 320,
            maxFrameRate : 15,
            minFrameRate : 15
         }
      }
   };
   console.log(name + " registered in room " + room);
   //참가자 객체생성 내이름넣어서
   var participant = new Participant(name);
   //참가자 리스트에 나의 객체 삽입
   participants[name] = participant;
   var video = participant.getVideoElement();

   var options = {
         localVideo: video,
         mediaConstraints: constraints,
         onicecandidate: participant.onIceCandidate.bind(participant)
       }
   //참조로해서 rtc를 여기다가 넣어주는 객체생성
   participant.rtcPeer = new kurentoUtils.WebRtcPeer.WebRtcPeerSendonly(options,
      function (error) {
        if(error) {
           return console.error(error);
        }
        //비디오를 보내고  콜백함수로 
        this.generateOffer (participant.offerToReceiveVideo.bind(participant));
   });
   //침기지 비디오 돌려가면서받기
   msg.data.forEach(receiveVideo);
}

function leaveRoom() {
   sendMessage({
      id : 'leaveRoom'
   });

   for ( var key in participants) {
      participants[key].dispose();
   }

   document.getElementById('join').style.display = 'block';
   document.getElementById('room').style.display = 'none';

   ws.close();
}

//이름받아서 참가자목록중에 particpant들고오기
function receiveVideo(sender) {
   var participant = new Participant(sender);
   //자바스크립트의 참가자목록중 수신할사람 정보들고오기
   participants[sender] = participant;
   //참가자 비디오 들고오기
   var video = participant.getVideoElement();
   
   //나의 리모트비디오에 생성해줄꺼다라는거 설정
   var options = {
      remoteVideo: video,
     //이참가자의 ICE라는거 표시
      onicecandidate: participant.onIceCandidate.bind(participant)
    }
   //수신만하는 webrtc
   participant.rtcPeer = new kurentoUtils.WebRtcPeer.WebRtcPeerRecvonly(options,
         function (error) {
           if(error) {
              return console.error(error);
           }
           //수신해서 리모트비디오랑 연결
           this.generateOffer (participant.offerToReceiveVideo.bind(participant));
   });;
}

function onParticipantLeft(request) {
   console.log('Participant ' + request.name + ' left');
   var participant = participants[request.name];
   participant.dispose();
   delete participants[request.name];
}

function sendMessage(message) {
   var jsonMessage = JSON.stringify(message);
   console.log('Sending message: ' + jsonMessage);
   ws.send(jsonMessage);
}
