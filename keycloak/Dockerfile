FROM quay.io/keycloak/keycloak:25.0.5

RUN mkdir -p /opt/keycloak/data/import
COPY ./culinary-code-realm-export.json /opt/keycloak/data/import

EXPOSE 8080
EXPOSE 80

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "-v", "start-dev", "--import-realm"]
