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
                   <a href="${pageContext.request.contextPath}/admin/home">Dashboard</a>
                   <a href="${pageContext.request.contextPath}/admin/orgs">Organizations</a>
                   <a href="${pageContext.request.contextPath}/admin/civilians">Civilians</a>
                   <a href="${pageContext.request.contextPath}/admin/tasks">Tasks</a>
                   <a href="${pageContext.request.contextPath}/admin/notices">Notices</a>
                   <a href="${pageContext.request.contextPath}/admin/queries">Queries</a>
               </c:when>
               <c:when test="${sessionScope.role == 'ORGANIZATION'}">
                   <a href="${pageContext.request.contextPath}/org/home">Dashboard</a>
                   <a href="${pageContext.request.contextPath}/org/notices">Notices</a>
                   <a href="${pageContext.request.contextPath}/org/tasks">Available Tasks</a>
                   <a href="${pageContext.request.contextPath}/org/assigned">My Tasks</a>
                   <a href="${pageContext.request.contextPath}/org/inProgress">City Progress</a>
                   <a href="${pageContext.request.contextPath}/org/completed">Completed</a>
               </c:when>
                <c:when test="${sessionScope.role == 'CIVILIAN'}">
                    <a href="${pageContext.request.contextPath}/civilian/home">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/civilian/myRequests">My Requests</a>
                    <a href="${pageContext.request.contextPath}/civilian/requestTask">New Request</a>
                    <a href="${pageContext.request.contextPath}/civilian/notices">Notices</a>
                    <a href="${pageContext.request.contextPath}/civilian/tasks">Public Tasks</a>
                    <a href="${pageContext.request.contextPath}/civilian/inProgress">City Progress</a>
                    <a href="${pageContext.request.contextPath}/civilian/completed">Completed</a>
                </c:when>
            </c:choose>
         </nav>

         <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
      </div>
   </div>