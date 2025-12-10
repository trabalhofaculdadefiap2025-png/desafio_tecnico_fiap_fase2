FROM python:3.10-slim

WORKDIR /app

RUN pip install --upgrade pip

COPY requirements.txt .

# Instala as dependências (incluindo as novas da Fase 2)
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8501

CMD ["streamlit", "run", "deploy.py", "--server.port", "8501", "--server.address", "0.0.0.0"]
