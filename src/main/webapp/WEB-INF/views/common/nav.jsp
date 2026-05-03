<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

   <div class="sidebar">
      <div class="main-header">
         <div class="header-content">
            <div class="header-logo">City<span>Watch</span></div>
            <div class="header-tagline">Government &bull; Organizations &bull; Civilians</div>
            <div style="font-size:0.8rem; opacity:0.75;">
               Signed in as &nbsp;<strong>
                  <c:out value="${sessionScope.fullName}" />
               </strong>
               &nbsp;&bull;&nbsp;
               <c:out value="${sessionScope.role}" />
            </div>
         </div>
      </div>

      <div class="nav-content">
         <nav>
            <c:choose>
               <c:when test="${sessionScope.role == 'ADMIN'}">
                  <a href="${pageContext.request.contextPath}/admin/home">&#x2302; Dashboard</a>
                  <a href="${pageContext.request.contextPath}/admin/orgs">&#x1F3E2; Organizations</a>
                  <a href="${pageContext.request.contextPath}/admin/civilians">&#x1F464; Civilians</a>
                  <a href="${pageContext.request.contextPath}/admin/tasks">&#x1F4CB; Tasks</a>
                  <a href="${pageContext.request.contextPath}/admin/tasksInProgress">&#x23F3; In Progress</a>
                  <a href="${pageContext.request.contextPath}/admin/completedTasks">&#x2714; Completed</a>
                  <a href="${pageContext.request.contextPath}/admin/notices">&#x1F4E2; Notices</a>
               </c:when>
               <c:when test="${sessionScope.role == 'ORGANIZATION'}">
                  <a href="${pageContext.request.contextPath}/org/home">&#x2302; Dashboard</a>
                  <a href="${pageContext.request.contextPath}/org/notices">&#x1F4E2; Notices</a>
                  <a href="${pageContext.request.contextPath}/org/tasks">&#x1F4CB; Available Tasks</a>
                  <a href="${pageContext.request.contextPath}/org/assigned">&#x23F3; My Tasks</a>
                  <a href="${pageContext.request.contextPath}/org/inProgress">&#x1F30D; City Progress</a>
                  <a href="${pageContext.request.contextPath}/org/completed">&#x2714; Completed</a>
               </c:when>
                <c:when test="${sessionScope.role == 'CIVILIAN'}">
                   <a href="${pageContext.request.contextPath}/civilian/home">&#x2302; Dashboard</a>
                   <a href="${pageContext.request.contextPath}/civilian/requestTask">&#x2795; Request Task</a>
                   <a href="${pageContext.request.contextPath}/civilian/notices">&#x1F4E2; Notices</a>
                   <a href="${pageContext.request.contextPath}/civilian/tasks">&#x1F4CB; Tasks</a>
                   <a href="${pageContext.request.contextPath}/civilian/inProgress">&#x23F3; In Progress</a>
                   <a href="${pageContext.request.contextPath}/civilian/completed">&#x2714; Completed</a>
                </c:when>
            </c:choose>
         </nav>

         <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
      </div>
   </div>