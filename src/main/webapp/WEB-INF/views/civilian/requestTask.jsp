<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>New Request &ndash; CityWatch</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.2">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">
        </head>

        <body>
            <div class="layout">
                <jsp:include page="/WEB-INF/views/common/nav.jsp" />
                <div class="main">
                    <div class="page-header">
                        <h1>Submit Community Request</h1>
                        <p>Your eyes on the ground help build a better city. Report an issue or suggest an improvement.
                        </p>
                    </div>

                    <div class="dashboard-grid" style="grid-template-columns: 1.5fr 1fr; align-items: start;">
                        <%-- Form Section --%>
                            <div class="card">
                                <div class="card-title">📝 Request Details</div>
                                <span class="card-subtitle">Please provide clear and concise information</span>

                                <form action="${pageContext.request.contextPath}/civilian/requestTask" method="post"
                                    style="margin-top:20px;">
                                    <div class="form-group">
                                        <label for="title" style="font-weight:600; color:var(--text-main);">Task Title /
                                            Brief Subject</label>
                                        <input type="text" id="title" name="title" class="form-control" required
                                            placeholder="e.g., Street Light Repair at Ward 10"
                                            style="padding:12px; font-size:1rem; border-radius:8px;">
                                        <small style="color:#666; margin-top:4px; display:block;">Use a clear,
                                            descriptive name for the issue.</small>
                                    </div>

                                    <div class="form-group" style="margin-top:24px;">
                                        <label for="description"
                                            style="font-weight:600; color:var(--text-main);">Detailed Description &
                                            Location</label>
                                        <textarea id="description" name="description" class="form-control" rows="6"
                                            required
                                            placeholder="Describe the issue in detail. Include landmarks, exact location, and why it needs urgent attention..."
                                            style="padding:12px; font-size:1rem; border-radius:8px; resize:vertical;"></textarea>
                                    </div>

                                    <div
                                        style="margin-top:32px; padding-top:20px; border-top:1px solid #eee; display:flex; gap:12px; align-items:center;">
                                        <button type="submit" class="btn btn-primary"
                                            style="padding:12px 24px; font-weight:600;">🚀 Submit Request</button>
                                        <a href="${pageContext.request.contextPath}/civilian/myRequests" class="btn"
                                            style="background:#f1f1f1; color:#444; padding:12px 20px;">Cancel</a>
                                    </div>
                                </form>
                            </div>

                            <%-- Info Section --%>
                                <div style="display:flex; flex-direction:column; gap:20px;">
                                    <div class="card"
                                        style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border:none;">
                                        <div class="card-title" style="font-size:1.1rem;">💡 Submission Guidelines</div>
                                        <ul style="margin:12px 0 0 18px; padding:0; color:#555; line-height:1.6;">
                                            <li>Be specific about the **location**.</li>
                                            <li>Explain the **urgency** or safety impact.</li>
                                            <li>Avoid duplicate requests for the same issue.</li>
                                            <li>Check **Public Tasks** first to see if it's already reported.</li>
                                        </ul>
                                    </div>

                                    <div class="card">
                                        <div class="card-title" style="font-size:1.1rem;">🔍 What happens next?</div>
                                        <div class="leaderboard"
                                            style="margin-top:15px; border:none; box-shadow:none; background:transparent;">
                                            <div class="leaderboard-item" style="padding:10px 0;">
                                                <div class="leaderboard-name"><span class="leaderboard-rank">1</span>
                                                    <strong>Admin Review</strong></div>
                                                <span class="leaderboard-count" style="font-size:0.8rem;">Approval &
                                                    Validation</span>
                                            </div>
                                            <div class="leaderboard-item" style="padding:10px 0;">
                                                <div class="leaderboard-name"><span class="leaderboard-rank">2</span>
                                                    <strong>Public Listing</strong></div>
                                                <span class="leaderboard-count" style="font-size:0.8rem;">Available for
                                                    Orgs</span>
                                            </div>
                                            <div class="leaderboard-item" style="padding:10px 0;">
                                                <div class="leaderboard-name"><span class="leaderboard-rank">3</span>
                                                    <strong>Task Claimed</strong></div>
                                                <span class="leaderboard-count" style="font-size:0.8rem;">Org starts
                                                    working</span>
                                            </div>
                                            <div class="leaderboard-item" style="padding:10px 0; border:none;">
                                                <div class="leaderboard-name"><span class="leaderboard-rank"
                                                        style="background:var(--success);">4</span>
                                                    <strong>Resolved</strong></div>
                                                <span class="leaderboard-count" style="font-size:0.8rem;">Task verified
                                                    & closed</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            </div>
        </body>

        </html>