let contextPath = document.querySelector("#project_container").dataset.contextPath;
let businessReady = document.querySelector("#businessReady");
let businessDone = document.querySelector("#businessDone");
let businessBlack = document.querySelector("#businessBlack");

var dflt = {
	min: 0,
	max: 100,
	donut: true,
	gaugeWidthScale: 0.5,
	counter: true,
	hideInnerShadow: true
}

let gg1;
let gg2;

fetch(`${contextPath}/system/systemDashBoard/businessCnt`)
.then(resp=>{
	return resp.json();
})
.then(data=>{
	businessReady.innerText = data.readyCnt;
	businessDone.innerText = data.activeCnt;
	businessBlack.innerText = data.blackCnt;
})
.catch(err=>{
	console.log(err);
});

fetch(`${contextPath}/system/systemDashBoard/reportCnt`)
.then(resp=>{
	return resp.json();
})
.then(data=>{
	let ready = data.reportCntN;
	let done = data.reportCntY;

	gg1 = new JustGage({
		id: 'gg1',
		title: '처리 대기',
		value: ready,
		label: '%',
		labelFontColor: '#000',
	    levelColors: ["#d1ef06", "#F9c802", "#FF0000"],
	    gradient: { 0: "#d1ef06", 1: "#FF0000" },
		defaults: dflt
	});
	
	gg2 = new JustGage({
		id: 'gg2',
		title: '처리 완료',
		value: done,
		label: '%',
		labelFontColor: '#000',
	    levelColors: ["#FF0000", "#F9c802", "#d1ef06"],
	    gradient: { 0: "#FF0000", 1: "#d1cf06" },
		defaults: dflt
	});

})
.catch(err=>{
	console.log(err);
});



const ctx = document.querySelector('#myChart');
const ctx2 = document.querySelector('#myChart2');
const ctx3 = document.querySelector('#myChart3');

let ygChart;
let ygChart2;
let ygChart3;

// 차트 생성, 생성자 return값을 받아서 사용하면 아주 편함 (핵심1)

fetch(`${contextPath}/system/systemDashBoard/pjCnt`)
.then(resp=>{
	return resp.json();
})
.then(data=>{
	ygChart = new Chart(ctx, {
	    type: 'bar',  // bar, line, pie, doughnut, radar, polarArea, bubble 등
	    data: data
	});
})
.catch(err=>{
	console.log(err);
})

fetch(`${contextPath}/system/systemDashBoard/visitCnt`)
.then(resp=>{
	return resp.json();
})
.then(data=>{
	ygChart2 = new Chart(ctx2, {
	    type: 'line',  // bar, line, pie, doughnut, radar, polarArea, bubble 등
	    data: data
	});
})
.catch(err=>{
	console.log(err);
})

fetch(`${contextPath}/system/systemDashBoard/pjCategory`)
.then(resp=>{
	return resp.json();
})
.then(data=>{
	ygChart3 = new Chart(ctx3, {
		type: 'doughnut',
	    data: data
	});
})
.catch(err=>{
	console.log(err);
})