<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Queries &ndash; CityWatch Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .query-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            border-left: 4px solid var(--primary);
        }
        .query-card.resolved {
            border-left-color: var(--accent);
            opacity: 0.8;
        }
        .query-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            border-bottom: 1px solid var(--border);
            padding-bottom: 10px;
        }
        .query-name {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--primary);
        }
        .query-meta {
            font-size: 0.85rem;
            color: var(--muted);
        }
        .query-text {
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 15px;
            color: #444;
        }
    </style>
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
    <div class="main">
        <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
            <div>
                <h1 class="page-title" style="margin: 0;">Contact Queries</h1>
                <p style="margin: 5px 0 0 0; color: var(--muted);">View and resolve messages from the public.</p>
            </div>
        </div>

        <div class="queries-container">
            <c:choose>
                <c:when test="${empty queries}">
                    <div class="card" style="text-align:center; padding: 40px; color: #888;">
                        <i class="fa-solid fa-inbox" style="font-size: 3rem; margin-bottom: 15px; opacity: 0.5;"></i>
                        <p>No contact queries found.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="q" items="${queries}">
                        <div class="query-card ${q.status == 'RESOLVED' ? 'resolved' : ''}">
                            <div class="query-header">
                                <div>
                                    <div class="query-name"><c:out value="${q.name}"/></div>
                                    <div class="query-meta">
                                        <i class="fa-solid fa-phone" style="margin-right:5px;"></i> <c:out value="${q.phoneNumber}"/>
                                        &nbsp;&bull;&nbsp;
                                        <i class="fa-solid fa-clock" style="margin-right:5px;"></i> <fmt:formatDate value="${q.createdAt}" pattern="dd MMM yyyy, HH:mm"/>
                                    </div>
                                </div>
                                <div>
                                    <span class="badge ${q.status == 'RESOLVED' ? 'badge-completed' : 'badge-in-progress'}">
                                        <c:out value="${q.status}"/>
                                    </span>
                                </div>
                            </div>
                            <div class="query-text">
                                <c:out value="${q.queryText}"/>
                            </div>
                            <c:if test="${q.status == 'PENDING'}">
                                <form action="${pageContext.request.contextPath}/admin/queries" method="POST" style="margin:0; text-align: right;">
                                    <input type="hidden" name="action" value="resolveQuery">
                                    <input type="hidden" name="id" value="${q.id}">
                                    <button type="submit" class="btn btn-success btn-sm"><i class="fa-solid fa-check"></i> Mark as Resolved</button>
                                </form>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>
