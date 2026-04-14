<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>Add Task &ndash; CityWatch</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
 <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
 <div class="main">
 <div class="page-header">
 <h1>Add New Task</h1>
 </div>
 <div class="card" style="max-width:560px;">
 <c:if test="${not empty errorMsg}">
 <div class="alert alert-danger"><c:out value="${errorMsg}"/></div>
 </c:if>
 <form action="${pageContext.request.contextPath}/admin/tasks" method="post">
 <input type="hidden" name="action" value="addTask">
 <div class="form-group">
 <label>Task Title</label>
 <input type="text" name="title" class="form-control" placeholder="Short task title" required>
 </div>
 <div class="form-group">
 <label>Description</label>
 <textarea name="description" class="form-control" placeholder="Detailed description of the task" 
required></textarea>
 </div>
 <div class="btn-group">
 <button type="submit" class="btn btn-success">Create Task</button>
 <a href="${pageContext.request.contextPath}/admin/tasks" class="btn btn-primary">Cancel</a>
 </div>
 </form>
 </div>
 <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
 </div>
</div>
</body>
</html>