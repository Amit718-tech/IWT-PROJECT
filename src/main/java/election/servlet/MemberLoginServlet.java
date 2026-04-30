package com.election.servlet;

import com.election.dao.MemberDAO;
import com.election.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/member-login")
public class MemberLoginServlet extends HttpServlet {
    private MemberDAO memberDAO = new MemberDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sic = request.getParameter("sic");
        String password = request.getParameter("password");
        
        if (sic == null || password == null) {
            response.sendRedirect("memberacc.jsp?error=missing");
            return;
        }
        
        Member member = memberDAO.validateLogin(sic, password);
        
        if (member != null) {
            HttpSession session = request.getSession();
            session.setAttribute("member", member);
            session.setAttribute("userType", "member");
            response.sendRedirect("member-dashboard.jsp");
        } else {
            response.sendRedirect("memberacc.jsp?error=invalid");
        }
    }
}