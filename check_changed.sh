# Example of input file:
# URL,content_size,whatever_you_want...
# "http://example.com:80",1339,"Servicio desactivado","82.98.xxx.xx",200

new_file=$1
old_file=$2

while read -r url; do
	new_line=$(grep $url $new_file)
	old_line=$(grep $url $old_file)

	new_size=$(($(echo $new_line | cut -d',' -f2)))
	old_size=$(($(echo $old_line | cut -d',' -f2)))

	if [ $new_size -ne $old_size ]
	then
		difference=$(( $new_size - $old_size ))
		if [ ${difference#-} -gt 50 ] # here we can change the size difference
		then
			echo $url
		fi
	else
		echo $url
	fi
done