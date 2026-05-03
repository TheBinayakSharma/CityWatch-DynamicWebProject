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
        <!-- Pending Requests Section -->
        <c:if test="${not empty pendingTasks}">
            <div class="card" style="margin-bottom: 40px; border-top: 4px solid var(--warning);">
                <div class="card-header" style="margin-bottom: 15px;">
                    <h2 style="font-size: 1.2rem; color: var(--warning);">Pending Task Requests</h2>
                    <p style="font-size: 0.9rem; color: var(--muted);">Tasks requested by civilians awaiting approval.</p>
                </div>
                <div class="table-wrap">
                    <table>
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Requester ID</th>
                            <th>Requested At</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="t" items="${pendingTasks}" varStatus="st">
                            <tr onclick="showTaskDetails(this)"
                                style="background: #fffbef;"
                                data-id="${t.id}"
                                data-title="<c:out value='${t.title}'/>"
                                data-description="<c:out value='${t.description}'/>"
                                data-status="${t.status}">
                                <td><c:out value="${st.count}"/></td>
                                <td><c:out value="${t.title}"/></td>
                                <td><c:out value="${t.description}"/></td>
                                <td><span class="badge" style="background:var(--warning); color:white;">Pending</span></td>
                                <td>User #<c:out value="${t.createdBy}"/></td>
                                <td><fmt:formatDate value="${t.createdAt}" pattern="dd MMM yyyy"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <div class="action-bar" style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
            <div class="filter-group" style="display:flex; align-items:center; gap:10px;">
                <label style="font-weight:600; color:var(--dark);">Filter by Status:</label>
                <select id="statusFilter" class="form-control" style="width:200px; padding:8px 12px; border-radius:8px; border:1px solid var(--border);" onchange="filterTasks()">
                    <option value="ALL" ${currentFilter == 'ALL' ? 'selected' : ''}>All Tasks</option>
                    <option value="AVAILABLE" ${currentFilter == 'AVAILABLE' ? 'selected' : ''}>Available</option>
                    <option value="IN_PROGRESS" ${currentFilter == 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                    <option value="COMPLETED" ${currentFilter == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                </select>
            </div>
            <button class="btn btn-primary" onclick="prepareAddTask()">+ Post New Task</button>
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

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>

<script>
    initializeDetailsForm('${pageContext.request.contextPath}/admin/tasks', 'updateTask', 'deleteTask', 'Edit Task');

    function filterTasks() {
        var status = document.getElementById('statusFilter').value;
        window.location.href = '${pageContext.request.contextPath}/admin/tasks?status=' + status;
    }

    function showTaskDetails(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        window.currentTaskStatus = d.status;
        var content = 
            createFormField('Task Title', 'title', d.title) +
            createFormField('Current Status', '', d.status, 'text', '', true) +
            createFormField('Description', 'description', d.description, 'textarea') +
            createFormField('Assigned To', '', d.org || 'Not Assigned', 'text', '', true) +
            createFormField('Created At', '', d.created, 'text', '', true) +
            createFormField('Completed At', '', d.completed, 'text', '', true);
        
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