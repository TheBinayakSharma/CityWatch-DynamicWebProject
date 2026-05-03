<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Tasks In Progress &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
            <div class="table-wrap">
                <table>
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
