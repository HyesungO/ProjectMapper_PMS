document.addEventListener("DOMContentLoaded", ()=>{
	
	const projectCalendarNav = document.querySelector("#projectCalendar");
	projectCalendarNav.classList.add("active");
	
	const contextPath = document.querySelector("#project_container").dataset.contextPath;
	const pjId = document.querySelector("#project_container").dataset.pjId;
	
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
			right: 'dayGridMonth,dayGridWeek,timeGridDay'
		},
		height: 700,
		eventSources: [
			{
				url: `${contextPath}/project/calendar/${pjId}`,
				method: 'post',
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
			location.href = `${contextPath}/project/taskBoard/${info.event.id}`;
		}
	});
	
	calendar.render();
});