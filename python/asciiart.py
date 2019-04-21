from itertools import islice

asciiW = open("asciiartW.txt", "r")
checkProg = True
checkEdit = False

while checkProg:
        print("Welcome to the CPSC4100 Line Art Program!")
        print("Type 1 to enter the line-art loop!")
        print("Type 2 to enter the line-art editor!")
        print("Type 3 to save your current keybind setup and overwrite the existing text file!")
        choice = input("")
        i = 0
        p = 0
        # asciiW = open("asciiartW.txt", "w")
        checkArt = None

        if choice == "1":
            checkArt = True
        elif choice == "2":
            with open("asciiartW.txt", "w") as myfile:
                boundLetter = input("Type in a letter to be bound to ART \n")
                myfile.write(boundLetter + "\n")
            checkEdit = True


        elif choice == "3":

            with open("asciiart.txt", "r") as infile:
                data = infile.read()
                data = data.replace(boundLetter, "LSLSLS")
            with open("asciiart.txt", "w") as outfile:
                outfile.write(data)

            print("Saving...")

            cho3 = open("asciiartW.txt", "r")
            datal = cho3.read()

            with open("asciiart.txt", "a") as cho3o:
                cho3o.write(datal)

            print("Done!")




        elif choice == '':
            checkProg = False
            break


        while checkArt: #loop for text to ascii
                userInput = input("Type in a word to turn into line-art. To exit print-loop press ENTER\n")
                lis = list(userInput)
                lenG = len(userInput)

                if userInput == '':
                    checkArt = False
                    break

                #asciif = open("asciiart.txt", "r")
                try:
                    with open('asciiart.txt', 'r') as f:
                        # Printed Characters HEIGHT loop
                        for printLine in range(8):
                            i=0
                            lineStr = ''
                            # Word Length loop
                            while i < lenG:
                                f = open("asciiart.txt", "r")
                                # File-read loop

                                for line in f:
                                    if line == lis[i]+'\n':
                                        lineStr = (lineStr + islice(f, printLine, printLine+1).__next__()).replace('\n','')

                                        #lineStr = (lineStr + islice(f, printLine, printLine+1).__next__())
                                        i+=1
                                        #Leave file-read loop
                                        break
                                    elif " " == lis[i]:
                                        lineStr = lineStr + "   "
                                        i+=1
                                        #Leave file-read loop
                                        break

                            print(lineStr)
                except StopIteration:
                    print(" ")





                    # str2 = str.partition("@")[0] # prints first part without @
                    # print(str2)
                    #  asciiW.write(str.rstrip('\n')) #trying to write to new txt file next to each other
        while checkEdit:
            print("Binding " + boundLetter + " to given art. Create your art here! \n")

            while p < 8:
                   w = open("asciiartW.txt", "a")
                   newArt = input('')
                   p+=1
                  # print(p)
                   w.write(newArt)
                   w.write("\n")

            print("Your art: \n")
            print(asciiW.read())
            checkEdit = False

            break







