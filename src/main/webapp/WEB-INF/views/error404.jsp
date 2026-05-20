<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Page Not Found</title>
    <style>
        body {
            font-family: 'DM Sans', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: #f9fafb;
        }
        .error-box {
            text-align: center;
            padding: 60px;
        }
        .error-code {
            font-size: 100px;
            font-weight: 700;
            color: #6c63ff;
            margin: 0;
        }
        .error-msg {
            font-size: 22px;
            font-weight: 600;
            color: #111827;
            margin: 10px 0;
        }
        .error-sub {
            font-size: 15px;
            color: #6b7280;
            margin-bottom: 30px;
        }
        .btn-home {
            padding: 12px 28px;
            background: #6c63ff;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="error-box">
    <p class="error-code">404</p>
    <p class="error-msg">Oops! Page Not Found</p>
    <p class="error-sub">The page you are looking for doesn't exist or has been moved.</p>
    <a href="${pageContext.request.contextPath}/home" class="btn-home">Go Back Home</a>
</div>
</body>
</html>