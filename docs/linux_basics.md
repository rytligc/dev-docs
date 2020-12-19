# Linux Basics

## Most basic commands

shell type: ```echo $SHELL```  
directory tree: ```mkdir -p dir1/dir2/dir3```  
remove directory tree: ```rm -r dir1/dir2/dir3```  
copy tree: ```cp -r dir1/dir2/dir3 dirA/dirB/dirC```  
find file: ``find . -name "foo*"`` 

## Vi editor

**Two modes: command & insert mode**  
Enter file from terminal: ```vi file.txt```  
Be in Insert mode - type lowercase ```"i"```  
Escape insert mode: ```esc```  
Move around with:  

```bash
arrow keys or kjhl # k (line up), j (line down), h (curser left), l (curser right)
```

Delete character with: ```x```  
Delete entire line: ```dd```  
Copy: ```yy```  
Paste: ```p```  
Scroll up: ```ctrl+u```
Scroll down: ```ctrl+d```  
go to cmd prompt: ```: (colon)```  
write to file: ```:w (colon+w); optionally specify filename: ":w filename"```  
Discard: ```:q```  
Write & quit : ```:wq```  
Find: ```/``` (slash). E.g. finding the word "of"... /of
Move curser to occurrences: ```n```  

## User accounts

logged in user: ```whoami```  
user id (UID), group id (GID), groups: ```id```  
switch user (e.g. su cliff): ```su```  
ssh with a different user : ```ssh username@192.168.1.2```  
root user : global admin..  
grant user root permissions in ```/etc/sudoers file```  

## Download files

curl : ```curl https://www.domain.com/some-file.txt -O``` (-O to save to file, else it will just print file on screen)  
wget : ```wget https://www.domain.com/some-file.txt -O fileName.txt```  

## OS version

```ls /etc/*release*```  
```cat /etc/*release*```  
