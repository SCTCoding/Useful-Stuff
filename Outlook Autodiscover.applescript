set pick to choose from list {"Enable","Disable"} with title "What would you like to do with AutoDiscover?"

set chosen to text returned of pick

if (" & pick & " = "Disable") then
  
  set input to display dialog "What is the account name you would like to turn autodiscover off for?" default answer "" with icon stop buttons {"Cancel", "Disable"} default button "Disable"
  if button returned of result = "Disable" then
    set AccountName to text returned of input
    tell application "Microsoft Outlook"
      set background autodiscover of exchange account " & AccountName & " to false
    end tell
  else
    display alert "Operation Cancelled"
  end if
  
else
  
  set input to display dialog "What is the account name you would like to turn autodiscover off for?" default answer "" with icon stop buttons {"Cancel", "Enable"} default button "Enable"
  if button returned of result = "Enable" then
    set AccountName to text returned of input
    tell application "Microsoft Outlook"
      set background autodiscover of exchange account " & AccountName & " to true
    end tell
  else
    display alert "Operation Cancelled"
  end if
  
end if
