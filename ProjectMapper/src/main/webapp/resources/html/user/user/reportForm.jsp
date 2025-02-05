<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이미지 업로드</title>
    <style>
        .report-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 400px;
            margin: 20px auto;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 8px;
        }
        .image-upload {
            width: 100px;
            height: 100px;
            border: 1px dashed #ccc;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            color: #999;
            margin-bottom: 10px;
            border-radius: 4px;
            position: relative;
            overflow: hidden;
        }
        .image-upload label {
            display: block;
            width: 100%;
            height: 100%;
            line-height: 100px;
            text-align: center;
            cursor: pointer;
        }
        .image-upload input[type="file"] {
            display: none;
        }
        .input-box input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }
        .textarea-box textarea {
            width: 100%;
            height: 100px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            resize: none;
        }
        .textarea-box .char-count {
            text-align: right;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }
        .report-button {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .report-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <form method="post" enctype="multipart/form-data" class="report-container">
        <div class="image-upload">
            <label for="image-upload">클릭하여 이미지 업로드</label>
            <input type="file" id="image-upload" name="image" accept="image/*">
        </div>
        <div class="input-box">
            <input type="text" name="reportId" placeholder="신고 대상자 ID">
        </div>
        <div class="textarea-box">
            <textarea name="reportMessage" placeholder="이상한 말해요"></textarea>
            <div class="char-count">0 / 1000</div>
        </div>
        <button type="submit" class="report-button">신고</button>
    </form>
</body>
</html>

</html>
