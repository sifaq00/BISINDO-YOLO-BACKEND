FROM python:3.10-slim

# Install library sistem yang wajib untuk menjalankan OpenCV di Linux
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /app/.config/Ultralytics && chmod -R 777 /app/.config

# Buka port 7860 (Port wajib Hugging Face)
EXPOSE 7860

# Jalankan aplikasi (app:app merujuk ke file app.py)
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]