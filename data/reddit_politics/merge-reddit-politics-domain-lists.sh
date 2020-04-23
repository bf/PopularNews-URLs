#!/bin/bash

for file in $(ls *.csv); do
	echo $file;
	wc -l $file;

	header=$(head -n 1 $file);
	echo $header;

	IFS="	" read -r -a array <<< "$header";
	for index in "${!array[@]}"; do
		echo "item: $index ${array[index]}";
		if [ "${array[index]}" = "Website" ] || [ "${array[index]}" = "URL" ]; then
			echo "URL found in column $index";
			break;
		fi;
	done;

	tail -n +2 $file | cut -f $((index+1)) | cut -d '/' -f 1 | sort | uniq | awk 'NF' > "$file.domains.txt";
done

# merge all domain files into one
cat *.domains.txt | sort | uniq > ../../output/temp/reddit-politics.domains.txt
