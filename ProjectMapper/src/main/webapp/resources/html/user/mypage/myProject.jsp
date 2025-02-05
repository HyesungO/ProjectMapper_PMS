<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 검색</title>
</head>

<Style>


	.container {
	    max-width: 800px;
	    margin: 50px auto;
	    background: #fff;
	    border-radius: 8px;
	    padding: 20px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	    
	    
	    
	}
	
	.search-bar {
	    display: flex;
	    margin-bottom: 20px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    overflow: hidden;
	}
	
	.search-bar input {
	    flex: 1;
	    padding: 10px;
	    border: none;
	    outline: none;
	}
	

	
	.search-bar button:hover {
	    background-color: #0056b3;
	}
	
	.project-table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	.project-table thead {
	    background-color: #f1f1f1;
	}
	
	.project-table th, .project-table td {
	    padding: 10px;
	    text-align: left;
	    border-bottom: 1px solid #ddd;
	}
	
	.project-info {
	    display: flex;
	    align-items: center;
	}
	
	#mypage-project{
		width: 2000px;
	
	
	}
	.content-body .container {
		   margin-top: 150px;
	}


</Style>


<body>



    <div class="container" id ="mypage-project">
        <div class="search-bar">
            <input type="text" placeholder="프로젝트 검색">
            <span class="search_icon p-3 c-pointer" data-toggle="dropdown">
                                    <i class="mdi mdi-magnify"></i>
                                </span>
        </div>
        <table class="project-table">	
            <thead>
                <tr>
                    <th>이름</th>
                    <th>유형</th>
                    <th>리더</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div class="project-info">
                            <div>프로젝트</div>
                        </div>
                    </td>
                    <td>프로젝트 이름</td>
                    <td>팀에서 관리하는 소프트웨어</td>
                    <td>ㅇㅇ</td>
                </tr>
                <tr>
                    <td>
                        <div class="project-info">
                            <div>프로젝트2</div>
                        </div>
                    </td>
                    <td>프로젝트 이름</td>
                    <td>프로젝트 이름</td>
                    <td>ㅇㅇ</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
