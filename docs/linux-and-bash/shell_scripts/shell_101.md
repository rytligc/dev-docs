# Introduction to Shell Scripts

The following contains the very basics of shell scripts!

## Shell scripts as commands

While shell scripts usually have `.sh` appended to them, we can export the shell script to the PATH to commands and use the terminal to fire them. When doing this, we do not want the file to end in `.sh` but rather just be a file with no ending

```bash
#shellscriptfile
mkdir somedir
```

```bash
#terminal
export PATH=$PATH:/Documents/shellscriptfile

# See where a command is located from
which shellscriptfile
```

## Adding text to file using echo & cat

Create a script named create-and-launch-rocket at the path /home/bob and add the below commands to it.

mkdir lunar-mission
rocket-add lunar-mission
rocket-start-power lunar-mission
rocket-internal-power lunar-mission
rocket-start-sequence lunar-mission
rocket-start-engine lunar-mission
rocket-lift-off lunar-mission
rocket-status lunar-mission

```bash
#echo "content" > file
#echo "addmorecontent" >> ExistingFile
echo "mkdir lunar-mission" > create-and-launch-rocket
echo "rocket-add lunar-mission" >> create-and-launch-rocket

# using cat
# existing file
cat >> /path/to/existingFile.text<< EOF
some text line 1
some text line 2
some text line 3
EOF

# new file
cat > /path/to/newFile.text<< EOF
some text line 1
some text line 2
some text line 3
EOF
```

Create a shell script in the home directory called create-directory-structure.sh. The script should do the following tasks:

1. Create the following directories under /home/bob/countries - USA, UK, India
2. Create a file under each directory by the name capital.txt
3. Add the capital cities name in the file - Washington, D.C, London, New Delhi
4. Print uptime of the system

```bash
mkdir countries
cd countries
mkdir USA India UK
echo "Washington, D.C" > USA/capital.txt
echo "London" > UK/capital.txt
echo "New Delhi" > India/capital.txt
uptime
```
