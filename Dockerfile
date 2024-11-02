FROM python:3.12-slim

COPY  . /app

WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE 5052

ENTRYPOINT ["sh", "-c", "sleep 10 && python app.py"]