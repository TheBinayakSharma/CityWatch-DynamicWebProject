<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- nav.jsp: included in every role view via <jsp:include page="/WEB-INF/views/common/nav.jsp"/> --%>

<div class="sidebar">
  <div class="brand">City<span>Watch</span></div>

  <nav>
    <c:choose>

      
      <c:when test="${sessionScope.role == 'ADMIN'}">

        <a href="${pageContext.request.contextPath}/admin/home"
           class="${fn:contains(pageContext.request.servletPath, 'home') ? 'active' : ''}">
           &#x2302; Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/admin/orgs"
           class="${fn:contains(pageContext.request.servletPath, 'orgs') ? 'active' : ''}">
           &#x1F3E2; Organizations
        </a>

        <a href="${pageContext.request.contextPath}/admin/civilians"
           class="${fn:contains(pageContext.request.servletPath, 'civilians') ? 'active' : ''}">
           &#x1F464; Civilians
        </a>

        <a href="${pageContext.request.contextPath}/admin/tasks"
           class="${fn:contains(pageContext.request.servletPath, 'tasks') ? 'active' : ''}">
           &#x1F4CB; All Tasks
        </a>

        <a href="${pageContext.request.contextPath}/admin/tasksInProgress"
           class="${fn:contains(pageContext.request.servletPath, 'InProgress') ? 'active' : ''}">
           &#x23F3; In Progress
        </a>

        <a href="${pageContext.request.contextPath}/admin/completedTasks"
           class="${fn:contains(pageContext.request.servletPath, 'completed') ? 'active' : ''}">
           &#x2714; Completed
        </a>

        <a href="${pageContext.request.contextPath}/admin/notices"
           class="${fn:contains(pageContext.request.servletPath, 'notices') ? 'active' : ''}">
           &#x1F4E2; Notices
        </a>

      </c:when>


      <c:when test="${sessionScope.role == 'ORGANIZATION'}">

        <a href="${pageContext.request.contextPath}/org/home"
           class="${fn:contains(pageContext.request.servletPath, 'home') ? 'active' : ''}">
           &#x2302; Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/org/notices"
           class="${fn:contains(pageContext.request.servletPath, 'notices') ? 'active' : ''}">
           &#x1F4E2; Notices
        </a>

        <a href="${pageContext.request.contextPath}/org/tasks"
           class="${fn:contains(pageContext.request.servletPath, 'tasks') ? 'active' : ''}">
           &#x1F4CB; Available Tasks
        </a>

        <a href="${pageContext.request.contextPath}/org/assigned"
           class="${fn:contains(pageContext.request.servletPath, 'assigned') ? 'active' : ''}">
           &#x23F3; My Tasks
        </a>

        <a href="${pageContext.request.contextPath}/org/completed"
           class="${fn:contains(pageContext.request.servletPath, 'completed') ? 'active' : ''}">
           &#x2714; Completed
        </a>

      </c:when>


      <c:when test="${sessionScope.role == 'CIVILIAN'}">

        <a href="${pageContext.request.contextPath}/civilian/home"
           class="${fn:contains(pageContext.request.servletPath, 'home') ? 'active' : ''}">
           &#x2302; Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/civilian/notices"
           class="${fn:contains(pageContext.request.servletPath, 'notices') ? 'active' : ''}">
           &#x1F4E2; Notices
        </a>

        <a href="${pageContext.request.contextPath}/civilian/tasks"
           class="${fn:contains(pageContext.request.servletPath, 'tasks') ? 'active' : ''}">
           &#x1F4CB; Tasks
        </a>

        <a href="${pageContext.request.contextPath}/civilian/inProgress"
           class="${fn:contains(pageContext.request.servletPath, 'inProgress') ? 'active' : ''}">
           &#x23F3; In Progress
        </a>

        <a href="${pageContext.request.contextPath}/civilian/completed"
           class="${fn:contains(pageContext.request.servletPath, 'completed') ? 'active' : ''}">
           &#x2714; Completed
        </a>

      </c:when>

    </c:choose>
  </nav>

  <div style="padding: 0 16px 8px;">
    <span style="font-size:0.78rem; color:rgba(255,255,255,0.5);">
      Signed in as
    </span><br>

    <span style="font-size:0.88rem; color:rgba(255,255,255,0.85); font-weight:600;">
      <c:out value="${sessionScope.fullName}"/>
    </span>
  </div>

  <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
    Logout
  </a>
</div>