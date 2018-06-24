// Not my code. Comes from: https://docs.microsoft.com/en-us/exchange/client-developer/web-service-reference/serverversion-pox

using System;

class ExchangeVersion
{
	static void Main(string[] args)
	{
		// Convert a ServerVersion value that is returned from an Autodiscover request.
		// The value is a hex value and can be converted to the MajorVersion, MinorVersion,
		// and MajorBuildNumber.
		Console.WriteLine("Enter ServerVersion returned from the Autodiscover (eg. 738180DA) and Enter.");
		Console.WriteLine("To use the default ServerVersion of 738180DA, just hit Enter.");
		// Get the hexadecimal ServerVersion value.
		string serverversionhex = Console.ReadLine();
		// If nothing is entered, use the default server version of "738180DA"
		if (serverversionhex == "")
		{
			serverversionhex = "738180DA";
		}
		Console.WriteLine("ServerVersion (Hex) = " + serverversionhex);
		string serverversionbinary = Convert.ToString(Convert.ToInt32(serverversionhex, 16), 2);
		// The ServerVersion (binary) should be 32 bits in length. If the 
		// server version in binary is a length of 31 characters, the leading
		// zero has been removed in the conversion process. Put the missing zero back.
		if (serverversionbinary.Length == 31)
		{
			serverversionbinary = String.Concat("0", serverversionbinary);
		}
		Console.WriteLine("ServerVersion (bin) = " + serverversionbinary);
		// The first 4 bits represent a number used for comparison against  
		// older version number structures. You can ignore this.
		// The next 6 bits represent the major version number.
		int majorversion = Convert.ToInt32(serverversionbinary.Substring(4, 6), 2);
		Console.WriteLine("MajorVersion: " + majorversion);
		// The next 6 bits represent the minor version number.
		int minorversion = Convert.ToInt32(serverversionbinary.Substring(10, 6), 2);
		Console.WriteLine("MinorVersion: " + minorversion);
		
		// The next bit represent a flag - you can ignore this.
		// The next 15 bits represent the major build number.
		int majorbuild = Convert.ToInt32(serverversionbinary.Substring(17, 15), 2);
		Console.WriteLine("MajorBuildVersion: " + majorbuild);
		Console.WriteLine("\n\nPress any key to continue");
		Console.ReadKey();
	}
}
