**Purpose**

The purpose of this repository is to contain a PowerShell script that retrieves the service status of Atlassian's OpsGenie, pulls the latest 3 service-impacting incidents, and posts this information to a Slack channel.

**URL Changes**

As URLs are changed and webhooks possibly require updating, follow the process below to find the latest updates required:

* statusUrl: Check the URL https://opsgenie.status.atlassian.com/api to see if the API endpoint has changed.
* incidentsUrl: Check the URL https://opsgenie.status.atlassian.com/api to see if the API endpoint has changed.
* slackWebhookUrl: Follow the process at https://api.slack.com/messaging/webhooks to check if the webhook is still valid and, if required, create a new one.

**Versioning**

Version 0.1 is a beta that requires further coding and should not be used in a production environment. Items on the backlog include:

* Localizing the time and dates
* Error handling for networking issues and API rate limiting
* Error handling for unexpected or missing values
