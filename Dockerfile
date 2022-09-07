FROM python:3.10-slim
WORKDIR src/app

RUN pip install gunicorn==20.1.0

COPY webserver/requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY webserver/ .

CMD ["gunicorn","--bind=0.0.0.0:8000", "--workers=1", "--threads=15" , "app:app"]
