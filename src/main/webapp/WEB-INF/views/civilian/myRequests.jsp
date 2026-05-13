<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Requests &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.2">
    <script src="${pageContext.request.contextPath}/js/table-utils.js?v=1.2"></script>
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header">
            <div style="display:flex; justify-content:space-between; align-items:flex-end;">
                <div>
                    <h1>My Task Requests</h1>
                    <p>Tracking the status of tasks you've submitted to the city.</p>
                </div>
                <a href="${pageContext.request.contextPath}/civilian/requestTask" class="btn btn-primary btn-sm">+ Request New Task</a>
            </div>
        </div>

        <div class="card">
            <div class="search-bar">
                <div class="search-bar-inner">
                    <input type="text" id="myReqSearch" placeholder="Search my requests...">
                </div>
                <select class="sort-select" onchange="triggerSort('myReqTable', this.value)">
                    <option value="">Sort By...</option>
                    <option value="1">Title</option>
                    <option value="2">Status</option>
                    <option value="3">Date Requested</option>
                </select>
            </div>
            <div class="table-wrap">
                <table id="myReqTable">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Status</th>
                        <th>Requested On</th>
                        <th>Handling Org</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty tasks}">
                            <tr><td colspan="5" style="text-align:center;color:#888;">You haven't requested any tasks yet.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="t" items="${tasks}" varStatus="st">
                                <tr onclick="showRequestDetail(this)"
                                    data-title="<c:out value='${t.title}'/>"
                                    data-desc="<c:out value='${t.description}'/>"
                                    data-status="<c:out value='${t.status}'/>"
                                    data-org="<c:out value='${t.assignedOrgName != null ? t.assignedOrgName : \"Not Assigned Yet\"}'/>"
                                    data-date="<fmt:formatDate value='${t.createdAt}' pattern='dd MMM yyyy, HH:mm'/>">
                                    <td><c:out value="${st.count}"/></td>
                                    <td><strong><c:out value="${t.title}"/></strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${t.status == 'PENDING'}"><span class="badge badge-pending">Approval Pending</span></c:when>
                                            <c:when test="${t.status == 'AVAILABLE'}"><span class="badge badge-available">Open for Claim</span></c:when>
                                            <c:when test="${t.status == 'IN_PROGRESS'}"><span class="badge badge-in-progress">In Progress</span></c:when>
                                            <c:when test="${t.status == 'COMPLETED'}"><span class="badge badge-completed">Completed</span></c:when>
                                            <c:otherwise><span class="badge"><c:out value="${t.status}"/></span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${t.createdAt}" pattern="dd MMM yyyy"/></td>
                                    <td><c:out value="${t.assignedOrgName != null ? t.assignedOrgName : '—'}"/></td>
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
    initTableFeatures('myReqTable', 'myReqSearch');
    
    function showRequestDetail(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var statusHtml = row.cells[2].innerHTML;
        
        var content = 
            createDetailItem('Task Title', d.title) +
            createDetailItem('Current Status', statusHtml) +
            createDetailItem('Requested On', d.date) +
            createDetailItem('Handling Organization', d.org) +
            '<div style="grid-column: 1/-1;">' + createDetailItem('Full Description', d.desc) + '</div>';
        
        showDetails('Request Details', content, row);
    }
</script>
</body>
</html>
