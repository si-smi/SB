# URLs for service status, incidents and the Slack webhook
$statusUrl = "http://status.opsgenie.com/api/v2/status.json"
$incidentsUrl = "http://status.opsgenie.com/api/v2/incidents.json"
$slackWebhookUrl = "https://hooks.slack.com/services/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"  # Replace with your actual Slack webhook URL

# Get the current timestamp
$timestamp = (Get-Date).ToString("dd-MM-yyyy HH:mm")

# Get the service status
$status = (Invoke-WebRequest -Uri $statusUrl -Method Get).Content | ConvertFrom-Json

# Get the incidents
$incidents = (Invoke-WebRequest -Uri $incidentsUrl -Method Get).Content | ConvertFrom-Json

# Create an empty string that gets filled in with the status and incident data
$incidentText = ""

# Format the last 3 incidents
$incidents.incidents | Sort-Object created_at -Descending | Select-Object -First 3 | ForEach-Object {
    $incidentText += "Incident: $($_.name)`nCreated at: $($_.created_at)`nStatus: $($_.status)`n`n"
}

# Combine service status and incidents into one message
$slackMessage = "Service Status: $($status.status.description), Retrieved at: $timestamp`n`nRecent Incidents:`n$incidentText"

# Send the message to Slack
$payload = @{ text = $slackMessage } | ConvertTo-Json
Invoke-RestMethod -Uri $slackWebhookUrl -Method Post -ContentType 'application/json' -Body $payload
