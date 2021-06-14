#!/bin/bash

# 注册到全局命令(临时)
# alias todo="sh ~/Desktop/automation/todo.sh"
# 注册到全局命令(永久)
# echo 'alias todo="sh ~/Desktop/automation/todo.sh"' >> ~/.bashrc
# source ~/.bashrc


# 正则检查文件中所有 TODO 的行
function search_todo() {
	grep "^.*#TODO:" $file
}

function ergodic() {
	for file in `ls $1`
	do
		if [ -d $1"/"$file ]
		then
			ergodic $1"/"$file
		else
			echo "$file"
			# 获取文件后缀, 仅检查支持的后缀类型
			search_todo $1"/"$file
		fi
	done
}

function show() {
	# 展示读取的列表
	# 取用状态/完成未完成
	# 按照序列操作
	if [ -d '~/.todo/' ]; then
		echo "todo init"
		mkdir ~/.todo/
		touch "~/.todo/main.md"
	fi
	loop=1
	cat ~/.todo/main.md | while read line
	do
		echo -e "\e[2m $loop) $line \e[0m"
		#echo -e “Default \e[39mDefault”
		#echo -e "\e[1;32m Green \e[0m"
		loop=`expr $loop + 1`
	done
	# 列出当前目录下排除git之后的所有可识别后缀的文件中的注释TODO
	# 选中TODO时使用工具打开并跳到指定行
	# echo -e "\e[1;32m Green \e[0m"

	# 打印指定目录的最后修改时间
	FILE_NAME='.'
	LAST_MODIFY_TIMESTAMP=`stat -c %Y $FILE_NAME`
	echo `date '+%Y-%m-%d %H:%M:%S' -d @$LAST_MODIFY_TIMESTAMP`

	# 扫描目录中支持的文件格式, 并排除 .gitignore 列举的目录
	ergodic "."
}

#TODO: 加入目录命令, 使之检查目录最后一次更改
#TODO: 如果目录中包含已加入的目录, 则合并
#TODO: 如果目录中包含 .gitignore 则排除其列举的文件
#TODO: 通过检查目录的最后更改状态, 避免大量文件的反复检查
#TODO: 每个超出记录时间后更新的文件, 都要被重新索引TODO
#TODO: 索引精确到行, 且按照各类文件支持不同格式的注释
#TODO: 可能存在编码格式问题
#TODO: 每次显示都从缓存, 如果时解压来的文件夹, 其时间并不被公信, 其不应该存在TODO

case $1 in
	"" | list)
		show
		;;
	add | create)
		if [ -d '~/.todo/' ]; then
			echo "todo init"
			mkdir ~/.todo/
		fi
		echo $2 >> ~/.todo/main.md
		show
		;;
	rm | del | remove | delete)
		for i in $*
		do
			case $i in
				[0-9]*)
					sed -i "${2}d" ~/.todo/main.md
					;;
			esac
		done
		show
		;;
	[0-9]*)
		sed -n "${1}p" ~/.todo/main.md
		;;
	*)
		cat <<-EOF
		**************************
		TODO version 0.1
		**************************
		1) Add
		2) Delete
		3) Copy
		4) Exit
		**************************
		EOF
		;;
esac





