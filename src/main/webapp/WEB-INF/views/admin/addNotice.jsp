<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>Add Notice &ndash; CityWatch</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
 <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
 
 <div class="main">
 <div class="page-header">
 <h1>Post New Notice</h1>
 </div>
 
 <div class="card" style="max-width:560px;">
 <form action="${pageContext.request.contextPath}/admin/notices" method="post">
 <input type="hidden" name="action" value="addNotice">
 
 <div class="form-group">
 <label>Notice Title</label>
 <input type="text" name="title" class="form-control" placeholder="Brief notice title" required>
 </div>
 <div class="form-group">
 <label>Content</label>
 <textarea name="description" class="form-control" rows="5"
 placeholder="Full notice content visible to all users" required></textarea>
 </div>
 
 <div class="btn-group">
 <button type="submit" class="btn btn-success">Post Notice</button>
 <a href="${pageContext.request.contextPath}/admin/notices" class="btn btn-primary">Cancel</a>
 </div>
 </form>
 </div>
 <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
 </div>
</div>
</body>
</html>