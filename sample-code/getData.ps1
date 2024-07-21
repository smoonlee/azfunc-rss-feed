param (
    [string]$rssUrl = "https://blog.builtwithcaffeine.cloud/rss.xml"
)

# Load the RSS feed
try {
    [xml]$rssFeed = Invoke-WebRequest -Uri $rssUrl -UseBasicParsing
} catch {
    Write-Error "Failed to load RSS feed from $rssUrl"
    exit 1
}

# Check if the RSS feed was loaded successfully
if ($rssFeed -eq $null) {
    Write-Error "Failed to parse RSS feed from $rssUrl"
    exit 1
}

# Parse and display the RSS feed items
$rssFeed.rss.channel.item | ForEach-Object {
    $title = $_.title
    $link = $_.link
    $date = $_.pubDate
    $slug = $_.guid
    Write-Output "Title: $title"
    Write-Output "Link: $link"
    Write-Output "Date: $date"
    Write-Output "Slug: $slug"
    Write-Output "----"
}
