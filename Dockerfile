FROM python:3.10-slim

# Atualiza sistema
RUN apt-get update && \
    apt-get install -y build-essential libpq-dev wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Baixar pgAdmin4 standalone (modo servidor)
RUN mkdir -p /opt/pgadmin
WORKDIR /opt/pgadmin

RUN wget https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v8.11/pip/pgadmin4-8.11-py3-none-any.whl
RUN pip install pgadmin4-8.11-py3-none-any.whl

ENV PGADMIN_SETUP_EMAIL=${PGADMIN_DEFAULT_EMAIL}
ENV PGADMIN_SETUP_PASSWORD=${PGADMIN_DEFAULT_PASSWORD}
ENV PGADMIN_CONFIG_ENHANCED_COOKIE_PROTECTION=True
ENV PGADMIN_CONFIG_ALLOW_SAVE_PASSWORDS=True

# Pasta para persistência
RUN mkdir -p /var/lib/pgadmin
ENV PGADMIN_CONFIG_DATA_DIR=/var/lib/pgadmin

EXPOSE 80

CMD ["python3", "-m", "pgadmin4"]
