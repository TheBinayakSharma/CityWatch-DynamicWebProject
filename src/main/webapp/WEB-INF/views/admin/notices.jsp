<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notices &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.2">
    <script src="${pageContext.request.contextPath}/js/table-utils.js?v=1.2"></script>
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
            <div>
                <h1 class="page-title" style="margin: 0;">Notice Board</h1>
                <p style="margin: 5px 0 0 0; color: var(--muted);">Publish and manage city-wide announcements.</p>
            </div>
            <button class="btn btn-primary" onclick="prepareAddNotice()">+ Post New Notice</button>
        </div>

        <div class="card">
            <div class="search-bar">
                <div class="search-bar-inner">
                    <input type="text" id="noticeSearch" placeholder="Search notices by title or content...">
                </div>
                <select class="sort-select" onchange="triggerSort('noticeTable', this.value)">
                    <option value="">Sort By...</option>
                    <option value="1">Title</option>
                    <option value="2">Posted Date</option>
                </select>
                <button class="search-btn" onclick="triggerSearch('noticeSearch')">Search</button>
            </div>
            <div class="table-wrap">
                <table id="noticeTable">
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

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>

<script>
    initializeDetailsForm('${pageContext.request.contextPath}/admin/notices', 'updateNotice', 'deleteNotice', 'Edit Notice');
    initTableFeatures('noticeTable', 'noticeSearch');

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

    function prepareAddNotice() {
        var content = 
            createFormField('Notice Title', 'title', '', 'text', 'Subject of the notice') +
            createFormField('Description', 'description', '', 'textarea', 'Main announcement content...');
        
        showDetailsForm(content, '', false, null, false, true, 'addNotice');
    }
</script>
</body>
</html>