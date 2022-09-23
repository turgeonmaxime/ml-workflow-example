# Base image
FROM python:3.9

# Set working directory
RUN mkdir -p /app/artifacts
WORKDIR /app

# Install dependencies
COPY src/requirements.txt /app
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy files
COPY src/04-predict-newdata.py /app
COPY src/artifacts/column_trans.joblib /app/artifacts
COPY src/artifacts/final_regr.joblib /app/artifacts

RUN mv /app/04-predict-newdata.py /app/main.py


# Run the application
# EXPOSE 8000
# ENTRYPOINT ["uvicorn"]
# CMD ["main:app"]
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]