FROM python:3.13-slim

# Note: using 3.13-slim since official python:3.14-slim images may not be
# published yet as of this writing. If you confirm python:3.14-slim exists
# on Docker Hub, swap this line to match your local Python version exactly.

WORKDIR /app

# Pillow needs these for image handling; PyMySQL is pure Python so no
# MySQL client libraries are needed here.
RUN apt-get update && apt-get install -y --no-install-recommends \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]