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
        <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
            <div>
                <h1 class="page-title" style="margin: 0;">Civilian Management</h1>
                <p style="margin: 5px 0 0 0; color: var(--muted);">Manage all citizen accounts.</p>
            </div>
            <button class="btn btn-primary" onclick="prepareAddCivilian()">+ Add Civilian</button>
        </div>

        <div class="card">
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
                                    data-address="<c:out value='${c.address}'/>"
                                    data-locked="${c.locked}">
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

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>

<script>
    initializeDetailsForm('${pageContext.request.contextPath}/admin/civilians', 'updateCivilian', 'deleteCivilian', 'Civilian Details');

    function showCivilianDetails(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var content = 
            createFormField('Full Name', 'fullName', d.name) +
            createFormField('Username', 'username', d.username, 'text', '', true) +
            createFormField('Email', 'email', d.email) +
            createFormField('Phone', 'phone', d.phone) +
            createFormField('Ward Number', 'wardNo', d.ward) +
            createFormField('Address', 'address', d.address);
        
        showDetailsForm(content, d.userid, true, row, d.locked);
    }
    function prepareAddCivilian() {
        var content = 
            createFormField('Full Name', 'fullName', '', 'text', 'Citizen Name') +
            createFormField('Username', 'username', '', 'text', 'Unique ID') +
            createFormField('Password', 'password', '', 'password', 'Min 6 chars') +
            createFormField('Email', 'email', '', 'email', 'name@example.com') +
            createFormField('Phone', 'phone', '', 'text', '10 digits') +
            createFormField('Ward Number', 'wardNo', '', 'number', '1-32') +
            createFormField('Address', 'address', '', 'text', 'Street/Locality');
        
        showDetailsForm(content, '', true, null, false, true, 'addCivilian');
    }
</script>
</body>
</html>