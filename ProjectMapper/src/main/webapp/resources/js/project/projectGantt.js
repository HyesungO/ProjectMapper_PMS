document.addEventListener("DOMContentLoaded", async ()=>{
	
	const ganttNav = document.querySelector("#gantt");
	ganttNav.classList.add("active");
	
	const contextPath = document.querySelector("#project_container").dataset.contextPath;
	let pjId = document.querySelector("#project_container").dataset.pjId;

        function calculateResourceLoad(tasks, scale) {
            var step = scale.unit;
            var timegrid = {};

            for (var i = 0; i < tasks.length; i++) {
                var task = tasks[i];

                var currDate = gantt.date[step + "_start"](new Date(task.start_date));

                while (currDate < task.end_date) {

                    var date = currDate;
                    currDate = gantt.date.add(currDate, 1, step);

                    if (!gantt.isWorkTime({ date: date, task: task })) {
                        continue;
                    }

                    var timestamp = date.valueOf();
                    if (!timegrid[timestamp])
                        timegrid[timestamp] = 0;

                    timegrid[timestamp] += 8;
                }
            }

            var timetable = [];
            var start, end;
            for (var i in timegrid) {
                start = new Date(i * 1);
                end = gantt.date.add(start, 1, step);
                timetable.push({
                    start_date: start,
                    end_date: end,
                    value: timegrid[i]
                });
            }

            return timetable;
        }


        var renderResourceLine = function (resource, timeline) {
            var tasks = gantt.getTaskBy("user", resource.id);
            var timetable = calculateResourceLoad(tasks, timeline.getScale());

            var row = document.createElement("div");

            for (var i = 0; i < timetable.length; i++) {

                var day = timetable[i];

                var css = "";
                if (day.value <= 8) {
                    css = "gantt_resource_marker gantt_resource_marker_ok";
                } else {
                    css = "gantt_resource_marker gantt_resource_marker_overtime";
                }

                var sizes = timeline.getItemPosition(resource, day.start_date, day.end_date);
                var el = document.createElement('div');
                el.className = css;

                el.style.cssText = [
                    'left:' + sizes.left + 'px',
                    'width:' + sizes.width + 'px',
                    'position:absolute',
                    'height:' + (gantt.config.row_height - 1) + 'px',
                    'line-height:' + sizes.height + 'px',
                    'top:' + sizes.top + 'px'
                ].join(";");

                el.innerHTML = day.value;
                row.appendChild(el);
            }
            return row;
        };

        var resourceLayers = [
            renderResourceLine,
            "taskBg"
        ];

        // 색깔 에디터 추가
        let editor;
        gantt.config.editor_types.color = {
            show: function (id, column, config, placeholder) {
                var html = "<div><input type='color' name='" + column.name + "'></div>";
                placeholder.innerHTML = html;

                editor = $(placeholder).find("input").spectrum({
                    change: () => {
                        gantt.ext.inlineEditors.save();
                    }
                });

                setTimeout(() => {
                    editor.spectrum("show")
                })
            },
            hide: function () {
                if (editor) {
                    editor.spectrum("destroy");
                    editor = null;
                }
            },

            set_value: function (value, id, column, node) {
                editor.spectrum("set", value);
            },

            get_value: function (id, column, node) {
                return editor.spectrum("get").toHexString();
            },

            is_changed: function (value, id, column, node) {
                // console.log("THIS: ", this);
                var newValue = this.get_value(id, column, node);
                return newValue !== value;
            },

            is_valid: function (value, id, column, node) {
                var newValue = this.get_value(id, column, node);
                return !!newValue;
            },

            save: function (id, column, node) {
                // only for inputs with map_to:auto. complex save behavior goes here
            },
            focus: function (node) {
                editor.spectrum("show");
            }
        }

        const colorEditor = { type: "color", map_to: "color" };
		let colors = [
			"#fcffb0", "#acc4ff", "#c4f4fe", "#bee9b4", "#fcc6f7",
			"#afffba", "#ffe4af", "#e2ffaf", "#caa6fe", "#cce5ff"
		];

        var mainGridConfig = {
            columns: [
                { name: "text", tree: true, width: 200, resize: true },
                { name: "end_date", label: "마감일", align: "center", width: 110, resize: true },
                {
                    name: "owner", align: "center", width: 60, label: "담당자", template: function (task) {
//                        var store = gantt.getDatastore("resources");
//                        var owner = store.getItem(task.user);
						var owner = task.user;
                        if (owner) {
//                            return owner.label;
							return owner;
                        } else {
                            return "디폴트";
                        }
                    }
                },
//                { name: "duration", width: 50, align: "center" },
                { width: 1,
//                    name: "color", label: "색깔", align: "center", width: 50, resize: true, editor: colorEditor,
                    template: (task) => {
//                        if (!task.color) {
//                            if (task.type == "project") task.color = "#7fbc64";
//                            if (task.type == "milestone") task.color = "#d18c7f";
//                        }
//                        task.color = task.color || "#7e9667";
						task.color = task.color || colors[task.$index%10];
						task.textColor = "#555";
//                        return `<div class="task-color-cell" style="background:${task.color}"></div>`;
                    }
                },
				{ name: "progress", width: 50, label: "진행도"}
//                { name: "add", width: 44 }
            ]
        };

        var resourcePanelConfig = {
            columns: [
                {
                    name: "name", label: "Name", align: "center", template: function (resource) {
                        //console.log("체킁:", resource);
                        return resource.label;
                    }
                },
                {
                    name: "workload", label: "Workload", align: "center", template: function (resource) {
                        var tasks = gantt.getTaskBy("user", resource.id);

                        var totalDuration = 0;
                        for (var i = 0; i < tasks.length; i++) {
                            totalDuration += tasks[i].duration;
                        }

                        return (totalDuration || 0) * 8 + "";
                    }
                }
            ]
        };

        gantt.config.layout = {
            css: "gantt_container",
            rows: [
                {
                    cols: [
                        { view: "grid", group: "grids", config: mainGridConfig, scrollY: "scrollVer" },
                        { resizer: true, width: 1, group: "vertical" },
                        { view: "timeline", id: "timeline", scrollX: "scrollHor", scrollY: "scrollVer" },
                        { view: "scrollbar", id: "scrollVer", group: "vertical" }
                    ]
                },
                { resizer: true, width: 1 },
/*
                {
                    config: resourcePanelConfig,
                    cols: [
                        {
                            view: "grid",
                            id: "resourceGrid",
                            group: "grids",
                            bind: "resources",
                            scrollY: "resourceVScroll"
                        },
                        { resizer: true, width: 1, group: "vertical" },
                        {
                            view: "timeline",
                            id: "resourceTimeline",
                            bind: "resources",
                            bindLinks: null,
                            layers: resourceLayers,
                            scrollX: "scrollHor",
                            scrollY: "resourceVScroll"
                        },
                        { view: "scrollbar", id: "resourceVScroll", group: "vertical" }
                    ]
                },
*/
                { view: "scrollbar", id: "scrollHor" }
            ]
        };

        var resourcesStore = gantt.createDatastore({
            name: "resources",
            initItem: function (item) {
                item.id = item.key || gantt.uid();
                return item;
            }
        });

        var tasksStore = gantt.getDatastore("task");
        //console.log("체킁taskStore:", tasksStore);
        tasksStore.attachEvent("onStoreUpdated", function (id, item, mode) {
            resourcesStore.refresh();
        });


        // 기본 설정
        gantt.i18n.setLocale("kr");

        gantt.config.scales = [
            { unit: "month", step: 1, format: "%Y, %F" },
            { unit: "day", step: 1, format: "%D" },
            { unit: "day", step: 1, format: "%j" }
        ];
		gantt.config.scale_height = 50;

        //날짜 형식
        gantt.config.date_format = "%Y-%m-%d %H:%i"; // 실제 전달되는 데이타의 start_date등의 포맷
//		gantt.config.task_date = "%Y년 %m월 %d일";
        gantt.config.lightbox.sections[1].time_format=["%Y","%m","%d"];
        gantt.locale.labels.new_task="새 작업";
        gantt.config.task_date = "&nbsp;&nbsp;&nbsp;&nbsp;%Y년 %m월 %d일";

		gantt.config.min_column_width = 40;
		gantt.config.readonly = true;
         gantt.init("e7eGantt");

        resourcesStore.parse([	// resources
            { key: '0', label: "없음" },
            { key: '1', label: "E7E" },
            { key: '2', label: "메롱" },
            { key: '3', label: "황당" },
            { key: '4', label: "당황" },
            { key: '5', label: "우앙" },
            { key: '6', label: "오호" },
            { key: '7', label: "눈물" }
        ]);

        const fData = async () => {
//            let response = await fetch(`${contextPath}/resources/sampleData.json`);

            let response = await fetch(`${contextPath}/project/gantt/list/${pjId}`);
            let taskData = await response.json();
			let minStartDate = new Date('2900-01-01');
			let maxEndDate = new Date('1900-01-01');

			taskData.data.forEach(task=>{
				
				if(task.end_date==null) {
					task.duration = 1;
			        task.type = "milestone";  // 또는 마일스톤으로 설정
					task.end_date = task.start_date;
				}
				// "end_date": "2023-11-19 00:00"
				let endDate = new Date(task.end_date);
				endDate.setHours(endDate.getHours(23,59,59)+23);	// UTC가 기본이라서 한국 시간에 맞게 설정
				task.end_date = endDate.toISOString().substring(0,19).replace("T"," ");
/*
			    if (task.start_date == task.end_date) {
					task.duration = 1;
			        task.type = "milestone";  // 또는 마일스톤으로 설정
					let date = new Date(task.end_date);
					date.setDate(date.getDate() + 1);
					task.end_date = date.toISOString().substring(0,10);
			    }
*/
				minStartDate = minStartDate > new Date(task.start_date) ? new Date(task.start_date) : minStartDate;
				maxEndDate = maxEndDate < new Date(task.end_date) ? new Date(task.end_date) : maxEndDate;
				minStartDate.setDate(minStartDate.getDate()-1);
				maxEndDate.setDate(maxEndDate.getDate()+1);
				gantt.config.start_date = minStartDate.toISOString().substring(0,10);
				gantt.config.end_date = maxEndDate.toISOString().substring(0,10);
			});

            gantt.parse(taskData);

			let gantt_task_line = document.querySelectorAll(".gantt_task_line");
			gantt_task_line.forEach(v=>{
				v.addEventListener("click", e=>{
					let taskId = e.target.closest(".gantt_task_line").dataset.taskId;
					window.location=`${contextPath}/project/taskBoard/${taskId}`;
				})
			})

        }
        fData();
})