package com.app;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * ResultServlet — reads student data from student_performance.csv and
 * forwards to showResult.jsp for rendering.
 *
 * GET /ResultServlet
 *   Requires session attribute "ir-user" (set by LoginServlet).
 *
 * Place student_performance.csv at:
 *   WebContent/WEB-INF/data/student_performance.csv
 * (or update CSV_PATH below)
 */
public class ResultServlet extends HttpServlet {

    // Adjust path if needed — relative to server working dir or use getRealPath
    private static String getCsvPath(HttpServletRequest request) {
        String realPath = request.getServletContext()
                                 .getRealPath("/WEB-INF/data/student_performance.csv");
        return realPath != null ? realPath : "student_performance.csv";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Session guard ─────────────────────────────────────────────────────
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("ir-user") == null) {
            response.sendRedirect("login.html");
            return;
        }

        String username  = (String)  session.getAttribute("ir-user");
        int    studentId = (int)     session.getAttribute("ir-studentId");
        String csvPath   = getCsvPath(request);

        // ── Fetch this student's record ───────────────────────────────────────
        Map<String, String> record = DBConnection.getStudentRecord(studentId, csvPath);

        if (record == null) {
            // Fallback: build a demo record so the page still renders
            record = new LinkedHashMap<>();
            record.put("student_id",               String.valueOf(studentId));
            record.put("weekly_self_study_hours",   "15.0");
            record.put("attendance_percentage",     "85.0");
            record.put("class_participation",       "5.0");
            record.put("total_score",               "75.0");
            record.put("grade",                     "B");
        }

        // ── Compute derived metrics ───────────────────────────────────────────
        double score  = Double.parseDouble(record.get("total_score"));
        double attend = Double.parseDouble(record.get("attendance_percentage"));
        double study  = Double.parseDouble(record.get("weekly_self_study_hours"));
        double partic = Double.parseDouble(record.get("class_participation"));
        String grade  = record.get("grade");

        // Class stats (first 50 rows — change limit as needed)
        List<Map<String, String>> allRecords = DBConnection.getAllRecords(csvPath, 50);

        double classAvgScore = allRecords.stream()
            .mapToDouble(r -> Double.parseDouble(r.get("total_score"))).average().orElse(0);
        double classAvgStudy = allRecords.stream()
            .mapToDouble(r -> Double.parseDouble(r.get("weekly_self_study_hours"))).average().orElse(0);
        double classAvgAtt   = allRecords.stream()
            .mapToDouble(r -> Double.parseDouble(r.get("attendance_percentage"))).average().orElse(0);

        long betterThan = allRecords.stream()
            .filter(r -> Double.parseDouble(r.get("total_score")) < score).count();
        int rank = (int)(allRecords.size() - betterThan);

        // ── Pass to JSP ───────────────────────────────────────────────────────
        request.setAttribute("username",      username);
        request.setAttribute("record",        record);
        request.setAttribute("allRecords",    allRecords);
        request.setAttribute("classAvgScore", String.format("%.1f", classAvgScore));
        request.setAttribute("classAvgStudy", String.format("%.1f", classAvgStudy));
        request.setAttribute("classAvgAtt",   String.format("%.1f", classAvgAtt));
        request.setAttribute("rank",          rank);
        request.setAttribute("totalStudents", allRecords.size());
        request.setAttribute("grade",         grade);

        RequestDispatcher rd = request.getRequestDispatcher("showResult.jsp");
        rd.forward(request, response);
    }
}