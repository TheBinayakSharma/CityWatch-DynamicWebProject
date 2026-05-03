<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Tasks In Progress &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.2">
    <script src="${pageContext.request.contextPath}/js/table-utils.js?v=1.2"></script>
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header">
            <h1>Active City Tasks</h1>
            <p>A transparent view of all tasks currently being handled by various organizations across the city.</p>
        </div>

        <div class="card">
            <div class="search-bar">
                <div class="search-bar-inner">
                    <input type="text" id="progressSearch" placeholder="Search city tasks by title or organization...">
                </div>
                <select class="sort-select" onchange="triggerSort('progressTable', this.value)">
                    <option value="">Sort By...</option>
                    <option value="1">Title</option>
                    <option value="2">Handled By</option>
                    <option value="3">Started Date</option>
                </select>
                <button class="search-btn" onclick="triggerSearch('progressSearch')">Search</button>
            </div>
            <div class="table-wrap">
                <table id="progressTable">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Assigned To</th>
                        <th>Started</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty tasks}">
                            <tr><td colspan="4" style="text-align:center;padding:40px;color:#888;">No tasks are currently in progress.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="t" items="${tasks}" varStatus="st">
                                <tr onclick="showTaskDetails(this)"
                                    data-title="<c:out value='${t.title}'/>"
                                    data-desc="<c:out value='${t.description}'/>"
                                    data-org="<c:out value='${t.assignedOrgName}'/>"
                                    data-date="<fmt:formatDate value='${t.createdAt}' pattern='dd MMM yyyy, HH:mm'/>">
                                    <td><c:out value="${st.count}"/></td>
                                    <td><c:out value="${t.title}"/></td>
                                    <td><c:out value="${not empty t.assignedOrgName ? t.assignedOrgName : 'Not Assigned'}"/></td>
                                    <td><fmt:formatDate value="${t.createdAt}" pattern="dd MMM yyyy"/></td>
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
    initTableFeatures('progressTable', 'progressSearch');
    
    function showTaskDetails(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var content = 
            createDetailItem('Task Title', d.title) +
            createDetailItem('Status', 'In Progress') +
            createDetailItem('Assigned To', d.org || 'Not Assigned') +
            createDetailItem('Started At', d.date) +
            '<div style="grid-column: 1/-1;">' + createDetailItem('Description', d.desc) + '</div>';
        
        showDetails('Task Details', content, row);
    }
</script>
</body>
</html>
