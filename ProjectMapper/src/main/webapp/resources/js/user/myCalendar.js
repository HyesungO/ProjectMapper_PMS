// fullcalendar 로드
document.addEventListener('DOMContentLoaded', function() {
	mySchedule();
});

let colors = [
	"#7e9667", "#aee611", "#ee96e7", "#7eb3b2", "#7ea6a7",
	"#7e3637", "#7e96e7", "#7e2267", "#279637", "#3e3667"
];

function mySchedule() {
	const contextPath = document.querySelector("#calendar-container").dataset.contextPath;
    const calendarEl = document.getElementById('calendar');
	const userId = document.querySelector("#calendar-container").dataset.userId;
    
    // FullCalendar 옵션 설정
    const calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar: {
			left: 'prevYear,prev,next,nextYear today',
			center: 'title',
			right: 'pjScheduleButton dayGridMonth,dayGridWeek,timeGridDay'
		},
        customButtons: {
            pjScheduleButton: {
//                icon: 'chevron-left',
                text: 'Proejct Schedule',
                hint: 'custom button',
                click: function() {
					projectSchedule();
                }
            }
        },
        initialView: 'dayGridMonth',
        selectable: true, // 달력 셀 선택 활성화
		displayEventTime: false,	// 시간 표시 제거
        select: function(info) {	// 달력 셀을 클릭할 때 모달 열기
            $('#addEventModal').modal('show'); 
            $('#start').val(info.startStr); 
			let endDate = new Date(info.endStr);
			endDate.setDate(endDate.getDate() - 1);
            $('#end').val(endDate.toISOString().substring(0,10));
        },

		eventSources: [
			{
				url: `${contextPath}/project/user/mySchedule?userId=${userId}`,
				textColor: `#858`,
				success: function(e) {
					e.forEach((v,i)=>{
						v.textColor = v.textColor || colors[i%10];
					})
				}
			}
		],
		eventClick: function(info) {
			// console.log(info.event.id);
			eventId = info.event.id;
			
			$('#addEventModal_update').modal('show');
			fetch(`${contextPath}/project/user/mySchedule/one?schId=${info.event.id}`)
			.then(resp=>{
				return resp.json();
			})
			.then(data=>{
				$('#title_update').val(data.title);
				$('#content_update').val(data.content);
				$('#start_update').val(data.start);
				$('#end_update').val(data.end.substring(0,10));
			})
			.catch(err=>{
				console.log(err);
			});
		}
    });

	document.querySelector("#scheduleModalCancel").addEventListener("click",()=>{
		$('#addEventModal').modal('hide');
	});

	document.querySelector("#scheduleModalCancel_update").addEventListener("click",()=>{
		$('#addEventModal_update').modal('hide');
	});
    
    calendar.render();
    

    // 등록 폼 제출 시
    $('#eventForm').submit(async function(e) {
        e.preventDefault(); // 폼의 기본 동작 방지

        // 입력된 정보 가져오기
        const content = $('#content').val();
        const title = $('#title').val();
        const start = $('#start').val();
        const end = $('#end').val();

		let schId = await fetch(`${contextPath}/project/user/mySchedule/schId`);
		let schIdJson = await schId.json();
		
		let scheduleData = {
			id: schIdJson,
			title: title,
			start: start,
			end: end,
			extendedProps: {
				userId: userId,
				content: content
			}
		};
        
		fetch(`${contextPath}/project/user/mySchedule`, {
			method: 'post',
			headers: {
				"Content-Type" : "application/json"
			},
			body: JSON.stringify(scheduleData)
		})
        .then(function() {
            $('#addEventModal').modal('hide'); // 모달 닫기
            calendar.refetchEvents(); // 달력 갱신
//            resetForm(); // form 초기화
            $('#eventForm')[0].reset(); // form 초기화
//			calendar.addEvent(scheduleData);	// 캘린더에 등록
        })
        .catch(function(error) {
            console.error(error);
        });
    });

	// 수정
    $('#eventForm_update').submit(async function(e) {
        e.preventDefault(); // 폼의 기본 동작 방지

        // 입력된 정보 가져오기
        const content = $('#content_update').val();
        const title = $('#title_update').val();
        const start = $('#start_update').val();
        const end = $('#end_update').val();
		
		let scheduleData = {
			id: eventId,
			title: title,
			start: start,
			end: end,
			extendedProps: {
				userId: 'userId',
				content: content
			}
		};
        
		fetch(`${contextPath}/project/user/mySchedule`, {
			method: 'put',
			headers: {
				"Content-Type" : "application/json"
			},
			body: JSON.stringify(scheduleData)
		})
        .then(function() {
            $('#addEventModal_update').modal('hide'); // 모달 닫기
            calendar.refetchEvents(); // 달력 갱신
            $('#eventForm_update')[0].reset(); // form 초기화
        })
        .catch(function(error) {
            console.error(error);
        });
    });

	// 삭제
	scheduleModalDeleteBtn = document.querySelector('#scheduleModalDeleteBtn');
	scheduleModalDeleteBtn.addEventListener("click", e=>{
		e.preventDefault();
		Swal.fire({
			icon: "warning",
			title: "삭제하시겠습니까?",
//			text: "삭제하시겠습니까?",
			showCancelButton: true,
            confirmButtonText: '삭제',
            cancelButtonText: '취소',
            confirmButtonColor: '#fa3b1d',
            cancelButtonColor: '#31374a',
		})
		.then(resp=>{
			if(resp.isConfirmed) {
				fetch(`${contextPath}/project/user/mySchedule`, {
					method: 'delete',
					headers: {
						"Content-Type" : "application/json"
					},
					body: JSON.stringify(eventId)
				})
		        .then(function() {
					Swal.fire({
						icon: "success",
						title: "삭제되었습니다.",
						confirmButtonText: 'OK'
					})
		            $('#addEventModal_update').modal('hide'); // 모달 닫기
		            calendar.refetchEvents(); // 달력 갱신
		            $('#eventForm_update')[0].reset(); // form 초기화
		        })
		        .catch(function(error) {
		            console.error(error);
		        });
			}
		});
	});
}

function projectSchedule() {
	const contextPath = document.querySelector("#calendar-container").dataset.contextPath;
	const userId = document.querySelector("#calendar-container").dataset.userId;
	
	let calendarEl = document.querySelector("#calendar");
	
	let colors = [
		"#7e9667", "#aee611", "#ee96e7", "#7eb3b2", "#7ea6a7",
		"#7e3637", "#7e96e7", "#7e2267", "#279637", "#3e3667"
	];
	
	let calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth',
		headerToolbar: {
			left: 'prevYear,prev,next,nextYear today',
			center: 'title',
			right: 'myScheduleButton dayGridMonth,dayGridWeek,timeGridDay'
		},
        customButtons: {
            myScheduleButton: {
//                icon: 'chevron-left',
                text: 'My Schedule　　',
                hint: 'custom button',
                click: function() {
					mySchedule();
                }
            }
        },
		height: 700,
		eventSources: [
			{
				url: `${contextPath}/project/user/pjScheduleList?userId=${userId}`,
				textColor: `#858`,
				success: function(e) {
					e.forEach((v,i)=>{
						v.textColor = v.textColor || colors[i%10];
					})
				}
			}
		],
		eventClick: function(info) {
			console.log(info);
			console.log(info.event);
			console.log(info.event.id);
			taskId = info.event.id;
			
			$('#addEventModal_move').modal('show');
			fetch(`${contextPath}/project/user/pjSchedule?taskId=${taskId}`)
			.then(resp=>{
				return resp.json();
			})
			.then(data=>{
				$('#title_move').val(data.title);
				$('#content_move').val(data.content);
				$('#start_move').val(data.start);
				$('#end_update').val(data.end.substring(0,10));

				document.querySelector("#scheduleModal_move").addEventListener("click",()=>{
					location.href = `${contextPath}/project/taskBoard/${info.event.id}`;
				});
				
				document.querySelector("#scheduleModalCancel_move").addEventListener("click",()=>{
					$('#addEventModal_move').modal('hide');
				});
			})
			.catch(err=>{
				console.log(err);
			});
		}
	});

	
	calendar.render();
}