<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Organizations &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header">
            <h1>Organizations</h1>
            <p>All registered NGOs and agencies.</p>
        </div>

        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger">
                <c:out value="${errorMsg}"/>
            </div>
        </c:if>

        <div class="card">
            <div class="btn-group" style="margin-bottom:16px;">
                <a href="${pageContext.request.contextPath}/register" class="btn btn-success btn-sm">+ Add Organization</a>
            </div>

            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Org Name</th>
                        <th>Type</th>
                        <th>Full Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty orgs}">
                            <tr><td colspan="8" style="text-align:center; color:#888;">No organizations found.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="o" items="${orgs}" varStatus="st">
                                <tr onclick="showOrgDetails(this)"
                                    data-userid="${o.userId}"
                                    data-name="<c:out value='${o.orgName}'/>"
                                    data-type="${o.orgType}"
                                    data-fullname="<c:out value='${o.fullName}'/>"
                                    data-username="<c:out value='${o.username}'/>"
                                    data-email="<c:out value='${o.email}'/>"
                                    data-phone="<c:out value='${o.phone}'/>"
                                    data-address="<c:out value='${o.address}'/>"
                                    data-locked="${o.locked}">
                                    <td><c:out value="${st.count}"/></td>
                                    <td><c:out value="${o.orgName}"/></td>
                                    <td><c:out value="${o.orgType}"/></td>
                                    <td><c:out value="${o.fullName}"/></td>
                                    <td><c:out value="${o.username}"/></td>
                                    <td><c:out value="${o.email}"/></td>
                                    <td><c:out value="${o.phone}"/></td>
                                    <td><c:out value="${o.address}"/></td>
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
    initializeDetailsForm('${pageContext.request.contextPath}/admin/orgs', 'updateOrg', 'deleteOrg', 'Organization Details');

    function showOrgDetails(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var content = 
            createFormField('Org Name', 'orgName', d.name) +
            createFormField('Org Type', 'orgType', d.type) +
            createFormField('Contact Person', 'fullName', d.fullname) +
            createFormField('Username', 'username', d.username, 'text', true) +
            createFormField('Email', 'email', d.email) +
            createFormField('Phone', 'phone', d.phone) +
            createFormField('Address', 'address', d.address, 'textarea');
        
        showDetailsForm(content, d.userid, true, row, d.locked);
    }
</script>
</body>
</html>