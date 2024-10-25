# Infrastructure as Code

All the code for the infrastructure of the Culinary Code project.

## Docker Compose

```
name: culinary-code

services:
  idp_postgres:
    image: postgres:15.4-alpine
    volumes:
      - idp_data:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: keycloak
      POSTGRES_USER: keycloak
      POSTGRES_PASSWORD: password

  idp_keycloak:
      image: quay.io/keycloak/keycloak:25.0.6
      environment:
        - KEYCLOAK_ADMIN=admin
        - KEYCLOAK_ADMIN_PASSWORD=admin
        - KC_DB=postgres
        - KC_DB_URL_HOST=idp_postgres
        - KC_DB_URL_DATABASE=keycloak
        - KC_DB_USERNAME=keycloak
        - KC_DB_PASSWORD=password
      command: start-dev
      ports:
        - "8180:8080"
      depends_on:
        - idp_postgres
    
  postgres:
    image: postgres:15
    container_name: postgres-db
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
      POSTGRES_DB: mydatabase
    ports:
      - "5432:5432"
    volumes:
      - backend_data:/var/lib/postgresql/data

volumes:
  backend_data:
  idp_data:
```