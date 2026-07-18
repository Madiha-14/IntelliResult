// ── IntelliResult · CSV Dataset (student_performance.csv — first 50 rows) ──
// Columns: student_id, weekly_self_study_hours, attendance_percentage, class_participation, total_score, grade

const CSV_DATA = [
  {student_id:1,weekly_self_study_hours:18.5,attendance_percentage:95.6,class_participation:3.8,total_score:97.9,grade:"A"},
  {student_id:2,weekly_self_study_hours:14.0,attendance_percentage:80.0,class_participation:2.5,total_score:83.9,grade:"B"},
  {student_id:3,weekly_self_study_hours:19.5,attendance_percentage:86.3,class_participation:5.3,total_score:100.0,grade:"A"},
  {student_id:4,weekly_self_study_hours:25.7,attendance_percentage:70.2,class_participation:7.0,total_score:100.0,grade:"A"},
  {student_id:5,weekly_self_study_hours:13.4,attendance_percentage:81.9,class_participation:6.9,total_score:92.0,grade:"A"},
  {student_id:6,weekly_self_study_hours:13.4,attendance_percentage:65.1,class_participation:5.0,total_score:97.5,grade:"A"},
  {student_id:7,weekly_self_study_hours:26.1,attendance_percentage:81.8,class_participation:5.9,total_score:100.0,grade:"A"},
  {student_id:8,weekly_self_study_hours:20.4,attendance_percentage:100.0,class_participation:4.0,total_score:96.1,grade:"A"},
  {student_id:9,weekly_self_study_hours:11.7,attendance_percentage:100.0,class_participation:8.2,total_score:69.8,grade:"C"},
  {student_id:10,weekly_self_study_hours:18.8,attendance_percentage:67.6,class_participation:6.0,total_score:80.3,grade:"B"},
  {student_id:11,weekly_self_study_hours:11.8,attendance_percentage:82.3,class_participation:4.6,total_score:66.4,grade:"C"},
  {student_id:12,weekly_self_study_hours:11.7,attendance_percentage:75.9,class_participation:7.6,total_score:72.5,grade:"B"},
  {student_id:13,weekly_self_study_hours:16.7,attendance_percentage:77.9,class_participation:2.5,total_score:95.2,grade:"A"},
  {student_id:14,weekly_self_study_hours:1.6,attendance_percentage:92.1,class_participation:5.7,total_score:60.9,grade:"C"},
  {student_id:15,weekly_self_study_hours:2.9,attendance_percentage:90.7,class_participation:5.4,total_score:52.1,grade:"D"},
  {student_id:16,weekly_self_study_hours:11.1,attendance_percentage:87.4,class_participation:3.9,total_score:73.5,grade:"B"},
  {student_id:17,weekly_self_study_hours:7.9,attendance_percentage:85.9,class_participation:7.7,total_score:63.0,grade:"C"},
  {student_id:18,weekly_self_study_hours:17.2,attendance_percentage:74.0,class_participation:8.1,total_score:100.0,grade:"A"},
  {student_id:19,weekly_self_study_hours:8.6,attendance_percentage:100.0,class_participation:9.0,total_score:75.4,grade:"B"},
  {student_id:20,weekly_self_study_hours:5.1,attendance_percentage:91.4,class_participation:4.5,total_score:57.9,grade:"C"},
  {student_id:21,weekly_self_study_hours:22.3,attendance_percentage:78.5,class_participation:6.2,total_score:88.7,grade:"B"},
  {student_id:22,weekly_self_study_hours:30.0,attendance_percentage:95.0,class_participation:9.5,total_score:100.0,grade:"A"},
  {student_id:23,weekly_self_study_hours:6.5,attendance_percentage:60.3,class_participation:3.1,total_score:45.0,grade:"D"},
  {student_id:24,weekly_self_study_hours:9.8,attendance_percentage:72.4,class_participation:4.8,total_score:68.3,grade:"C"},
  {student_id:25,weekly_self_study_hours:21.0,attendance_percentage:89.1,class_participation:7.3,total_score:94.5,grade:"A"},
  {student_id:26,weekly_self_study_hours:14.5,attendance_percentage:83.6,class_participation:5.5,total_score:79.2,grade:"B"},
  {student_id:27,weekly_self_study_hours:3.2,attendance_percentage:55.0,class_participation:2.0,total_score:38.4,grade:"F"},
  {student_id:28,weekly_self_study_hours:17.8,attendance_percentage:91.2,class_participation:6.8,total_score:90.1,grade:"A"},
  {student_id:29,weekly_self_study_hours:12.3,attendance_percentage:76.7,class_participation:5.1,total_score:71.9,grade:"B"},
  {student_id:30,weekly_self_study_hours:24.6,attendance_percentage:97.3,class_participation:8.7,total_score:99.3,grade:"A"},
  {student_id:31,weekly_self_study_hours:8.1,attendance_percentage:69.5,class_participation:4.2,total_score:59.8,grade:"C"},
  {student_id:32,weekly_self_study_hours:15.9,attendance_percentage:84.8,class_participation:6.5,total_score:85.6,grade:"B"},
  {student_id:33,weekly_self_study_hours:20.7,attendance_percentage:93.4,class_participation:7.9,total_score:98.2,grade:"A"},
  {student_id:34,weekly_self_study_hours:4.4,attendance_percentage:62.1,class_participation:3.3,total_score:47.7,grade:"D"},
  {student_id:35,weekly_self_study_hours:16.2,attendance_percentage:80.6,class_participation:5.8,total_score:82.4,grade:"B"},
  {student_id:36,weekly_self_study_hours:10.5,attendance_percentage:73.9,class_participation:4.4,total_score:65.1,grade:"C"},
  {student_id:37,weekly_self_study_hours:27.3,attendance_percentage:96.8,class_participation:9.2,total_score:100.0,grade:"A"},
  {student_id:38,weekly_self_study_hours:13.1,attendance_percentage:78.3,class_participation:5.6,total_score:76.8,grade:"B"},
  {student_id:39,weekly_self_study_hours:9.3,attendance_percentage:88.7,class_participation:6.1,total_score:62.5,grade:"C"},
  {student_id:40,weekly_self_study_hours:18.0,attendance_percentage:85.2,class_participation:7.4,total_score:91.3,grade:"A"},
  {student_id:41,weekly_self_study_hours:2.1,attendance_percentage:58.4,class_participation:2.8,total_score:41.2,grade:"D"},
  {student_id:42,weekly_self_study_hours:23.5,attendance_percentage:94.7,class_participation:8.5,total_score:97.1,grade:"A"},
  {student_id:43,weekly_self_study_hours:7.6,attendance_percentage:71.3,class_participation:4.1,total_score:55.8,grade:"C"},
  {student_id:44,weekly_self_study_hours:14.8,attendance_percentage:82.9,class_participation:6.3,total_score:81.6,grade:"B"},
  {student_id:45,weekly_self_study_hours:19.2,attendance_percentage:90.5,class_participation:7.6,total_score:93.8,grade:"A"},
  {student_id:46,weekly_self_study_hours:11.4,attendance_percentage:75.1,class_participation:5.2,total_score:70.4,grade:"B"},
  {student_id:47,weekly_self_study_hours:6.0,attendance_percentage:64.8,class_participation:3.6,total_score:51.9,grade:"D"},
  {student_id:48,weekly_self_study_hours:22.8,attendance_percentage:92.6,class_participation:8.0,total_score:96.7,grade:"A"},
  {student_id:49,weekly_self_study_hours:10.2,attendance_percentage:77.4,class_participation:4.7,total_score:67.2,grade:"C"},
  {student_id:50,weekly_self_study_hours:15.5,attendance_percentage:86.0,class_participation:6.0,total_score:84.1,grade:"B"},
];

// User accounts — tied to student_id in CSV
const IR_USERS = {
  student1: { password:"1234",    studentId:1, name:"Arjun Mehta",   avatar:"AM", branch:"Computer Science",    semester:"4th Semester", rollNo:"CS2024-001" },
  admin:    { password:"admin123", studentId:2, name:"Priya Sharma",  avatar:"PS", branch:"Electronics & Comm.", semester:"6th Semester", rollNo:"EC2024-002" },
};
for (let i = 1; i <= 50; i++) {
  const key = "S" + String(i).padStart(3,"0");
  IR_USERS[key] = {
    password:"pass123", studentId:i,
    name: `Student #${i}`,
    avatar: "S" + i,
    branch:"General Engineering",
    semester:"Current Semester",
    rollNo:"GE2024-" + String(i).padStart(3,"0")
  };
}

function getStudentData(username) {
  const account = IR_USERS[username];
  if (!account) return null;
  const row = CSV_DATA.find(r => r.student_id === account.studentId);
  if (!row) return null;
  return { ...account, ...row };
}

function gradeColor(g) {
  return {A:"#10b981",B:"#3b82f6",C:"#f59e0b",D:"#f97316",F:"#ef4444"}[g] || "#94a3b8";
}
function gradeLabel(g) {
  return {A:"Outstanding",B:"Good",C:"Average",D:"Below Average",F:"Fail"}[g] || "N/A";
}
function scoreToGrade(s) {
  if(s>=90)return"A";if(s>=75)return"B";if(s>=60)return"C";if(s>=45)return"D";return"F";
}