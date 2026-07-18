<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // ── Pull attributes from ResultServlet ──────────────────────────────────
    String username     = (String) request.getAttribute("username");
    Map<String,String> record = (Map<String,String>) request.getAttribute("record");
    List<Map<String,String>> allRecords = (List<Map<String,String>>) request.getAttribute("allRecords");

    String classAvgScore = (String) request.getAttribute("classAvgScore");
    String classAvgStudy = (String) request.getAttribute("classAvgStudy");
    String classAvgAtt   = (String) request.getAttribute("classAvgAtt");
    int    rank          = (Integer) request.getAttribute("rank");
    int    totalStudents = (Integer) request.getAttribute("totalStudents");
    String grade         = (String) request.getAttribute("grade");

    double score  = Double.parseDouble(record.get("total_score"));
    double attend = Double.parseDouble(record.get("attendance_percentage"));
    double study  = Double.parseDouble(record.get("weekly_self_study_hours"));
    double partic = Double.parseDouble(record.get("class_participation"));
    int    sid    = Integer.parseInt(record.get("student_id"));

    // Grade colours
    Map<String,String> gradeColor = new LinkedHashMap<>();
    gradeColor.put("A","#10b981"); gradeColor.put("B","#3b82f6");
    gradeColor.put("C","#f59e0b"); gradeColor.put("D","#f97316"); gradeColor.put("F","#ef4444");
    String gc = gradeColor.getOrDefault(grade, "#94a3b8");

    String statusLabel = grade.equals("F") ? "FAIL" : "PASS";
    String statusColor = grade.equals("F") ? "#ef4444" : "#10b981";
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>IntelliResult — Results · <%= username %></title>
<style>
:root[data-theme="dark"]{--bg:#020818;--card:rgba(10,20,45,0.9);--border:rgba(99,102,241,0.2);--border2:rgba(99,102,241,0.48);--text:#f1f5f9;--text2:#94a3b8;--text3:#475569;--glow1:rgba(99,102,241,0.3);--glow2:rgba(139,92,246,0.2);--acc:#6366f1;--acc2:#8b5cf6;--acc3:#38bdf8;--nav:rgba(5,12,30,0.96);--tag-text:#a78bfa;--tr-hover:rgba(99,102,241,0.07);--thead:rgba(99,102,241,0.1)}
:root[data-theme="light"]{--bg:#eef2ff;--card:rgba(255,255,255,0.93);--border:rgba(99,102,241,0.18);--border2:rgba(99,102,241,0.5);--text:#1e1b4b;--text2:#4338ca;--text3:#6b7280;--glow1:rgba(99,102,241,0.18);--glow2:rgba(139,92,246,0.12);--acc:#4f46e5;--acc2:#7c3aed;--acc3:#0284c7;--nav:rgba(238,242,255,0.97);--tag-text:#4338ca;--tr-hover:rgba(99,102,241,0.04);--thead:rgba(99,102,241,0.08)}
*{box-sizing:border-box;margin:0;padding:0}
html,body{min-height:100vh;font-family:'Segoe UI',system-ui,sans-serif;background:var(--bg);color:var(--text);transition:background 0.4s,color 0.4s}
.orb{position:fixed;border-radius:50%;pointer-events:none;z-index:0;animation:pulse 5s ease-in-out infinite alternate}
.orb1{width:500px;height:500px;top:-150px;left:-150px;background:radial-gradient(circle,var(--glow1),transparent 70%)}
.orb2{width:400px;height:400px;bottom:-100px;right:-100px;background:radial-gradient(circle,var(--glow2),transparent 70%);animation-delay:2.5s}
@keyframes pulse{0%{opacity:0.4;transform:scale(1)}100%{opacity:0.9;transform:scale(1.12)}}
nav{position:sticky;top:0;z-index:50;background:var(--nav);border-bottom:1px solid var(--border);backdrop-filter:blur(22px);padding:13px 24px;display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap}
.logo-row{display:flex;align-items:center;gap:10px}
.logo-icon{width:34px;height:34px;border-radius:9px;background:linear-gradient(135deg,var(--acc),var(--acc2));display:flex;align-items:center;justify-content:center;box-shadow:0 0 20px var(--glow1)}
.logo-icon svg{width:17px;height:17px}
.logo-name{font-size:18px;font-weight:800;letter-spacing:-0.03em;background:linear-gradient(135deg,var(--acc),var(--acc3));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.nav-right{display:flex;align-items:center;gap:8px;flex-wrap:wrap}
.btn-sm{padding:7px 14px;border-radius:8px;border:1px solid var(--border);background:var(--card);color:var(--text2);font-size:12px;font-weight:700;cursor:pointer;font-family:inherit;transition:all 0.2s}
.btn-sm:hover{border-color:var(--border2);color:var(--acc);box-shadow:0 0 15px var(--glow1)}
.btn-danger{border-color:rgba(239,68,68,0.3);background:rgba(239,68,68,0.07);color:#fca5a5}
[data-theme="light"] .btn-danger{color:#b91c1c}
.btn-danger:hover{border-color:rgba(239,68,68,0.5)!important;color:#ef4444!important}
.main{position:relative;z-index:1;max-width:960px;margin:0 auto;padding:28px 20px}
.profile-card{background:var(--card);border:1px solid var(--border);border-radius:22px;padding:26px;backdrop-filter:blur(14px);margin-bottom:22px;box-shadow:0 0 55px var(--glow1)}
.profile-inner{display:flex;align-items:center;gap:20px;flex-wrap:wrap}
.big-avatar{width:66px;height:66px;border-radius:18px;background:linear-gradient(135deg,var(--acc),var(--acc2));display:flex;align-items:center;justify-content:center;font-size:22px;font-weight:800;color:white;flex-shrink:0;box-shadow:0 0 30px var(--glow1)}
.profile-info h2{font-size:1.7rem;font-weight:800;color:var(--text);margin-bottom:3px}
.profile-info p{color:var(--text3);font-size:13px;margin-bottom:12px}
.pills{display:flex;flex-wrap:wrap;gap:8px}
.pill{padding:5px 13px;border-radius:9px;font-size:12px;font-weight:800}
.metrics-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(160px,1fr));gap:14px;margin-bottom:22px}
.metric-card{background:var(--card);border:1px solid var(--border);border-radius:18px;padding:18px;backdrop-filter:blur(12px);text-align:center;transition:transform .25s,box-shadow .25s}
.metric-card:hover{transform:translateY(-4px);box-shadow:0 0 40px var(--glow1)}
.metric-icon{font-size:26px;margin-bottom:8px}
.metric-val{font-size:1.8rem;font-weight:900;letter-spacing:-.03em;margin-bottom:2px}
.metric-label{font-size:11px;color:var(--text3);font-weight:600}
.metric-sub{font-size:11px;color:var(--text3);margin-top:4px}
.bar-val{display:flex;align-items:center;justify-content:space-between;margin-bottom:6px;font-size:13px;font-weight:700}
.track{height:7px;border-radius:999px;background:rgba(148,163,184,0.1);overflow:hidden;margin-bottom:14px}
.fill{height:100%;border-radius:999px}
table{width:100%;border-collapse:collapse}
.tbl-wrap{background:var(--card);border:1px solid var(--border);border-radius:20px;overflow:hidden;backdrop-filter:blur(12px);margin-bottom:22px;box-shadow:0 0 35px var(--glow1)}
.tbl-title{padding:16px 18px 0;font-size:14px;font-weight:800;color:var(--text);display:flex;align-items:center;gap:7px}
.tbl-title .ic{color:var(--acc)}
.tbl-scroll{overflow-x:auto;padding:12px 0}
thead tr{background:var(--thead);border-bottom:1px solid var(--border2)}
thead th{padding:11px 16px;text-align:left;font-size:11px;font-weight:800;color:var(--acc);text-transform:uppercase;letter-spacing:.08em;white-space:nowrap}
tbody tr{border-bottom:1px solid rgba(148,163,184,.04);transition:background .15s}
tbody tr:hover{background:var(--tr-hover)}
tbody td{padding:11px 16px;font-size:13px;color:var(--text)}
.sum-row{display:grid;grid-template-columns:repeat(auto-fit,minmax(185px,1fr));gap:14px}
.sum-card{background:var(--card);border:1px solid var(--border);border-radius:17px;padding:18px;backdrop-filter:blur(10px)}
.sum-label{font-size:11px;text-transform:uppercase;letter-spacing:.08em;font-weight:700;color:var(--text3);margin-bottom:5px}
.sum-val{font-size:20px;font-weight:900}
@keyframes fadeUp{from{opacity:0;transform:translateY(18px)}to{opacity:1;transform:translateY(0)}}
.main>*{animation:fadeUp .45s ease both}
@media print{nav,.orb,button{display:none!important}body{background:white!important;color:black!important}}
@media(max-width:520px){.profile-inner{flex-direction:column}.big-avatar{width:52px;height:52px}}
</style>
</head>
<body>
<div class="orb orb1"></div><div class="orb orb2"></div>
<nav>
  <div class="logo-row">
    <div class="logo-icon"><svg viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.2" stroke-linecap="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg></div>
    <span class="logo-name">IntelliResult</span>
  </div>
  <div class="nav-right">
    <button class="btn-sm" id="themeBtn">🌙</button>
    <a href="dashboard.html" class="btn-sm">← Dashboard</a>
    <button class="btn-sm" onclick="window.print()">🖨 Print</button>
    <a href="login.html" class="btn-sm btn-danger" onclick="sessionStorage.clear()">Sign Out</a>
  </div>
</nav>
<div class="main">

  <!-- Profile Card -->
  <div class="profile-card">
    <div class="profile-inner">
      <div class="big-avatar"><%= username.substring(0, Math.min(2, username.length())).toUpperCase() %></div>
      <div class="profile-info">
        <h2><%= username %></h2>
        <p>Student ID #<%= sid %> &nbsp;·&nbsp; CSV Dataset Record</p>
        <div class="pills">
          <span class="pill" style="background:<%= gc %>22;color:<%= gc %>;border:1px solid <%= gc %>33">Grade <%= grade %></span>
          <span class="pill" style="background:<%= statusColor %>18;color:<%= statusColor %>;border:1px solid <%= statusColor %>30"><%= statusLabel %></span>
          <span class="pill" style="background:rgba(99,102,241,0.12);color:var(--tag-text);border:1px solid rgba(99,102,241,0.25)">Rank #<%= rank %> / <%= totalStudents %></span>
        </div>
      </div>
    </div>
  </div>

  <!-- Metric Cards -->
  <div class="metrics-grid">
    <div class="metric-card">
      <div class="metric-icon">🎯</div>
      <div class="metric-val" style="color:#6366f1"><%= String.format("%.1f", score) %></div>
      <div class="metric-label">Total Score</div>
      <div class="metric-sub">Class avg: <%= classAvgScore %></div>
    </div>
    <div class="metric-card">
      <div class="metric-icon">🏫</div>
      <div class="metric-val" style="color:#10b981"><%= String.format("%.1f", attend) %>%</div>
      <div class="metric-label">Attendance</div>
      <div class="metric-sub">Class avg: <%= classAvgAtt %>%</div>
    </div>
    <div class="metric-card">
      <div class="metric-icon">📖</div>
      <div class="metric-val" style="color:#8b5cf6"><%= String.format("%.1f", study) %>h</div>
      <div class="metric-label">Study hrs / week</div>
      <div class="metric-sub">Class avg: <%= classAvgStudy %>h</div>
    </div>
    <div class="metric-card">
      <div class="metric-icon">🙋</div>
      <div class="metric-val" style="color:#38bdf8"><%= String.format("%.1f", partic) %></div>
      <div class="metric-label">Participation</div>
      <div class="metric-sub">out of 10.0</div>
    </div>
    <div class="metric-card">
      <div class="metric-icon">🏅</div>
      <div class="metric-val" style="color:<%= gc %>"><%= grade %></div>
      <div class="metric-label">Final Grade</div>
      <div class="metric-sub"><%= statusLabel %></div>
    </div>
    <div class="metric-card">
      <div class="metric-icon">📊</div>
      <div class="metric-val" style="color:#f59e0b">#<%= rank %></div>
      <div class="metric-label">Class Rank</div>
      <div class="metric-sub">of <%= totalStudents %> students</div>
    </div>
  </div>

  <!-- Performance Bars -->
  <div class="tbl-wrap" style="padding:22px">
    <div class="tbl-title"><span class="ic">📈</span> Performance Breakdown</div>
    <div style="padding:18px 0 0">
      <%
        double[][] metrics = {
            {score, 100, 0},
            {attend, 100, 0},
            {study, 30, 0},
            {partic, 10, 0},
        };
        String[] mNames  = {"Total Score", "Attendance", "Study Hours/wk", "Participation"};
        String[] mColors = {"#6366f1","#10b981","#8b5cf6","#38bdf8"};
        String[] mUnits  = {"%","% ","/30h","/10"};
        for (int mi = 0; mi < mNames.length; mi++) {
            double pct = (metrics[mi][0] / metrics[mi][1]) * 100;
      %>
      <div class="bar-val">
        <span><%= mNames[mi] %></span>
        <strong style="color:<%= mColors[mi] %>"><%= String.format("%.1f", metrics[mi][0]) %><%= mUnits[mi] %></strong>
      </div>
      <div class="track"><div class="fill" style="width:<%= String.format("%.0f", pct) %>%;background:<%= mColors[mi] %>"></div></div>
      <% } %>
    </div>
  </div>

  <!-- Class Comparison Table (top 20) -->
  <div class="tbl-wrap">
    <div class="tbl-title"><span class="ic">🏆</span> Class Leaderboard (Sample)</div>
    <div class="tbl-scroll">
      <table>
        <thead><tr><th>#</th><th>ID</th><th>Score</th><th>Attendance</th><th>Study h/wk</th><th>Partic.</th><th>Grade</th></tr></thead>
        <tbody>
          <%
            List<Map<String,String>> sorted = new ArrayList<>(allRecords);
            sorted.sort((a,b) -> Double.compare(
                Double.parseDouble(b.get("total_score")),
                Double.parseDouble(a.get("total_score"))));
            int dispCount = Math.min(20, sorted.size());
            for (int ri = 0; ri < dispCount; ri++) {
                Map<String,String> row = sorted.get(ri);
                String rGrade = row.get("grade");
                String rGC = gradeColor.getOrDefault(rGrade,"#94a3b8");
                boolean isMe = row.get("student_id").equals(String.valueOf(sid));
                double rScore = Double.parseDouble(row.get("total_score"));
          %>
          <tr style="<%= isMe?"background:rgba(99,102,241,0.12);outline:1px solid rgba(99,102,241,0.3)":"" %>">
            <td style="color:var(--text3);font-weight:700"><%= ri+1 %></td>
            <td style="font-family:monospace;font-size:12px;color:var(--text3)">#<%= row.get("student_id") %></td>
            <td><strong style="color:<%= rScore>=85?"#10b981":rScore>=70?"#6366f1":"#f59e0b" %>"><%= String.format("%.1f", rScore) %></strong></td>
            <td style="font-size:12px"><%= String.format("%.0f", Double.parseDouble(row.get("attendance_percentage"))) %>%</td>
            <td style="font-size:12px;color:var(--text2)"><%= String.format("%.1f", Double.parseDouble(row.get("weekly_self_study_hours"))) %>h</td>
            <td style="font-size:12px;color:var(--text2)"><%= String.format("%.1f", Double.parseDouble(row.get("class_participation"))) %></td>
            <td><span style="font-size:11px;font-weight:800;padding:3px 9px;border-radius:6px;background:<%= rGC %>22;color:<%= rGC %>;border:1px solid <%= rGC %>38"><%= rGrade %></span></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Summary row -->
  <div class="sum-row">
    <div class="sum-card" style="border-color:<%= statusColor %>33">
      <div class="sum-label" style="color:<%= statusColor %>">Overall Result</div>
      <div class="sum-val" style="color:<%= statusColor %>"><%= grade.equals("F") ? "⚠️ FAIL" : "✅ PASS" %></div>
    </div>
    <div class="sum-card">
      <div class="sum-label">Class Rank</div>
      <div class="sum-val">#<%= rank %> / <%= totalStudents %></div>
    </div>
    <div class="sum-card">
      <div class="sum-label">Score vs Average</div>
      <% double diff = score - Double.parseDouble(classAvgScore); %>
      <div class="sum-val" style="color:<%= diff>=0?"#10b981":"#f59e0b" %>"><%= (diff>=0?"+":"") + String.format("%.1f", diff) %> pts</div>
    </div>
    <div class="sum-card">
      <div class="sum-label">Dataset Source</div>
      <div class="sum-val" style="font-size:14px;color:var(--acc)">student_performance.csv</div>
    </div>
  </div>

</div>
<script>
const t = localStorage.getItem("ir-theme") || sessionStorage.getItem("ir-theme") || "dark";
document.documentElement.setAttribute("data-theme", t);
const btn = document.getElementById("themeBtn");
btn.textContent = t === "dark" ? "🌙" : "☀️";
btn.onclick = () => {
  const nt = document.documentElement.getAttribute("data-theme") === "dark" ? "light" : "dark";
  document.documentElement.setAttribute("data-theme", nt);
  localStorage.setItem("ir-theme", nt);
  btn.textContent = nt === "dark" ? "🌙" : "☀️";
};
</script>
</body>
</html>
