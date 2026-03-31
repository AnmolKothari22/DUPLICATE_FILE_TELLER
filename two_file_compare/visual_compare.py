
import sys
import os 

t=0
for file_path in sys.argv:
    if(t==0):
        t=t+1
        continue

    temp=""
    with open(file_path,'r',encoding="utf-8") as file:
        for line in file:
            for word in line.split():
                temp=temp+word+" "

    filename="tempfile"+str(t)+".txt"
    directoryname="./tempfolder"
    
    name= os.path.join(directoryname , filename)

    with open(name,'w',encoding="utf-8") as file:
        file.write(temp)
    t=t+1
    



