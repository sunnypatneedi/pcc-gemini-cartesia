# OpenAI Realtime API Phone Bot

A telephone-based conversational agent built with Pipecat, powered by OpenAI's Realtime API. Ask it about NCAA basketball scores during March Madness!

## Configuration

Rename the `env.example` file to `.env` and set the following:

- `OPENAI_API_KEY` to use OpenAI (obviously)
- `DAILY_API_KEY` Optional, but highly recommended. Enables easy Daily integration (see below). Get it from your Pipecat Cloud Dashboard: `https://pipecat.daily.co/<your-org-id>/settings/daily`
- Twilio account with Media Streams configured (See below)

## Quick Customization

### Change Bot Personality

Modify the system prompt in `bot.py`:

```python
    instructions="""You are a helpful and friendly AI...
```

### Add more function calls

Search for `basketball_scores` in the codebase to find where the existing function calls are registered. Learn all about Pipecat function calling [here](https://docs.pipecat.io/guides/function-calling/).

## Twilio Setup

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

4. Assign the TwiML Bin to your phone number:

- Select your number from the Twilio dashboard
- In the `Configure` tab, set `A call comes in` to `TwiML Bin`
- Set `TwiML Bin` to the Bin you created in the previous step
- Save your configuration

## Deployment

See the [top-level README](../README.md) for deployment instructions.
