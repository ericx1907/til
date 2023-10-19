Bash ifself is capable of manipulating files. There is no need to write a seperate c/c++ program that uses iostream.h. The following code example shows how to write certain patterns to a binary file. 

```c
num_of_expected_args=2
if [ $# != $num_of_expected_args ]
then
    echo "please supply the following arguments:"
    echo "\$1 - the hardware revision number that will be insterted to the bitstream file"
    echo "\$2 - the path to the bitstream file"
    exit
fi
oldfn="$2"
suff=bin
#  deletes the shortest match of .$suff (.bin) from back of $oldfn
newfn="${oldfn%.$suff}_withHeader.tb2"
< /dev/zero head -c 4 | tr "\000" "\\$1" > $newfn 
< /dev/zero head -c 65532 | tr "\000" "\377" >> $newfn 
cat $oldfn >> $newfn
```

The `${oldfn%.$suff}` will delete `.$suff` from the string represented by variable `oldfn`.

The `< /dev/zero head -c 4` is equivalent to `head -c 4 < /dev/zero`, which is to read null characters from the special file and pass them to the **head** program. Then the **head** program will print first 4 null chars to stdout and it will be pipelined to the **tr** program. The *tr* program will translate the null character into a specified number (in octal) then redirect to a file whose name is represented by `newfn`.

The `>>` redirect and append stdout to file `$newfn`.
