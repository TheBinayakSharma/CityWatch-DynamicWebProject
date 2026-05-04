<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request New Task &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header">
            <h1 class="page-title">Request a Community Task</h1>
            <p>Spotted an issue? Request a task for organizations to solve. Admin will review your request before posting.</p>
        </div>

        <div class="card" style="max-width: 600px;">
            <form action="${pageContext.request.contextPath}/civilian/requestTask" method="post">
                <div class="form-group">
                    <label>Task Title / Issue Name</label>
                    <input type="text" name="title" class="form-control" required placeholder="e.g., Road Pothole in Ward 4">
                </div>
                <div class="form-group" style="margin-top: 20px;">
                    <label>Detailed Description</label>
                    <textarea name="description" class="form-control" rows="5" required placeholder="Provide details like exact location and severity..."></textarea>
                </div>
                <div style="margin-top: 30px;">
                    <button type="submit" class="btn btn-primary">Submit Request</button>
                    <a href="${pageContext.request.contextPath}/civilian/home" class="btn btn-sm" style="background:#ddd; margin-left:10px;">Cancel</a>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>
