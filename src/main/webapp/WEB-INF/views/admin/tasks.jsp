<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Tasks &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
            <div>
                <h1 class="page-title" style="margin: 0;">Task Management</h1>
                <p style="margin: 5px 0 0 0; color: var(--muted);">Track and manage all community tasks.</p>
            </div>
            <button class="btn btn-primary" onclick="prepareAddTask()">+ New Task</button>
        </div>

        <div class="card">
            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Assigned To</th>
                        <th>Created</th>
                        <th>Completed</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty tasks}">
                            <tr><td colspan="7" style="text-align:center;color:#888;">No tasks found.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="t" items="${tasks}" varStatus="st">
                                <tr onclick="showTaskDetails(this)"
                                    data-id="${t.id}"
                                    data-title="<c:out value='${t.title}'/>"
                                    data-description="<c:out value='${t.description}'/>"
                                    data-status="${t.status}"
                                    data-org="${t.assignedOrgName}"
                                    data-created="<fmt:formatDate value='${t.createdAt}' pattern='dd MMM yyyy, HH:mm'/>"
                                    data-completed="<fmt:formatDate value='${t.completedAt}' pattern='dd MMM yyyy, HH:mm'/>">
                                    <td><c:out value="${st.count}"/></td>
                                    <td><c:out value="${t.title}"/></td>
                                    <td><c:out value="${t.description}"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${t.status == 'AVAILABLE'}">
                                                <span class="badge badge-available">Available</span>
                                            </c:when>
                                            <c:when test="${t.status == 'IN_PROGRESS'}">
                                                <span class="badge badge-in-progress">In Progress</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-completed">Completed</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><c:out value="${not empty t.assignedOrgName ? t.assignedOrgName : '—'}"/></td>
                                    <td><fmt:formatDate value="${t.createdAt}" pattern="dd MMM yyyy"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty t.completedAt}">
                                                <fmt:formatDate value="${t.completedAt}" pattern="dd MMM yyyy"/>
                                            </c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/admin/detailsInclude.jsp"/>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>

<script>
    initializeDetailsForm('${pageContext.request.contextPath}/admin/tasks', 'updateTask', 'deleteTask', 'Edit Task');

    function showTaskDetails(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var content = 
            createFormField('Task Title', 'title', d.title) +
            createFormField('Current Status', '', d.status, 'text', true) +
            createFormField('Description', 'description', d.description, 'textarea') +
            createFormField('Assigned To', '', d.org || 'Not Assigned', 'text', true) +
            createFormField('Created At', '', d.created, 'text', true) +
            createFormField('Completed At', '', d.completed, 'text', true);
        
        showDetailsForm(content, d.id, false, row);
    }

    function prepareAddTask() {
        var content = 
            createFormField('Task Title', 'title', '', 'text', 'Describe the task shortly') +
            createFormField('Description', 'description', '', 'textarea', 'Detailed instructions for the organization');
        
        showDetailsForm(content, '', false, null, false, true, 'addTask');
    }
</script>
</body>
</html>