set lock_file ~/.agents/.skill-lock.json

if not test -f $lock_file
    echo "No skills lock file found at $lock_file"
    return 1
end

set skills (jq -r '.skills | keys[]' $lock_file)

if test (count $skills) -eq 0
    echo "No global skills found in $lock_file"
    return 0
end

echo "Installing "(count $skills)" global skill(s) from $lock_file..."

for skill in $skills
    set source (jq -r ".skills[\"$skill\"].source" $lock_file)
    echo "→ $skill ($source)"
    npx skills add $source --skill $skill -g -y
end
