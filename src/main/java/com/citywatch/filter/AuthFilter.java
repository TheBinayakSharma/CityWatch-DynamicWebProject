// com/citywatch/filter/AuthFilter.java
package com.citywatch.filter;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
@WebFilter(urlPatterns = {"/admin/*", "/org/*", "/civilian/*"})
public class AuthFilter implements Filter {
 @Override
 public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
 throws IOException, ServletException {
 HttpServletRequest req = (HttpServletRequest) request;
 HttpServletResponse resp = (HttpServletResponse) response;
 HttpSession session = req.getSession(false);
 String role = (session != null) ? (String) session.getAttribute("role") : null;
 String path = req.getRequestURI();
 String ctx = req.getContextPath();
 // Not logged in — redirect to login
 if (role == null) {
 resp.sendRedirect(ctx + "/login");
 return;
 }
 // Role mismatch — redirect to error
 if (path.startsWith(ctx + "/admin/") && !"ADMIN".equals(role)) {
 resp.sendRedirect(ctx + "/error");
 return;
 }
 if (path.startsWith(ctx + "/org/") && !"ORGANIZATION".equals(role)) {
 resp.sendRedirect(ctx + "/error");
 return;
 }
 if (path.startsWith(ctx + "/civilian/") && !"CIVILIAN".equals(role)) {
 resp.sendRedirect(ctx + "/error");
 return;
 }
 chain.doFilter(request, response);
 }
 @Override public void init(FilterConfig fc) {}
 @Override public void destroy() {}
}