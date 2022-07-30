# todo
bash todo !!

```bash
# 使用 git 将项目克隆到本地
git clone git@github.com:InvisibleFuture/todo.git

# 进入项目文件夹, 设置文件执行权限 777
cd todo
chmod 777 main.sh

# 将文件复制到命令目录, 以便直接使命令 todo
sudo cp ./main.sh /usr/bin/todo

# 此时已经可用 todo 命令, 默认会显示帮助提示
todo
```

```bash
# 列出所有任务(每天首次打开附带提示help)
todo

# 查看帮助信息
todo help

# 新增一条
todo add "这是内容"

# 删除一条(其中1是列表中的序号)
todo delete 1
```
