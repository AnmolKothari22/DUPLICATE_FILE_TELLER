
import sys
import os 

def namer(pat):
    tem=""
    for i in  range(len(pat)):
        if(pat[i]=="/"):
            tem=tem+":"
        else:
            tem=tem+pat[i]

    return tem


def file_normaliser(file_path):
    temp=""
    with open(file_path,'r',encoding="utf-8") as file:
        for line in file:
            for word in line.split():
                temp=temp+word+" "

    filename=namer(file_path)+".txt"
   # print(filename)
    directoryname="./two_file_compare/tempfolder"
    
    name= os.path.join(directoryname , filename)

    with open(name,'w',encoding="utf-8") as file:
        file.write(temp)


t=0
for file_path in sys.argv:
    if(t==0):
        t=t+1
        continue
   
    if(os.path.isdir(file_path)):
      
        with os.scandir(file_path) as dir_path:
            for f_path in dir_path:
               # print(f_path.name)
                if(f_path.is_file()):
                    file_normaliser(f_path.path)
    else:
        file_normaliser(file_path)
    t=t+1
    



