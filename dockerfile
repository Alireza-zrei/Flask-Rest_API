FROM python

WORKDIR /app

COPY requirements.txt .

RUN pip install  --no-cache-dir --index-url https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt

COPY app.py .

CMD [ "python", "app.py" ]
