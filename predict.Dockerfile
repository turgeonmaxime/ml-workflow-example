# Base image
FROM python:3.9

# Set working directory
RUN mkdir -p /app/artifacts
WORKDIR /app

# Install dependencies
COPY src/requirements.txt /app
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy files
COPY src/04-setup-predict-api.py /app
COPY src/artifacts/column_trans.joblib /app/artifacts
COPY src/artifacts/final_regr.joblib /app/artifacts

RUN mv /app/04-setup-predict-api.py /app/main.py

# Run the application
CMD ["gunicorn", "main:app", "--bind", "0.0.0.0:5000"]
