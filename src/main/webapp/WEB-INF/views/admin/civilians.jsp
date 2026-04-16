<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Civilians &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header">
            <h1>Civilians</h1>
            <p>All registered civilian accounts.</p>
        </div>

        <div class="card">
            <div class="btn-group" style="margin-bottom:16px;">
                <a href="${pageContext.request.contextPath}/register" class="btn btn-success btn-sm">+ Add Civilian</a>
            </div>

            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Full Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Ward No.</th>
                        <th>Address</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty civilians}">
                            <tr><td colspan="7" style="text-align:center;color:#888;">No civilians found.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="c" items="${civilians}" varStatus="st">
                                <tr onclick="showCivilianDetails(this)"
                                    data-userid="${c.userId}"
                                    data-name="<c:out value='${c.fullName}'/>"
                                    data-username="<c:out value='${c.username}'/>"
                                    data-email="<c:out value='${c.email}'/>"
                                    data-phone="<c:out value='${c.phone}'/>"
                                    data-ward="${c.wardNo}"
                                    data-address="<c:out value='${c.address}'/>">
                                    <td><c:out value="${st.count}"/></td>
                                    <td><c:out value="${c.fullName}"/></td>
                                    <td><c:out value="${c.username}"/></td>
                                    <td><c:out value="${c.email}"/></td>
                                    <td><c:out value="${c.phone}"/></td>
                                    <td><c:out value="${c.wardNo}"/></td>
                                    <td><c:out value="${c.address}"/></td>
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
    initializeDetailsForm('${pageContext.request.contextPath}/admin/civilians', 'updateCivilian', 'deleteCivilian', 'Civilian Details');

    function showCivilianDetails(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var content = 
            createFormField('Full Name', 'fullName', d.name) +
            createFormField('Username', 'username', d.username, 'text', true) +
            createFormField('Email', 'email', d.email) +
            createFormField('Phone', 'phone', d.phone) +
            createFormField('Ward Number', 'wardNo', d.ward) +
            createFormField('Address', 'address', d.address);
        
        showDetailsForm(content, d.userid, true, row);
    }
</script>
</body>
</html>