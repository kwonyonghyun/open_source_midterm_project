    echo ----------------------------------
    echo -e "User Name: Kwon Yong Hyun\nStudent Number: 12223695\n [Menu] \n1. Get the data of the movie identified by a specific 'movie id' from 'u.item'\n2. Get the data of action genre movies from 'u.item'\n3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'\n4. Delete the 'IMDb URL' from 'u.item'\n5. Get the data about users from 'u.user'\n6. Modify the format of 'release date' in 'u.item'\n7. Get the data of movies rated by a specific 'user id' from 'u.data'\n8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'\n9. Exit\n-----------------------------------"
while true; do
    read -p "Enter your choice [1-9]: " choice
echo 
    case $choice in
        1)
            read -p "Please enter 'movie id'(1~1682): " userInput
            echo
            awk "NR == $userInput" $1
            echo
            ;;
        2)
    read -p "Do you want to get the data of 'action' genre movies from 'u.item? (y/n): " userInput
    echo
    if [ "$userInput" == "n" ]; then
        continue
    elif [ "$userInput" == "y" ]; then
        awk -F'|' '$7 == 1 {print $1, $2}' $1 | head -10
    fi
    echo
    ;;

        3)
            read -p "Please enter the 'movie id'(1~1682): " userInput
echo
            averageRating=$(awk -v movieId="$userInput" -F "	" '$2 == movieId { totalRating += $3; count++ } END { if (count > 0) print totalRating / count; else print "No ratings found for movie with ID " movieId; }' $2)

            echo "average rating of $userInput : $averageRating"
            echo
            ;;
        4)
read -p "Do you want to delete the 'IMDb URL' from 'u.item'?(y/n): " userInput
echo
if [ "$userInput" == "y" ]; then
    sed 's/|http:\/\/us.imdb.com[^|]*//g' $1 | head -10
else
    continue
fi
echo
            ;;
        5)
  read -p "Do you want to get the data about users from 'u.user'?(y/n): " userInput
  echo
if [ "$userInput" == "y" ]; then
    
     
    head -10 $3 | sed -n 's/^\([0-9]*\)|\([0-9]*\)|\([MF]\)|\([^|]*\)|\([0-9]*\)$/user \1 is \2 years old \3 \4/p' | sed 's/M/male/;s/F/female/'
fi
        
           
echo

            ;;
        6)
        read -p "Do you want to Modify the format of 'release data' in 'u.item'?(y/n): " userInput
echo
        if [ "$userInput" == "y" ]; then
           tail -10 $1 | sed -E -e 's/-Jan-/-01-/g' -e 's/-Feb-/-02-/g' -e 's/-Mar-/-03-/g' -e 's/-Apr-/-04-/g' \
           -e 's/-May-/-05-/g' -e 's/-Jun-/-06-/g' -e 's/-Jul-/-07-/g' -e 's/-Aug-/-08-/g' -e 's/-Sep-/-09-/g' \
           -e 's/-Oct-/-10-/g' -e 's/-Nov-/-11-/g' -e 's/-Dec-/-12-/g' | sed -E 's/([0-9]{2})-([0-9]{2})-([0-9]{4})/\3\2\1/'
        fi
        
echo

            ;;
        7)






read -p "Please enter the 'user id' (1~943): " user_id

echo
movie_ids=$(awk -v user_id="$user_id" -F'\t' '$1 == user_id {print $2}' $2 | sort -u)


sorted_movie_ids=$(echo "$movie_ids" | sort -n | tr '\n' '|' | sed 's/|$//')


echo "Movie IDs rated by user $user_id:"
echo "$sorted_movie_ids"
echo ""


echo "Top 10 movies rated by user $user_id:"
count=0
while IFS="|" read -ra movie_id_array; do
    for movie_id in "${movie_id_array[@]}"; do
        movie_title=$(awk -v movie_id="$movie_id" -F'|' '$1 == movie_id {print $2}' $1)
        echo "$movie_id | $movie_title"
        count=$((count+1))
        if [ $count -eq 10 ]; then
            break 2
        fi
    done
done <<< "$sorted_movie_ids"


echo
            ;;
        8)


read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n): " userInput
echo

if [ "$userInput" == "y" ]; then
   programmer_ids=$(awk -F'|' '$2 >= 20 && $2 < 30 && $4 == "programmer" {print $1}' $3)


   for id in $programmer_ids; do
       awk -v id="$id" -F'\t' '$1 == id {ratings[$2] += $3; count[$2]++} 
       END {
           for (movie in ratings) 
               if (count[movie] > 0) 
                   printf "%d %.6f\n", movie, ratings[movie]/count[movie]
       }' $2
   done | awk '{
       total[$1] += $2; counts[$1]++
   } END {
       for (movie in total) {
           if (counts[movie] > 0) {
               avg = total[movie]/counts[movie];
               printf "%d %.6f\n", movie, avg
           }
       }
   }' | sed 's/\.\?0\+$//' | sort -k1,1n
fi

echo

            ;;
        9)
            echo "Bye!"
            break
            ;;
    esac
done



