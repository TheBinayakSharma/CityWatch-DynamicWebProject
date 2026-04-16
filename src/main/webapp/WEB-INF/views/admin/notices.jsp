<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notices &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header">
            <h1>Notices</h1>
            <p>Recent public announcements and updates.</p>
        </div>

        <div class="card">
            <div style="margin-bottom:16px;">
                <a href="${pageContext.request.contextPath}/admin/addNotice" class="btn btn-success btn-sm">+ New Notice</a>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Posted</th>
                        <th>Updated</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty notices}">
                            <tr><td colspan="5" style="text-align:center;color:#888;">No notices yet.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="n" items="${notices}" varStatus="st">
                                <tr onclick="showNoticeDetails(this)" 
                                    data-id="${n.id}"
                                    data-title="<c:out value='${n.title}'/>"
                                    data-description="<c:out value='${n.description}'/>"
                                    data-created="<fmt:formatDate value='${n.createdAt}' pattern='dd MMM yyyy, HH:mm'/>"
                                    data-updated="<fmt:formatDate value='${n.updatedAt}' pattern='dd MMM yyyy, HH:mm'/>">
                                    <td><c:out value="${st.count}"/></td>
                                    <td><c:out value="${n.title}"/></td>
                                    <td><c:out value="${n.description}"/></td>
                                    <td><fmt:formatDate value="${n.createdAt}" pattern="dd MMM yyyy"/></td>
                                    <td><fmt:formatDate value="${n.updatedAt}" pattern="dd MMM yyyy"/></td>
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
    initializeDetailsForm('${pageContext.request.contextPath}/admin/notices', 'updateNotice', 'deleteNotice', 'Edit Notice');

    function showNoticeDetails(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var content = 
            createFormField('Notice Title', 'title', d.title) +
            createFormField('Description', 'description', d.description, 'textarea') +
            createFormField('Posted On', '', d.created, 'text', true) +
            createFormField('Last Updated', '', d.updated, 'text', true);
        
        showDetailsForm(content, d.id, false, row);
    }
</script>
</body>
</html>