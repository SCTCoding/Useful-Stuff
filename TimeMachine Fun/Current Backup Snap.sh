#! /bin/bash

# Be sure to only run this script if no backup is currently running.

# Stop TimeMachine to make sure nothing causes issues with the snapshot.
tmutil disable

# The current backup that was most recently completed.
current_backup=$(tmutil latestbackup)

# Comment that should be associated with the snapshot.
read -p "Snapshot Description: " comment

# Obtain current timestamp
date=$(date +%s)

# Make a directory for the file.
mkdir /Volumes/"$(tmutil latestbackup | cut -d "/" -f3)"/Snapshots/"$(echo -n "$date - $comment")"

# Copy the current backup to the designated folder.
cp -R "$current_backup" /Volumes/"$(tmutil latestbackup | cut -d "/" -f3)"/Snapshots/"$(echo -n "$date - $comment")"/

# Re-enable TimeMachine.
tmutil enable

exit
