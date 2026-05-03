<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Active Tasks &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.2">
    <script src="${pageContext.request.contextPath}/js/table-utils.js?v=1.2"></script>
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header">
            <h1>My Active Tasks</h1>
            <p>Tasks currently assigned to your organization.</p>
        </div>
        <div class="card">
            <div class="search-bar">
                <div class="search-bar-inner">
                    <input type="text" id="assignedSearch" placeholder="Search my tasks by title...">
                </div>
                <select class="sort-select" onchange="triggerSort('assignedTable', this.value)">
                    <option value="">Sort By...</option>
                    <option value="1">Title</option>
                    <option value="3">Date Assigned</option>
                </select>
                <button class="search-btn" onclick="triggerSearch('assignedSearch')">Search</button>
            </div>
            <div class="table-wrap">
                <table id="assignedTable">
                    <thead>
                    <tr><th>#</th><th>Title</th><th>Claimed On</th><th>Status</th></tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty tasks}">
                            <tr><td colspan="4" style="text-align:center;color:#888;">No active tasks. Claim one from Available Tasks.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="t" items="${tasks}" varStatus="st">
                                <tr onclick="showTaskDetail(this)"
                                    data-id="${t.id}"
                                    data-title="<c:out value='${t.title}'/>"
                                    data-desc="<c:out value='${t.description}'/>"
                                    data-date="<fmt:formatDate value='${t.createdAt}' pattern='dd MMM yyyy, HH:mm'/>">
                                    <td><c:out value="${st.count}"/></td>
                                    <td><c:out value="${t.title}"/></td>
                                    <td><fmt:formatDate value="${t.createdAt}" pattern="dd MMM yyyy"/></td>
                                    <td><span class="badge badge-in-progress">In Progress</span></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/common/detailsViewInclude.jsp"/>

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>

<script>
    initTableFeatures('assignedTable', 'assignedSearch');
    
    function showTaskDetail(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var content = 
            createDetailItem('Task Title', d.title) +
            createDetailItem('Status', 'In Progress') +
            createDetailItem('Claimed On', d.date) +
            '<div style="grid-column: 1/-1;">' + createDetailItem('Description', d.desc) + '</div>';
        
        var buttons = [
            {
                label: 'Mark as Complete',
                className: 'btn-primary',
                onclick: function() {
                    if(confirm('Are you sure you want to mark this task as completed?')) {
                        performAction('${pageContext.request.contextPath}/org/assigned', 'completeTask', d.id);
                    }
                }
            }
        ];
        
        showDetails('Task Details', content, row, buttons);
    }
</script>
</body>
</html>
