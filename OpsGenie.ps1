# URLs for service status, incidents and the Slack webhook
$statusUrl = "http://status.opsgenie.com/api/v2/status.json"
$incidentsUrl = "http://status.opsgenie.com/api/v2/incidents.json"
$slackWebhookUrl = "https://hooks.slack.com/services/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"  # Replace with your actual Slack webhook URL

# Get the current timestamp
$timestamp = (Get-Date).ToString("dd-MM-yyyy HH:mm")

#--------------

# Get the service status using the invoke-webrequest get so error handling can be coded in future
# Convert from JSON to a custom PShell object to work with
$ status = (Invoke-WebRequest -Uri $statusUrl -Method Get).Content | ConvertFrom-Json

# Get the incident statuses using invoke-webrequest get, so again the error handling can be coded in future
# Convert from JSON to a custom PShell object to work with
$incidents = (Invoke-WebRequest -Uri $incidentsUrl -Method Get).Content | ConvertFrom-Json

# Create an empty string that will get filled with the status and incident data from the for-each loop in line 21
$incidentText = ""

# Get the incident data from the variable created in line 15, sort by date created and the only get the first 3 results, then open a for-each loop
$incidents.incidents | Sort-Object created_at -Descending | Select-Object -First 3 | ForEach-Object {
# Fill in the empty string variable from line 18 with incident data by combing the incident name, date created and the incident status (most recent 3). Use the 'n special character to format.
    $incidentText += "Incident: $($_.name)`nCreated at: $($_.created_at)`nStatus: $($_.status)`n`n"
}

# Combine service status and incidents into one message that will be posted into slack via webhook (currently still in a PShell custom object)
$slackMessage = "Service Status: $($status.status.description), Retrieved at: $timestamp`n`nRecent Incidents:`n$incidentText"

# Add the combined messages into a single payload and convert the now single message into JSON.
$payload = @{ text = $slackMessage } | ConvertTo-Json
# Use Invoke-RetMehtod to Post the content of the payload variable into the Slack channel as JSON
Invoke-RestMethod -Uri $slackWebhookUrl -Method Post -ContentType 'application/json' -Body $payload
