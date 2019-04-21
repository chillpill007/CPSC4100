<?php

function getFontTable()
{
	//using our unified font document
	$myFile = fopen("font.txt", 'r');
	$height = 8;
	$map = array();
	fgets($myFile);
	$get = fgets($myFile);
	//$letter = fgets($myFile);
	$letter = substr($get,0,-1);
	$map[$letter]="";
	//getting each letter bound into an array key
	if(isset($map[$letter]))
	{
	while($letter != NULL)
		{
			$map[$letter] = "";
			for ($word = 1; $word<=$height;$word++)
			{
				$newPart = fgets($myFile);
				$map[$letter] = $map[$letter].$newPart;
				
			}
			$get= fgets($myFile);
			$letter = substr($get,0,-1);
		}
	}
	//close the file and return the array
	fclose($myFile);
	return $map;
}

function printAsciiString($string,$fontMap)
{
	//im using a new array to simplify things a little
	$characterTable=[];
	//this array is indexed with numbers
	$sepString=str_split($string);
	for($i =0; $i<strlen($string);$i++)
	{
		$characterTable[$i]=$fontMap[$sepString[$i]];

	}
	checkTableLines($characterTable);
}

//getting to output on one line
function checkTableLines($characterTable)
{
	//base case
	$containsLines = False;
	if(strpos($characterTable[0],"\n") !==False)
	{
		$containsLines = true;
	}
	if($containsLines==false)
	{
		return;
	}
	//recursive case
		$thisLine="";
		//printing a line at a certain height
		$newCharacterTable=[];
		//this new table will contain the previous table with the previous line cut
		for ($i=0;$i<sizeof($characterTable);$i++)	
		{
			//finding the end point of each line
			$wordEnd = strpos($characterTable[$i], "\n");
			if ($wordEnd != NULL)
			{
				$thisLine = $thisLine.substr($characterTable[$i],0,$wordEnd);
				$newCharacterTable[$i]=substr($characterTable[$i],$wordEnd+1,strlen($characterTable[$i]));
			}
			else
			{
				$thisLine=$thisLine.str_repeat(" ", $key=array_search($characterTable[$i],$characterTable));
			}
				
		}
		//print an individual line each loop
		echo $thisLine,"\n";
		//call again with new array 
		checkTableLines($newCharacterTable);
	
}

//allowing for continuous input
function lineArtREPL($fontMap)
{
	while (true)
	{
		print("type in a word to turn it into line-art. to exit print-loop press ENTER\n");
		$printword = readline();
		if($printword=="")
			break;
		else
			printAsciiString($printword, $fontMap);
	}
}

$fontMap = getFontTable();
echo "welcome to the CPSC4100 Line Art Program!","\n";
while(true)
{
	echo "\n","Type 1 to enter the line-art loop!","\n";
    echo "Type 2 to enter the line-art editor!","\n";
    echo "Type 3 to save your current keybind setup and override the existing text file!","\n";
    echo "Press enter without input to exit!","\n";
	$user=readline();
	if($user=="1")
	{
		lineArtREPL($fontMap);
		echo "welcome to the CPSC4100 line art program!";
	}
	elseif($user=="2")
	{
		lineArtMaker($fontMap);
		echo "your art has been aded to the current lineart map. press 3 in the main menu to save your keybinding","\n";
		echo "welcome to the cpsc4100 line art program!","\n";	
	}
	elseif($user=="3")
	{
		saveLineArt($fontMap);
		echo "\n";
	}
	elseif($user=="")
	{
		break;
	}
	
}
?>
