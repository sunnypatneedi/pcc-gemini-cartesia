FROM dailyco/pipecat-base:latest

COPY ./requirements.txt requirements.txt
COPY ./pipecat-march-openai pipecat-march-openai
RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY ./runner.py runner.py
COPY ./bot.py bot.py
