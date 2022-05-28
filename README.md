# [bash.apifork.com](https://bash.apifork.com/)

## Start

apifork implementation in project

```bash
curl -O https://raw.githubusercontent.com/apifork/bash/main/apifork.sh
echo "apifork.txt" > ".apifork"
echo "" > "apifork.txt"
```

### install

```bash
./apifork.sh install
```
OR

```bash
./apifork.sh
```

### update

```bash
./apifork.sh update
```


### remove

```bash
./apifork.sh remove
```



## Config project file

The config file: **.apifork** can be another, e.g. **projects.txt**

Just change the first line in  **.apifork** on **projects.txt**
```bash
projects.txt
```

Old version was working in separated files:

#./apifork/${CMD}.sh

## TODO:

apipackage 
https://www.apipackage.com/