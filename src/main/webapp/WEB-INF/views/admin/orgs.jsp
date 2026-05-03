<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Organizations &ndash; CityWatch</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.2">
    <script src="${pageContext.request.contextPath}/js/table-utils.js?v=1.2"></script>
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
            <div>
                <h1 class="page-title" style="margin: 0;">Organization Management</h1>
                <p style="margin: 5px 0 0 0; color: var(--muted);">Review and manage registered organizations.</p>
            </div>
            <button class="btn btn-primary" onclick="prepareAddOrg()">+ Add Organization</button>
        </div>

        <div class="card">
            <div class="search-bar">
                <div class="search-bar-inner">
                    <input type="text" id="orgSearch" placeholder="Search by name, type, email or phone...">
                </div>
                <select class="sort-select" onchange="triggerSort('orgTable', this.value)">
                    <option value="">Sort By...</option>
                    <option value="1">Name</option>
                    <option value="2">Type</option>
                    <option value="0">ID</option>
                </select>
                <button class="search-btn" onclick="triggerSearch('orgSearch')">Search</button>
            </div>
            <div class="table-wrap">
                <table id="orgTable">
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

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>

<script>
    initializeDetailsForm('${pageContext.request.contextPath}/admin/orgs', 'updateOrg', 'deleteOrg', 'Organization Details');
    initTableFeatures('orgTable', 'orgSearch');

    function showOrgDetails(row) {
        if (!row || !row.dataset) return;
        var d = row.dataset;
        var content = 
            createFormField('Org Name', 'orgName', d.name) +
            createFormField('Org Type', 'orgType', d.type) +
            createFormField('Contact Person', 'fullName', d.fullname) +
            createFormField('Username', 'username', d.username, 'text', '', true) +
            createFormField('Email', 'email', d.email) +
            createFormField('Phone', 'phone', d.phone) +
            createFormField('Address', 'address', d.address, 'textarea');
        
        showDetailsForm(content, d.userid, true, row, d.locked);
    }
    function prepareAddOrg() {
        var content = 
            createFormField('Full Name', 'fullName', '', 'text', 'Organization Admin Name') +
            createFormField('Username', 'username', '', 'text', 'Unique ID') +
            createFormField('Password', 'password', '', 'password', 'Min 6 chars') +
            createFormField('Email', 'email', '', 'email', 'name@example.com') +
            createFormField('Phone', 'phone', '', 'text', '10 digits') +
            createFormField('Organization Name', 'orgName', '', 'text', 'NGO/Agency Name') +
            createFormField('Org Type', 'orgType', '', 'text', 'e.g., Environment') +
            createFormField('Address', 'address', '', 'textarea', 'Main Headquarters');
        
        showDetailsForm(content, '', true, null, false, true, 'addOrg');
    }
</script>
</body>
</html>