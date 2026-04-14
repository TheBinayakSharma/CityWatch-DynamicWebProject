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
                <a href="${pageContext.request.contextPath}/register" class="btn btn-success btn-sm">
                    + Add Organization
                </a>

                <form action="${pageContext.request.contextPath}/admin/orgs" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="removeLastOrg">
                    <button type="submit" class="btn btn-warning btn-sm"
                            onclick="return confirm('Remove last added organization?')">
                        Remove Last
                    </button>
                </form>
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
                        <th>Actions</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:choose>

                        <c:when test="${empty orgs}">
                            <tr>
                                <td colspan="9" style="text-align:center; color:#888;">
                                    No organizations found.
                                </td>
                            </tr>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="o" items="${orgs}" varStatus="st">
                                <tr>
                                    <td><c:out value="${st.count}"/></td>
                                    <td><c:out value="${o.orgName}"/></td>
                                    <td><c:out value="${o.orgType}"/></td>
                                    <td><c:out value="${o.fullName}"/></td>
                                    <td><c:out value="${o.username}"/></td>
                                    <td><c:out value="${o.email}"/></td>
                                    <td><c:out value="${o.phone}"/></td>
                                    <td><c:out value="${o.address}"/></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/orgs" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="deleteOrg">
                                            <input type="hidden" name="userId" value="${o.userId}">
                                            <button type="submit" class="btn btn-danger btn-sm"
                                                    onclick="return confirm('Delete this organization?')">
                                                Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>

                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    </div>
</div>
</body>
</html>