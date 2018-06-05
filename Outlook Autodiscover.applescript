display dialog "What would you like to do with AutoDiscover?" buttons {"Do Nothing", "Disable", "Enable"}

if button returned of result is "Disable" then
	
	set input to display dialog "What is the account name you would like to turn autodiscover off for?" default answer "" buttons {"Cancel", "Disable"} default button "Disable"
	set AccountName to text returned of input
	tell application "Microsoft Outlook"
		set background autodiscover of exchange account AccountName to false
	end tell
	
else if button returned of result is "Enable" then
	
	set input to display dialog "What is the account name you would like to turn autodiscover off for?" default answer "" buttons {"Cancel", "Enable"} default button "Enable"
	set AccountName to text returned of input
	tell application "Microsoft Outlook"
		set background autodiscover of exchange account AccountName to true
	end tell
	
else if button returned of result is "Do Nothing" then
	display alert "Operation Cancelled"
	
end if
