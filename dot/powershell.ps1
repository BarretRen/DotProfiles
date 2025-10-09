function prompt {
    $orange =[char]27 + "[33m"
    $reset = [char]27 + "[0m"

    $location = $executionContext.SessionState.Path.CurrentLocation
    $branch = git branch --show-current 2>$null
    if ($branch) {
        "$location $orange[$branch]$reset > "
    } else {
        "$location > "
    }
}
