FROM postgres:latest

ENV POSTGRES_DB=synthea
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres

COPY synthea.sql /docker-entrypoint-initdb.d/
