#Cu melt
#模型级别参数
units	metal
boundary		p p p
atom_style	atomic #对金属不含键信息
timestep		0.001 #1fs 1飞秒
neighbor		2.0 bin #在力的阶段半径外面 扩展了2.0Am
neigh_modify	every 1 delay 0


#建模
lattice		fcc 3.61
region		box block 0 5 0 5 0 5 #默认晶格单位 x y z三个方向的最小最大值 5个晶格常数 如果写成050505 units box则单位为Am 尺寸5Am
create_box	1 box #盒子里面包含1种原子
create_atoms	1 box #盒子里面填充原子 原子类型为1 即第一种类型

#看到模拟结果 热力学信息输出 体系输出
thermo		100 #100步输出一次
thermo_style	custom step temp pe ke  #自定义输出 包括步数 温度 势能 动能

#设置势函数 也就是力场
pair_style		eam
pair_coeff		* * Cu_u3.eam

#温度初始化
velocity 		all create 300 89895 #所有原子300k 随机种子89895 每个原子速度不一样的 随便写一个值

#能量最小化 省略

#熔化melt
dump		1 all atom 1000 melt.xyz #保存原子状态 1是dump编号 所有原子 原子类型 1000步输出一次 输出到哪个文件中
fix		1 all nvt temp 300 2000 0.01 #系综编号1 对所有原子施加nvt控温 原子个数体积不变 起始温度300 结束温度2000 温度阻尼系数一般是步长x100
run		10000 #运行1万步 相当于10ps 升温速率1700k/10ps=170k/ps



