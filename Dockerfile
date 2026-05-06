FROM tomcat:10.1-jdk17

# Remove default webapps if you want a clean app-only container
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your deployed app
COPY webapps/IntelliResult /usr/local/tomcat/webapps/IntelliResult

EXPOSE 8080

CMD ["catalina.sh", "run"]
