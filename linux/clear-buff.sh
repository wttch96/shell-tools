begin=`free -m| awk '/内存/ {print $4}'`
if [ $begin -le 1000 ]; 
then
  begin=`free -m| awk '/内存/ {print $6}'`
  echo 1 > /proc/sys/vm/drop_caches
  echo 2 > /proc/sys/vm/drop_caches
  echo 3 > /proc/sys/vm/drop_caches
  end=`free -m| awk '/内存/ {print $6}'`
  result=`echo "scale=2; ($begin-$end)/1000.0" | bc`Mb
  su wttch -c 'notify-send 清理内存 清理内存成功:'$result
fi


