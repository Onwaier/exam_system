# exam_system

## 项目描述

* 为老师提供录题（手动录题，通过**word或excel模板录题**），题目查看，组卷（章节选题，试卷选题），试卷查看，生成试卷功能。

* 为学生提供题目查看功能。 

## 数据库设计

* course表： 存储课程信息，有课程id，课程名称等字段
* knowledgepoint表：存储知识点信息，有课程id，章节id，知识点等字段
* paper表：存储试卷信息，有试卷id，试卷标题，课程id，试题集合等字段
* question表：存储试题信息，有试题id，题目主干，题型，选项，答案等字段
* 权限管理相关的表：sys_permission/sys_role/sys_role_permission/sys_user_role
* 用户管理相关的表：sys_user

## 功能展示

* 题目管理主界面

  ![image-20210831151219478](https://raw.githubusercontent.com/onwaiers/Picture/master/img/image-20210831151219478.png)

  * 手动录题

    ![image-20210831151527447](https://raw.githubusercontent.com/onwaiers/Picture/master/img/image-20210831151527447.png)

  * 批量录题

    ![image-20210831151606296](https://raw.githubusercontent.com/onwaiers/Picture/master/img/image-20210831151606296.png)

* 试题管理主界面

  ![image-20210831151652550](https://raw.githubusercontent.com/onwaiers/Picture/master/img/image-20210831151652550.png)

  * 创建试卷

    ![image-20210831151750700](https://raw.githubusercontent.com/onwaiers/Picture/master/img/image-20210831151750700.png)

  * 添加试题至试卷

    ![image-20210831151819455](https://raw.githubusercontent.com/onwaiers/Picture/master/img/image-20210831151819455.png)

  * 预览试卷

    ![image-20210831151911048](https://raw.githubusercontent.com/onwaiers/Picture/master/img/image-20210831151911048.png)

## 特别鸣谢

**[breezelj](https://github.com/breezelj)**和**[clover720](https://github.com/clover720)**


