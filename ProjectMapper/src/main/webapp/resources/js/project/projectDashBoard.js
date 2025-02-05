const contextPath = document.querySelector("#project_container").dataset.contextPath;

// getEelementById는 샘플 소스에 쓰고 관례적으로는 querySelector를 씀
const ctx = document.querySelector('#myChart');
const ctx2 = document.querySelector('#myChart2');
const ctx3 = document.querySelector('#myChart3');
const dashBoardNav = document.querySelector("#dashBoard");
dashBoardNav.classList.add("active");

let ygChart;
let ygChart2;
let ygChart3;

// 차트 생성, 생성자 return값을 받아서 사용하면 아주 편함 (핵심1)
fetch(`${contextPath}/project/taskProgress`)
.then(resp=>{
	return resp.json();
})
.then(data=>{
	console.log(data);
	ygChart = new Chart(ctx, {
		type: 'line',  // bar, line, pie, doughnut, radar, polarArea, bubble 등\
/*
		data: {
			labels: ['2025-01', '2025-02', '2025-03', '2025-04', '2025-05', '2025-06'],
			datasets: [{
				label: '업무 진행률[%]',
				data: [3, 3, 5, 12, 19, 30],
				borderWidth: 1
			}]
		},
*/
		data: data,
	
		options: {        // options 설정에 관한 내용은 google 검색으로 대체
			indexAxis: 'x',     // 수평차트로 바꿈
			scales: {
				y: {
					beginAtZero: true,
					max: 100
				}
			}
		}
	});
})
.catch(err=>{
	console.log(err);
})

fetch(`${contextPath}/project/taskVolume`)
.then(resp=>{
	return resp.json();
})
.then(data=>{
	ygChart2 = new Chart(ctx2, {
		type: 'doughnut',
		data : data
	});
})
.catch(err=>{
	console.log(err);
});

fetch(`${contextPath}/project/dailyTaskprogress`)
.then(resp=>{
	return resp.json();
})
.then(data=>{
	ygChart3 = new Chart(ctx3, {
		type: 'bar',
		data: data
	});
})
.catch();