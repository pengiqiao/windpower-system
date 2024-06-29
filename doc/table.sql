DROP TABLE IF EXISTS mst_comp;
CREATE TABLE mst_comp(
        comp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ψһ�Զ�ID',
        comp_name VARCHAR(128) DEFAULT '' COMMENT '��ҵ����',
        comp_logo VARCHAR(255) DEFAULT '' COMMENT '��ҵlogo',
        comp_province INT DEFAULT 0 COMMENT 'ʡ�ݱ��,���ȫ����ʡ��Ź̶�   ������Ŀ ��province���provinceID��Ӧ',
        comp_city INT DEFAULT 0 COMMENT '���б��,�̶����   ������Ŀ* ��city���cityID��Ӧ',
        comp_area INT DEFAULT 0 COMMENT '���ر�ţ��̶����   ������*  ��area��areaID��Ӧ',
        comp_address VARCHAR(255) DEFAULT NULL COMMENT '��ϸ��ַ',
        comp_zipcode VARCHAR(8) DEFAULT NULL COMMENT '��������',
        comp_corporate VARCHAR(20) DEFAULT NULL COMMENT '����',
        comp_tel VARCHAR(15) DEFAULT NULL COMMENT '��ҵ�绰',
        comp_comment VARCHAR(1024) DEFAULT NULL COMMENT '��ҵ���',
        comp_evaluate varchar(6) DEFAULT '' COMMENT '��ҵ����Ч����������E����100',
        comp_jingdu DOUBLE DEFAULT NULL COMMENT '���� �ٶȵ�ͼ��γ��',
        comp_weidu DOUBLE DEFAULT NULL COMMENT 'ά�� �ٶȵ�ͼ��γ��',
        comp_del TINYINT DEFAULT 0 COMMENT '0:������Ч  1:������Ч(���߼�ɾ����)',
        comp_upt_user_id INT DEFAULT 0 COMMENT '��󴴽����޸ġ�ɾ��������¼���û�ID������ mst_admin.admin_id',
        comp_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���༭����',
        comp_crt_user_id INT DEFAULT 0 COMMENT '����������¼���û�ID������ mst_admin.admin_id',
        comp_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
        INDEX comp_id(comp_id) USING BTREE,
        INDEX comp_del(comp_del) USING BTREE,
        INDEX comp_province(comp_province) USING BTREE,
        INDEX comp_city(comp_city) USING BTREE,
        INDEX comp_area(comp_area) USING BTREE
) COMMENT '��ҵ��';

DROP TABLE IF EXISTS mst_dept;
CREATE TABLE mst_dept(
        dept_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ψһ�Զ�ID',
        dept_uuid VARCHAR(36) DEFAULT '' UNIQUE COMMENT '32λ��uuid',
        dept_comp_id INT NOT NULL DEFAULT 0 COMMENT '��ҵID',
        dept_name VARCHAR(128) DEFAULT '' COMMENT '��������',
        dept_father_id INT DEFAULT 0 COMMENT '������ID  0������     >0�������ŵ�dept_id',
        dept_order INT DEFAULT 1 COMMENT '��ʾ˳�� ��������',
        dept_del TINYINT DEFAULT 0 COMMENT '0:������Ч  1:������Ч(���߼�ɾ����)',
        dept_upt_user_id INT DEFAULT 0 COMMENT '��󴴽����޸ġ�ɾ��������¼���û�ID������ mst_user.user_id',
        dept_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���༭����',
        dept_crt_user_id INT DEFAULT 0 COMMENT '����������¼���û�ID������ mst_user.user_id',
        dept_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
        INDEX dept_comp_id(dept_comp_id) USING BTREE,
        INDEX dept_father_id(dept_father_id) USING BTREE,
        INDEX dept_name(dept_name) USING BTREE
) COMMENT '���ű�';
ALTER TABLE mst_dept ADD CONSTRAINT dept_comp_id_dept_name UNIQUE(dept_comp_id, dept_name);

DROP TABLE IF EXISTS mst_role;
CREATE TABLE mst_role(
        role_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ψһ�Զ�ID',
        role_comp_id INT NOT NULL DEFAULT 0 COMMENT '��ҵID',
        role_name VARCHAR(128) DEFAULT '' COMMENT '��ɫ����',
        role_permissions TEXT COMMENT 'view_prod|add_prod|edit_prod|del_prod �����߷ָ�Ķ��Ȩ������, ���==all ���ǳ���Ȩ��',
        role_del TINYINT DEFAULT 0 COMMENT '0:������Ч  1:������Ч(���߼�ɾ����)',
        role_upt_user_id INT DEFAULT 0 COMMENT '��󴴽����޸ġ�ɾ��������¼���û�ID������ mst_user.user_id',
        role_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���༭����',
        role_crt_user_id INT DEFAULT 0 COMMENT '����������¼���û�ID������ mst_user.user_id',
        role_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
        INDEX role_comp_id(role_comp_id) USING BTREE
) COMMENT '��ɫ��';
ALTER TABLE mst_role ADD CONSTRAINT role_comp_id_role_name UNIQUE(role_comp_id, role_name);

DROP TABLE IF EXISTS mst_title;
CREATE TABLE mst_title(
        title_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ψһ�Զ�ID',
        title_comp_id INT NOT NULL DEFAULT 0 COMMENT '��ҵID',
        title_name VARCHAR(128) DEFAULT '' COMMENT 'ְ������',
        title_del TINYINT DEFAULT 0 COMMENT '0:������Ч  1:������Ч(���߼�ɾ����)',
        title_upt_user_id INT DEFAULT 0 COMMENT '��󴴽����޸ġ�ɾ��������¼���û�ID������ mst_user.user_id',
        title_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���༭����',
        title_crt_user_id INT DEFAULT 0 COMMENT '����������¼���û�ID������ mst_user.user_id',
        title_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
        INDEX title_comp_id(title_comp_id) USING BTREE,
        INDEX title_name(title_name) USING BTREE
) COMMENT 'ְ���';
ALTER TABLE mst_title ADD CONSTRAINT title_comp_id_title_name UNIQUE(title_comp_id, title_name);

DROP TABLE IF EXISTS mst_user;
CREATE TABLE mst_user(
        user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ψһ�Զ�ID',
        user_comp_id INT NOT NULL DEFAULT 0 COMMENT '��ҵID',
        user_tel VARCHAR(11) DEFAULT '' COMMENT '�ֻ��ţ�ȫ��Ψһ��½����',
        user_pass VARCHAR(64) DEFAULT '' COMMENT '���룬MD5����',
        user_num VARCHAR(30) DEFAULT '' COMMENT 'ְ����',
        user_name VARCHAR(30) DEFAULT '' COMMENT '�û�����',
        user_dept_id INT DEFAULT 0 COMMENT '����ID������ mst_dept.dept_id',
        user_title_id INT DEFAULT 0 COMMENT 'ְ��ID������ mst_title.title_id',
        user_role_id INT DEFAULT 0 COMMENT '��ɫID������ mst_role.role_id',
        user_pic VARCHAR(255) DEFAULT '' COMMENT 'ͷ��ͼƬ���ƣ�����ַ���ñ���',
        user_del TINYINT DEFAULT 0 COMMENT '0:������Ч  1:������Ч(���߼�ɾ����)',
        user_upt_user_id INT DEFAULT 0 COMMENT '��󴴽����޸ġ�ɾ��������¼���û�ID������ mst_user.user_id',
        user_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���༭����',
        user_crt_user_id INT DEFAULT 0 COMMENT '����������¼���û�ID������ mst_user.user_id',
        user_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
        INDEX user_comp_id(user_comp_id) USING BTREE,
        INDEX user_role_id(user_role_id) USING BTREE,
        INDEX user_title_id(user_title_id) USING BTREE,
        INDEX user_dept_id(user_dept_id) USING BTREE,
        INDEX user_num(user_num) USING BTREE
) COMMENT '�û���';


DROP TABLE IF EXISTS mst_turbines;
CREATE TABLE mst_turbines (
	turbine_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Ψһ�Զ�ID',
       turbine_comp_id INT NOT NULL DEFAULT 0 COMMENT '��ҵID',
	turbine_num INT DEFAULT 0 COMMENT '������',
	turbine_name VARCHAR(100) DEFAULT '' COMMENT '�������',
	turbine_location VARCHAR(100) DEFAULT '' COMMENT '���λ��',
	turbine_power DECIMAL(10, 2) DEFAULT 0 COMMENT '��������',
	turbine_manufacturer VARCHAR(100) DEFAULT '' COMMENT '�����Դ��',
	turbine_del TINYINT DEFAULT 0 COMMENT '0:������Ч  1:������Ч(���߼�ɾ����)',
	turbine_upt_user_id INT DEFAULT 0 COMMENT '��󴴽����޸ġ�ɾ��������¼���û�ID������ mst_user.user_id',
	turbine_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���༭����',
	turbine_crt_user_id INT DEFAULT 0 COMMENT '����������¼���û�ID������ mst_user.user_id',
	turbine_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
        INDEX turbine_comp_id(turbine_comp_id) USING BTREE
) COMMENT '�����';

DROP TABLE IF EXISTS history_data;
CREATE TABLE history_data (
	history_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Ψһ�Զ�ID',
       history_comp_id INT NOT NULL DEFAULT 0 COMMENT '��ҵID',
	history_turbine_id INT NOT NULL DEFAULT 0 COMMENT '������id',
	history_wind_speed DECIMAL(5, 2),
	history_power_output DECIMAL(10, 2),
	history_recorded_dt  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
	history_upt_user_id INT DEFAULT 0 COMMENT '��󴴽����޸ġ�ɾ��������¼���û�ID������ mst_user.user_id',
	history_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���༭����',
	history_crt_user_id INT DEFAULT 0 COMMENT '����������¼���û�ID������ mst_user.user_id',
	history_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
	INDEX history_comp_id(history_comp_id) USING BTREE
) COMMENT '�����ʷ���ݱ�';

DROP TABLE IF EXISTS prediction_data;
CREATE TABLE prediction_data (
	predict_id INT AUTO_INCREMENT PRIMARY KEY,
       predict_comp_id INT NOT NULL DEFAULT 0 COMMENT '��ҵID',
	predict_turbine_id INT NOT NULL DEFAULT 0 COMMENT '������id',
	predict_wind_speed DECIMAL(5, 2),
	predict_power_output DECIMAL(10, 2),
	predict_recorded_dt  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
	predict_upt_user_id INT DEFAULT 0 COMMENT '��󴴽����޸ġ�ɾ��������¼���û�ID������ mst_user.user_id',
	predict_upt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���༭����',
	predict_crt_user_id INT DEFAULT 0 COMMENT '����������¼���û�ID������ mst_user.user_id',
	predict_crt_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '��������',
	INDEX predict_comp_id(predict_comp_id) USING BTREE
) COMMENT '���Ԥ�����ݱ�';