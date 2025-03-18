# OpenAI Realtime API Phone Bot

A telephone-based conversational agent built with Pipecat, powered by OpenAI's Realtime API and Twilio. Ask it about NCAA basketball scores during March Madness!

## Configuration

Rename the `env.example` file to `.env` and set the following:

- `OPENAI_API_KEY` to use OpenAI (obviously)
- `DAILY_API_KEY` Optional, but highly recommended. Enables easy Daily integration (see below). Get it from your Pipecat Cloud Dashboard: `https://pipecat.daily.co/<your-org-id>/settings/daily`

You'll need a Docker Hub account to deploy. You'll also need a Twilio account if you want to call your bot.

## Deploying to Pipecat Cloud

Taken from the [Pipecat Cloud Quickstart](https://docs.pipecat.io/guides/pipecat-cloud/quickstart/).

Set up a local environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Build the docker image:

```bash
docker build --platform=linux/arm64 -t openai-twilio:latest .
docker tag openai-twilio:latest your-username/openai-twilio:0.1
docker push your-username/openai-twilio:0.1
```

Deploy it to Pipecat Cloud:

```
pcc auth login # to authenticate
pcc secrets set openai-twilio-secrets --file .env # to store your environment variables
pcc deploy openai-twilio your-username/openai-twilio:0.1 --secrets openai-twilio-secrets
```

## Configuring Twilio support

To connect this agent to Twilio:

1. [Purchase a number from Twilio](https://help.twilio.com/articles/223135247-How-to-Search-for-and-Buy-a-Twilio-Phone-Number-from-Console), if you haven't already

2. Collect your Pipecat Cloud organization name:

```bash
pcc organizations list
```

You'll use this information in the next step.

3. Create a [TwiML Bin](https://help.twilio.com/articles/360043489573-Getting-started-with-TwiML-Bins):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Connect>
    <Stream url="wss://api.pipecat.daily.co/ws/twilio">
      <Parameter name="_pipecatCloudServiceHost" value="AGENT_NAME.ORGANIZATION_NAME"/>
    </Stream>
  </Connect>
</Response>
```

where:

- AGENT_NAME is your agent's name (the name you used when deploying)
- ORGANIZATION_NAME is the value returned in the previous step

In this case, it will look something like `value="openai-twilio.level-gorilla-gray-123"`.

4. Assign the TwiML Bin to your phone number:

- Select your number from the Twilio dashboard
- In the `Configure` tab, set `A call comes in` to `TwiML Bin`
- Set `TwiML Bin` to the Bin you created in the previous step
- Save your configuration

Now call your Twilio number, and you should be connected to your bot!

## Running the bot locally

Pipecat uses [Transports](https://docs.pipecat.ai/server/base-classes/transport) to handle audio and video to and from the bot. When you use the `FastAPIWebsocketTransport` and deploy your bot to Pipecat Cloud, the service handles connecting Twilio's websocket to your bot. This is tricky to do locally, so this bot also has a `DailyTransport`.

If you've set `DAILY_API_KEY` in your `.env` file, you can run the bot locally in your Python environment with:

```bash
python bot.py
```

If you look at the console output, you should see something like:

```
2025-03-18 22:23:13.309 | INFO     | runner:configure_with_args:79 - Daily room URL: https://cloud-longstring.daily.co/another-long-string
```

Open that URL in your browser, and you'll join a Daily room with your bot.

Additionally, with the `DailyTransport` in your botfile, you can talk to the bot in the Pipecat Cloud dashboard: `https://pipecat.daily.co/<your-org-id>/agents/openai-twilio/sandbox`.

## Customizing the Bot

### Changing the Bot Personality

Modify the system prompt in `bot.py`:

```python
    instructions="""You are a helpful and friendly AI...
```

### Adding more function calls

Search for `basketball_scores` in the codebase to find where the existing function calls are registered. Learn all about Pipecat function calling [here](https://docs.pipecat.io/guides/function-calling/).
