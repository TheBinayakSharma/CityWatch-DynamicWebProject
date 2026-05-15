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
                   <a href="${pageContext.request.contextPath}/admin/home"><i class="fa-solid fa-house"></i> Dashboard</a>
                   <a href="${pageContext.request.contextPath}/admin/orgs"><i class="fa-solid fa-building-columns"></i> Organizations</a>
                   <a href="${pageContext.request.contextPath}/admin/civilians"><i class="fa-solid fa-users"></i> Civilians</a>
                   <a href="${pageContext.request.contextPath}/admin/tasks"><i class="fa-solid fa-list-check"></i> Tasks</a>
                   <a href="${pageContext.request.contextPath}/admin/notices"><i class="fa-solid fa-bullhorn"></i> Notices</a>
               </c:when>
               <c:when test="${sessionScope.role == 'ORGANIZATION'}">
                   <a href="${pageContext.request.contextPath}/org/home"><i class="fa-solid fa-house"></i> Dashboard</a>
                   <a href="${pageContext.request.contextPath}/org/notices"><i class="fa-solid fa-bullhorn"></i> Notices</a>
                   <a href="${pageContext.request.contextPath}/org/tasks"><i class="fa-solid fa-list-check"></i> Available Tasks</a>
                   <a href="${pageContext.request.contextPath}/org/assigned"><i class="fa-solid fa-hourglass-half"></i> My Tasks</a>
                   <a href="${pageContext.request.contextPath}/org/inProgress"><i class="fa-solid fa-earth-asia"></i> City Progress</a>
                   <a href="${pageContext.request.contextPath}/org/completed"><i class="fa-solid fa-circle-check"></i> Completed</a>
               </c:when>
                <c:when test="${sessionScope.role == 'CIVILIAN'}">
                    <a href="${pageContext.request.contextPath}/civilian/home"><i class="fa-solid fa-house"></i> Dashboard</a>
                    <a href="${pageContext.request.contextPath}/civilian/myRequests"><i class="fa-solid fa-pen-to-square"></i> My Requests</a>
                    <a href="${pageContext.request.contextPath}/civilian/requestTask"><i class="fa-solid fa-circle-plus"></i> New Request</a>
                    <a href="${pageContext.request.contextPath}/civilian/notices"><i class="fa-solid fa-bullhorn"></i> Notices</a>
                    <a href="${pageContext.request.contextPath}/civilian/tasks"><i class="fa-solid fa-list-check"></i> Public Tasks</a>
                    <a href="${pageContext.request.contextPath}/civilian/inProgress"><i class="fa-solid fa-hourglass-half"></i> City Progress</a>
                    <a href="${pageContext.request.contextPath}/civilian/completed"><i class="fa-solid fa-circle-check"></i> Completed</a>
                </c:when>
            </c:choose>
         </nav>

         <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
      </div>
   </div>