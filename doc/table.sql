DROP TABLE IF EXISTS mst_comp;
CREATE TABLE mst_comp(
        comp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '唯一自动ID',
        comp_name VARCHAR(128) DEFAULT '' COMMENT '企业名称',
        comp_logo VARCHAR(255) DEFAULT '' COMMENT '企业logo',
        comp_province INT DEFAULT 0 COMMENT '省份编号,编号全国各省编号固定   必填项目 与province表的provinceID对应',
        comp_city INT DEFAULT 0 COMMENT '城市编号,固定编号   必填项目* 与city表的cityID对应',
        comp_area INT DEFAULT 0 COMMENT '旗县编号，固定编号   必填项*  与area表areaID对应',
        comp_address VARCHAR(255) DEFAULT NULL COMMENT '详细地址',
        comp_zipcode VARCHAR(8) DEFAULT NULL COMMENT '邮政编码',
        comp_corporate VARCHAR(20) DEFAULT NULL COMMENT '法人',
        comp_tel VARCHAR(15) DEFAULT NULL COMMENT '企业电话',
        comp_comment VARCHAR(1024) DEFAULT NULL COMMENT '企业简介',
        comp_evaluate varchar(6) DEFAULT '' COMMENT '企业运行效果评估分数E满分100',
        comp_jingdu DOUBLE DEFAULT NULL COMMENT '经度 百度地图经纬度',
        comp_weidu DOUBLE DEFAULT NULL COMMENT '维度 百度地图经纬度',
        comp_del TINYINT DEFAULT 0 COMMENT '0:数据有效  1:数据无效(被逻辑删除了)',
        comp_upt_user_id INT DEFAULT 0 COMMENT '最后创建、修改、删除该条记录的用户ID，引用 mst_admin.admin_id',
        comp_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑日期',
        comp_crt_user_id INT DEFAULT 0 COMMENT '创建该条记录的用户ID，引用 mst_admin.admin_id',
        comp_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
        INDEX comp_id(comp_id) USING BTREE,
        INDEX comp_del(comp_del) USING BTREE,
        INDEX comp_province(comp_province) USING BTREE,
        INDEX comp_city(comp_city) USING BTREE,
        INDEX comp_area(comp_area) USING BTREE
) COMMENT '企业表';

DROP TABLE IF EXISTS mst_dept;
CREATE TABLE mst_dept(
        dept_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '唯一自动ID',
        dept_uuid VARCHAR(36) DEFAULT '' UNIQUE COMMENT '32位长uuid',
        dept_comp_id INT NOT NULL DEFAULT 0 COMMENT '企业ID',
        dept_name VARCHAR(128) DEFAULT '' COMMENT '部门名称',
        dept_father_id INT DEFAULT 0 COMMENT '父部门ID  0：顶层     >0：父部门的dept_id',
        dept_order INT DEFAULT 1 COMMENT '显示顺序 升序排序',
        dept_del TINYINT DEFAULT 0 COMMENT '0:数据有效  1:数据无效(被逻辑删除了)',
        dept_upt_user_id INT DEFAULT 0 COMMENT '最后创建、修改、删除该条记录的用户ID，引用 mst_user.user_id',
        dept_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑日期',
        dept_crt_user_id INT DEFAULT 0 COMMENT '创建该条记录的用户ID，引用 mst_user.user_id',
        dept_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
        INDEX dept_comp_id(dept_comp_id) USING BTREE,
        INDEX dept_father_id(dept_father_id) USING BTREE,
        INDEX dept_name(dept_name) USING BTREE
) COMMENT '部门表';
ALTER TABLE mst_dept ADD CONSTRAINT dept_comp_id_dept_name UNIQUE(dept_comp_id, dept_name);

DROP TABLE IF EXISTS mst_role;
CREATE TABLE mst_role(
        role_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '唯一自动ID',
        role_comp_id INT NOT NULL DEFAULT 0 COMMENT '企业ID',
        role_name VARCHAR(128) DEFAULT '' COMMENT '角色名称',
        role_permissions TEXT COMMENT 'view_prod|add_prod|edit_prod|del_prod 用竖线分割的多个权限名称, 如果==all 就是超级权限',
        role_del TINYINT DEFAULT 0 COMMENT '0:数据有效  1:数据无效(被逻辑删除了)',
        role_upt_user_id INT DEFAULT 0 COMMENT '最后创建、修改、删除该条记录的用户ID，引用 mst_user.user_id',
        role_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑日期',
        role_crt_user_id INT DEFAULT 0 COMMENT '创建该条记录的用户ID，引用 mst_user.user_id',
        role_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
        INDEX role_comp_id(role_comp_id) USING BTREE
) COMMENT '角色表';
ALTER TABLE mst_role ADD CONSTRAINT role_comp_id_role_name UNIQUE(role_comp_id, role_name);

DROP TABLE IF EXISTS mst_title;
CREATE TABLE mst_title(
        title_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '唯一自动ID',
        title_comp_id INT NOT NULL DEFAULT 0 COMMENT '企业ID',
        title_name VARCHAR(128) DEFAULT '' COMMENT '职务名称',
        title_del TINYINT DEFAULT 0 COMMENT '0:数据有效  1:数据无效(被逻辑删除了)',
        title_upt_user_id INT DEFAULT 0 COMMENT '最后创建、修改、删除该条记录的用户ID，引用 mst_user.user_id',
        title_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑日期',
        title_crt_user_id INT DEFAULT 0 COMMENT '创建该条记录的用户ID，引用 mst_user.user_id',
        title_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
        INDEX title_comp_id(title_comp_id) USING BTREE,
        INDEX title_name(title_name) USING BTREE
) COMMENT '职务表';
ALTER TABLE mst_title ADD CONSTRAINT title_comp_id_title_name UNIQUE(title_comp_id, title_name);

DROP TABLE IF EXISTS mst_user;
CREATE TABLE mst_user(
        user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '唯一自动ID',
        user_comp_id INT NOT NULL DEFAULT 0 COMMENT '企业ID',
        user_tel VARCHAR(11) DEFAULT '' COMMENT '手机号，全局唯一登陆依据',
        user_pass VARCHAR(64) DEFAULT '' COMMENT '密码，MD5加密',
        user_num VARCHAR(30) DEFAULT '' COMMENT '职工号',
        user_name VARCHAR(30) DEFAULT '' COMMENT '用户姓名',
        user_dept_id INT DEFAULT 0 COMMENT '部门ID，引用 mst_dept.dept_id',
        user_title_id INT DEFAULT 0 COMMENT '职务ID，引用 mst_title.title_id',
        user_role_id INT DEFAULT 0 COMMENT '角色ID，引用 mst_role.role_id',
        user_pic VARCHAR(255) DEFAULT '' COMMENT '头像图片名称，基地址不用保存',
        user_del TINYINT DEFAULT 0 COMMENT '0:数据有效  1:数据无效(被逻辑删除了)',
        user_upt_user_id INT DEFAULT 0 COMMENT '最后创建、修改、删除该条记录的用户ID，引用 mst_user.user_id',
        user_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑日期',
        user_crt_user_id INT DEFAULT 0 COMMENT '创建该条记录的用户ID，引用 mst_user.user_id',
        user_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
        INDEX user_comp_id(user_comp_id) USING BTREE,
        INDEX user_role_id(user_role_id) USING BTREE,
        INDEX user_title_id(user_title_id) USING BTREE,
        INDEX user_dept_id(user_dept_id) USING BTREE,
        INDEX user_num(user_num) USING BTREE
) COMMENT '用户表';


DROP TABLE IF EXISTS mst_turbines;
CREATE TABLE mst_turbines (
	turbine_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '唯一自动ID',
       turbine_comp_id INT NOT NULL DEFAULT 0 COMMENT '企业ID',
	turbine_num INT DEFAULT 0 COMMENT '风机编号',
	turbine_name VARCHAR(100) DEFAULT '' COMMENT '风机名称',
	turbine_location VARCHAR(100) DEFAULT '' COMMENT '风机位置',
	turbine_power DECIMAL(10, 2) DEFAULT 0 COMMENT '风机额定功率',
	turbine_manufacturer VARCHAR(100) DEFAULT '' COMMENT '风机来源地',
	turbine_del TINYINT DEFAULT 0 COMMENT '0:数据有效  1:数据无效(被逻辑删除了)',
	turbine_upt_user_id INT DEFAULT 0 COMMENT '最后创建、修改、删除该条记录的用户ID，引用 mst_user.user_id',
	turbine_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑日期',
	turbine_crt_user_id INT DEFAULT 0 COMMENT '创建该条记录的用户ID，引用 mst_user.user_id',
	turbine_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
        INDEX turbine_comp_id(turbine_comp_id) USING BTREE
) COMMENT '风机表';

DROP TABLE IF EXISTS history_data;
CREATE TABLE history_data (
	history_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '唯一自动ID',
       history_comp_id INT NOT NULL DEFAULT 0 COMMENT '企业ID',
	history_turbine_id INT NOT NULL DEFAULT 0 COMMENT '外键风机id',
	history_wind_speed DECIMAL(5, 2),
	history_power_output DECIMAL(10, 2),
	history_recorded_dt  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
	history_upt_user_id INT DEFAULT 0 COMMENT '最后创建、修改、删除该条记录的用户ID，引用 mst_user.user_id',
	history_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑日期',
	history_crt_user_id INT DEFAULT 0 COMMENT '创建该条记录的用户ID，引用 mst_user.user_id',
	history_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
	INDEX history_comp_id(history_comp_id) USING BTREE
) COMMENT '风机历史数据表';

DROP TABLE IF EXISTS prediction_data;
CREATE TABLE prediction_data (
	predict_id INT AUTO_INCREMENT PRIMARY KEY,
       predict_comp_id INT NOT NULL DEFAULT 0 COMMENT '企业ID',
	predict_turbine_id INT NOT NULL DEFAULT 0 COMMENT '外键风机id',
	predict_wind_speed DECIMAL(5, 2),
	predict_power_output DECIMAL(10, 2),
	predict_recorded_dt  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
	predict_upt_user_id INT DEFAULT 0 COMMENT '最后创建、修改、删除该条记录的用户ID，引用 mst_user.user_id',
	predict_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑日期',
	predict_crt_user_id INT DEFAULT 0 COMMENT '创建该条记录的用户ID，引用 mst_user.user_id',
	predict_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
	INDEX predict_comp_id(predict_comp_id) USING BTREE
) COMMENT '风机预测数据表';