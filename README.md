**Purpose**

The purpose of is repository is to contain a PowerShell script that retrieves the service staus of Atlassians OpsGenie, pull the latest 3 service impacting incidents and post this information to a Slack channel.

**URL Changes**

As URLs are changed and webhooks possibly requiring updating, follow the below process to find the latest updates required:
statusUrl: Check the URL https://opsgenie.status.atlassian.com/api to see if the API endpoint has changed
incidentsUrl: Check the URL https://opsgenie.status.atlassian.com/api to see if the API endpoint has changed
slackWebhookUrl: Follow the process at the URL https://api.slack.com/messaging/webhooks to check if the webhook is still valid and if requried create a new one

**Versioing**

Version 0.1 is a beta that requies further coding and should not be used in a production environment.
Items on the backlog include:
* Localising the time and dates
* Error handling for networking issues and API rate limiting
* Error handling for unexpected or missing values
