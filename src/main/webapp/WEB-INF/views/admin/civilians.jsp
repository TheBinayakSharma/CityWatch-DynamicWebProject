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
                <a href="${pageContext.request.contextPath}/register" class="btn btn-success btn-sm">
                    + Add Civilian
                </a>

                <form action="${pageContext.request.contextPath}/admin/civilians" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="removeLastCivilian">
                    <button type="submit" class="btn btn-warning btn-sm"
                            onclick="return confirm('Remove last added civilian?')">
                        Remove Last
                    </button>
                </form>
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
                        <th>Actions</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:choose>

                        <c:when test="${empty civilians}">
                            <tr>
                                <td colspan="8" style="text-align:center;color:#888;">
                                    No civilians found.
                                </td>
                            </tr>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="c" items="${civilians}" varStatus="st">
                                <tr>
                                    <td><c:out value="${st.count}"/></td>
                                    <td><c:out value="${c.fullName}"/></td>
                                    <td><c:out value="${c.username}"/></td>
                                    <td><c:out value="${c.email}"/></td>
                                    <td><c:out value="${c.phone}"/></td>
                                    <td><c:out value="${c.wardNo}"/></td>
                                    <td><c:out value="${c.address}"/></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/civilians" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="deleteCivilian">
                                            <input type="hidden" name="userId" value="${c.userId}">
                                            <button type="submit" class="btn btn-danger btn-sm"
                                                    onclick="return confirm('Delete this civilian?')">
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