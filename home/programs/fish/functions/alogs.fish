echo "Enter AWS profile (default: pretto-prod):"
read -l aws_profile
if not set -q aws_profile
    set aws_profile pretto-prod
end
echo "Verifying AWS SSO session..."
if not aws sso list-accounts --profile $aws_profile --config ~/.aws/config > /dev/null 2>&1
    aws sso login --profile $aws_profile
end
echo "Select log group..."
set selected_group (awslogs groups --profile pretto-prod | fzf)
echo "Add any filters you like..."
read -l filters
echo "Fetching logs..."
awslogs get $selected_group --timestamp --profile pretto-prod $filters
