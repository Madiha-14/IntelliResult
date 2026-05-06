package com.app;
import java.io.*;
import java.util.*;

/**
 * DBConnection — now reads from student_performance.csv instead of MySQL.
 * Place student_performance.csv inside WEB-INF/classes/ or the project root.
 *
 * CSV columns: student_id, weekly_self_study_hours, attendance_percentage,
 *              class_participation, total_score, grade
 */
public class DBConnection {

    // ── Hardcoded users ────────────────────────────────────────────────────────
    // Maps username → {password, student_id}
    private static final Map<String, String[]> USER_STORE = new LinkedHashMap<>();

    static {
        USER_STORE.put("student1", new String[]{"1234",    "1"});
        USER_STORE.put("admin",    new String[]{"admin123","2"});
        // S001 – S050: shorthand accounts
        for (int i = 1; i <= 50; i++) {
            String key = String.format("S%03d", i);
            USER_STORE.put(key, new String[]{"pass123", String.valueOf(i)});
        }
    }

    // ── Validate login ─────────────────────────────────────────────────────────
    public static boolean validateUser(String username, String password) {
        String[] creds = USER_STORE.get(username);
        return creds != null && creds[0].equals(password);
    }

    // ── Get student_id for a username ─────────────────────────────────────────
    public static int getStudentId(String username) {
        String[] creds = USER_STORE.get(username);
        return creds != null ? Integer.parseInt(creds[1]) : -1;
    }

    // ── Read one student row from CSV by student_id ────────────────────────────
    /**
     * Returns a Map with keys:
     *   student_id, weekly_self_study_hours, attendance_percentage,
     *   class_participation, total_score, grade
     * Returns null if not found.
     */
    public static Map<String, String> getStudentRecord(int studentId, String csvPath) {
        try (BufferedReader br = new BufferedReader(new FileReader(csvPath))) {
            String header = br.readLine(); // skip header
            if (header == null) return null;

            String[] cols = header.split(",");
            String line;
            while ((line = br.readLine()) != null) {
                String[] vals = line.split(",");
                if (vals.length < cols.length) continue;
                if (Integer.parseInt(vals[0].trim()) == studentId) {
                    Map<String, String> row = new LinkedHashMap<>();
                    for (int i = 0; i < cols.length; i++) {
                        row.put(cols[i].trim(), vals[i].trim());
                    }
                    return row;
                }
            }
        } catch (IOException | NumberFormatException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── Read all student records (for leaderboard / class stats) ─────────────
    public static List<Map<String, String>> getAllRecords(String csvPath, int limit) {
        List<Map<String, String>> records = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(csvPath))) {
            String header = br.readLine();
            if (header == null) return records;

            String[] cols = header.split(",");
            String line;
            int count = 0;
            while ((line = br.readLine()) != null && count < limit) {
                String[] vals = line.split(",");
                if (vals.length < cols.length) continue;
                Map<String, String> row = new LinkedHashMap<>();
                for (int i = 0; i < cols.length; i++) {
                    row.put(cols[i].trim(), vals[i].trim());
                }
                records.add(row);
                count++;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return records;
    }
}