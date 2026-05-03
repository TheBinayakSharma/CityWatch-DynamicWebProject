<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Completed Tasks &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.2">
    <script src="${pageContext.request.contextPath}/js/table-utils.js?v=1.2"></script>
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header">
            <h1>Completed Tasks</h1>
            <p>Transparency view &mdash; all tasks completed across the city.</p>
        </div>
        <div class="card">
            <div class="search-bar">
                <div class="search-bar-inner">
                    <input type="text" id="completedSearch" placeholder="Search completed tasks...">
                </div>
                <select class="sort-select" onchange="triggerSort('completedTable', this.value)">
                    <option value="">Sort By...</option>
                    <option value="1">Title</option>
                    <option value="2">Completed By</option>
                    <option value="3">Completion Date</option>
                </select>
                <button class="search-btn" onclick="triggerSearch('completedSearch')">Search</button>
            </div>
            <div class="table-wrap">
                <table id="completedTable">
                    <thead>
                    <tr><th>#</th><th>Title</th><th>Completed By</th><th>Completed On</th></tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty tasks}">
                            <tr><td colspan="4" style="text-align:center;color:#888;">No completed tasks yet.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="t" items="${tasks}" varStatus="st">
                                <tr onclick="showTaskDetail(this)"
                                    data-title="<c:out value='${t.title}'/>"
                                    data-desc="<c:out value='${t.description}'/>"
                                    data-org="<c:out value='${t.assignedOrgName}'/>"
                                    data-date="<fmt:formatDate value='${t.completedAt}' pattern='dd MMM yyyy, HH:mm'/>">
                                    <td><c:out value="${st.count}"/></td>
                                    <td><c:out value="${t.title}"/></td>
                                    <td><c:out value="${not empty t.assignedOrgName ? t.assignedOrgName : '—'}"/></td>
                                    <td><fmt:formatDate value="${t.completedAt}" pattern="dd MMM yyyy"/></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/common/detailsViewInclude.jsp"/>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>

<script>
    initTableFeatures('completedTable', 'completedSearch');
    
    function showTaskDetail(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var content = 
            createDetailItem('Task Title', d.title) +
            createDetailItem('Status', 'Completed') +
            createDetailItem('Completed By', d.org || 'Not Assigned') +
            createDetailItem('Completed On', d.date) +
            '<div style="grid-column: 1/-1;">' + createDetailItem('Description', d.desc) + '</div>';
        
        showDetails('Task Details', content, row);
    }
</script>
</body>
</html>