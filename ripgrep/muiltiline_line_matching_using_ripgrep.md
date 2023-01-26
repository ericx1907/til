# Multiline matching using ripgrep(rg)

```bash
cat text1.txt | (rg -U "(?s)\-\-\s8\.0.*?^$" ; echo ) | tee -a text2.txt 
```

The `-U` is equivalent to `--multiline` which enables multiline mode. The `(?s)` at the beginning of the regular experession is the dot all modifier.
It is equavilent to `--multiline-dotall` so `.` matches `\n` as well. The `?` means lazy match which will match as few times as possible.

In summary, the above code will match a piece of text in `text1.txt` starting with "-- 8.0" and end with first a empty line (\n) and append the result in stdout to the end of text2.txt.
