# PowerShell script to update OpenRouter model data
# Equivalent of get_zipped.sh for Windows

# Check if data/output.json exists, if not create it
if (-not (Test-Path "data\output.json")) {
    New-Item -ItemType Directory -Force -Path "data"
    New-Item -ItemType File -Force -Path "data\output.json"
}

# Get the current timestamp
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Create a new directory inside the 'results' folder based on the timestamp
$outputDir = "results\output_$timestamp"
New-Item -ItemType Directory -Force -Path $outputDir

# Fetch the new data and save as output.json in the new directory
try {
    Invoke-RestMethod -Uri 'https://openrouter.ai/api/v1/models' -OutFile "$outputDir\output.json"
    Write-Host "Successfully fetched data from OpenRouter API"
} catch {
    Write-Error "Failed to fetch data from OpenRouter API: $_"
    exit 1
}

# Convert JSON to CSV, saving to the new directory
# Note: This requires PowerShell 7+ or having jq installed
# For simplicity, we'll create a basic CSV structure
$data = Get-Content "$outputDir\output.json" | ConvertFrom-Json

# Create CSV header
"id,name,created,context_length,pricing.prompt,pricing.completion,tool_calling,structured_outputs,reasoning,response_format,web_search" | Out-File "$outputDir\output.csv"

# Process each model and add to CSV
foreach ($model in $data.data) {
    # Check for tool calling
    $toolCalling = if ($model.supported_parameters -contains "tool_choice" -and $model.supported_parameters -contains "tools") { "Yes" } else { "No" }
    
    # Check for structured outputs
    $structuredOutputs = if ($model.supported_parameters -contains "structured_outputs") { "Yes" } else { "No" }
    
    # Check for reasoning
    $reasoning = if ($model.supported_parameters -contains "reasoning" -or $model.supported_parameters -contains "include_reasoning") { "Yes" } else { "No" }
    
    # Check for response format
    $responseFormat = if ($model.supported_parameters -contains "response_format") { "Yes" } else { "No" }
    
    # Check for web search
    $webSearch = if ($model.supported_parameters -contains "web_search_options") { "Yes" } else { "No" }
    
    # Create CSV line
    $csvLine = "`"$($model.id)`",`"$($model.name)`",`"$($model.created)`",`"$($model.context_length)`",`"$($model.pricing.prompt)`",`"$($model.pricing.completion)`",`"$toolCalling`",`"$structuredOutputs`",`"$reasoning`",`"$responseFormat`",`"$webSearch`""
    $csvLine | Out-File "$outputDir\output.csv" -Append
}

# Check if there is an existing output.json in the data directory
if (Test-Path "data\output.json") {
    # Compare the newly fetched data with the existing data
    $existingData = Get-Content "data\output.json" -Raw
    $newData = Get-Content "$outputDir\output.json" -Raw
    
    if ($existingData -eq $newData) {
        Write-Host "No change in data, skipping update."
    } else {
        Write-Host "Data has changed, updating files."
        
        Copy-Item "$outputDir\output.json" "data\output.json" -Force
        Copy-Item "$outputDir\output.csv" "data\output.csv" -Force
        Write-Host "Copied output.json and output.csv to the data directory"
        
        # Output the timestamp to a file named updated only if there was a change in data
        $timestamp | Out-File "data\updated" -NoNewline
    }
}

# Print the output directory for reference
Write-Host "Results saved in: $outputDir"

# Compress the output directory into a zip file
$zipFile = "results\output_$timestamp.zip"
Compress-Archive -Path "$outputDir\*" -DestinationPath $zipFile -Force

# Delete the output directory after zipping
Remove-Item -Recurse -Force $outputDir
Write-Host "Zipped results saved in: $zipFile"