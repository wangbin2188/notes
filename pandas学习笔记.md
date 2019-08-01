pandas学习笔记

import pandas as pd
import numpy as np 
# 将数据读入dataframe,指定列标题、指定分割符号
df=pd.read_table('C:\Users\wangbin10\Desktop\jhinfo.txt',names=['dvid','cid','dt','atimes'],delimiter='\t')
groupd=df.groupby('cid')['atimes']
groupd.mean().to_csv('E:\log\channel_add\group10.csv',index=True)
df2=df[df['cid'].isin(['c147','c148','c149','c157','c158','c163','c164','c165','c166','c167','c170','c171','c180','c181','c182','c183','c184','c200','c201'])]

df2['atimes'].mean()
# 读写excel文件,文件路径前必须加r
df3=pd.read_excel(r'E:\log\token0722.xlsx','Sheet1')
df3=pd.to_excel(r'E:\log\token0722v1.xlsx')
df.head()
df.tail()
df.index
df.columns
df.values
df.describe()
df.T
# 按行序号或列序号进行排序
df.sort_index(axis=1,ascending=false)
# 按值排序
df.sort(columns='dt')
data_sorted = data.sort_values(['ApplicantIncome','CoapplicantIncome'], ascending=False) 
# 选择或筛选
# 切片筛选
# 求两个数据的交集
df=pd.merge(df1,df2,on ='dvid')

df[]
df['A']
df[0:3]
# 强制类型转换
data[row['feature']]=data[row['feature']].astype(np.float)
# 标签筛选
df.loc['20160101':'20160131',['dt','atimes']]
# 位置筛选
df.iloc[3:5,1:2]
df.iloc[[1,2,5],[0,2]
df.iat[1,1]
# 布尔索引
df[df['atimes']>1]
df3=df2[df2['E'].isin(['two','four'])]
#赋值
df.at[dates[0],'A'] = 0
df.iat[0,1] = 0
# 对列去重
df.drop_duplicates()
# 缺省值处理
# 删掉任意有缺省值的行
df1.dropna(how='any')
# 填充缺失值
df1.fillna(value=5)
# 将一行增加到df
df.append()
# 按行链接各部分组成新的dataframe
dfs1=pd.concat([df1,df2,df3,df4,df5])
# 按列合并数据集
pd.merge()
df4=pd.merge(df2,df3,left_on=['dvid'],right_on=['divice_id'],how='left')
# 转换数据结构，将数据改变成记录式
stacked = df2.stack()
# 将记录数据改成行列式
stacked.unstack()
# 支持有序分类数据类型Categoricals
df["grade"].cat.categories = ["very good", "good", "very bad"]
# 赋值
df.ix[1:3,['B','C']] = 1.0
f=lambda x:x[:7]
# 新增一列月份
df['month']=df['dt'].apply(f)
# 新增一列客户端
df['platform']=np.where(df['dvid'].str.len()>=32,'IOS','Android')
# 按月份和cid进行分组，计算均值
groupd=df['atimes'].groupby([df['month'],df['cid']])
# groupby 的其他方式,.count(),sum(),prod(),mean(),min(),max(),std(),var(),first(),last(),describe()也可以自定义函数
groupd=df.groupby('cid')['atimes']
# 将结果数据输出到Csv文件，不显示index
groupd.mean().to_csv('E:\log\channel_add\group08.csv',index=True)
# 若要观察多个指标，可使用agg传入
groupd.agg(['sum','count','mean'])
# 也可以通过元组方式对不同字段进行不同方式聚合
groupd.agg([('dvid','sum'),('atimes','count')])
# 若对多个列进行多种方式聚合，可以使用下列方式
functions=['sum','count','mean']
groupd['dt','cid'].agg(functions)

# 删掉某一行，按照index，默认是在行上删除,删除列需要指定轴
df.drop(index)
df.drop('dvid',axis=1)
# dataframe可以实现切片操作，选取前十行，或选取某一列
df[:10]
df['cid']
# 调用value_counts函数可以方便对任意列进行计数统计,默认按照降序排列
tz_counts=df['cid'].value_counts()
tz_counts[:10]
# 利用where进行生成新字段
os=np.where(df['dt'].str.startswith('2016-05'),'2016-05','2016-06')
# 复杂筛选
data.loc[(data["Gender"]=="Female") & (data["Education"]=="Not Graduate") & (data["Loan_Status"]=="Y"), ["Gender","Education","Loan_Status"]]

# 数据透视表
pv_table=pd.pivot_table(df,index=['cid'],columns=['month'],values=['atimes'],aggfunc=[np.mean])
# 交叉表
cross_table=pd.crosstab(df['cid'],df['month'])
# 截取不需要的字符串
df['act2']=df['act1'].str.rstrip('_ios')
# 若——c1包含news,则返回T，否则F
df['news']=np.where(df['_c1'].str.find('\"news\"')==-1,'F','T')
df['tab']=np.where(df['_c1'].str.find('\"tab\"')==-1,'F','T')
df['mediannews']=np.where(df['_c1'].str.find('\"mediannews\"')==-1,'F','T')
df['video']=np.where(df['_c1'].str.find('\"video\"')==-1,'F','T')
df['album']=np.where(df['_c1'].str.find('\"album\"')==-1,'F','T')
df['toutiaoapi']=np.where(df['_c1'].str.find('\"toutiaoapi\"')==-1,'F','T')
df['push']=np.where(df['_c1'].str.find('\"push\"')==-1,'F','T')
df['cheyou']=np.where(df['_c1'].str.find('\"cheyou\"')==-1,'F','T')
df['ycnews']=np.where(df['_c1'].str.find('\"ycnews\"')==-1,'F','T')
df['schema']=np.where(df['_c1'].str.find('\"schema\"')==-1,'F','T')

def split_new(str):
	if str.find('shoucang')!=-1:
		return 'shouchang'
	elif str.find('keywordlinks')!=-1:
		return 'keyword_click'
	elif str.find('guanzhu')!=-1:
		return 'guanzhu'
	elif str.find('relatednews')!=-1:
		return 'relatednews'
	elif str.find('nightmode')!=-1:
		return 'nightmode'
	elif str.find('car')!=-1:
		return 'car'
	elif str.find('dange')!=-1:
		return 'shequ_homepage'
	elif str.find('tiche')!=-1 or str.find('fabiao')!=-1:
		return 'fatie_click'
	else :
		return 'share'
		
# 输出到TXT文件，不包含index
df.to_csv('E:\log\lost.txt',index=False)
# 渠道质量sql
 df01.ix[1,['_c3']]
# 渠道新增的sql,查询后导入文件并下载
INSERT OVERWRITE DIRECTORY '/user/wangbin/new_data'
select cha,dvid,min(etl_dt) as min_dt,collect_set(etl_dt),collect_set(na) from t2pdm_data.t05_yicheapp_startup_log
where etl_dt between '2016-11-01' and '2016-12-07' and cha in ('c16','c147','c148','c149','c157','c158','c163','c164','c165','c166','c167','c170','c171','c180','c181','c182','c183','c184','c186','c32','c11','c9','c8','c37','c53','c131','c113','c7')
group by cha,dvid 
order by min_dt;
# str和datetime的相互转换
cday = datetime.strptime('2015-6-1 18:19:59', '%Y-%m-%d %H:%M:%S')
start_date.strftime('%Y-%m-%d')
now + timedelta(days=2, hours=12)
item="['2016-08-01','2016-08-03','2016-08-05','2016-08-06','2016-08-07','2016-08-08','2016-08-09','2016-08-10']"
# 自定义函数统计新激活后的活跃次数
def date_change(item):
	item=eval(item)
	start_date=min(item)
	end_date=datetime.strptime(start_date,'%Y-%m-%d')+ timedelta(days=7)
	new_list=list(filter(lambda x:x<=end_date.strftime('%Y-%m-%d'),item))
	return len(new_list)-1
	
def date_change(item):
	start_date=min(item)
	end_date=datetime.strptime(start_date,'%Y-%m-%d')+ timedelta(days=7)
	new_list=list(filter(lambda x:x<=end_date.strftime('%Y-%m-%d'),item))
	return len(new_list)-1
# 自定义函数判断是否当月新激活	
def na_change(item):
	return 'false' in item

# 设置分隔符
df=pd.read_csv(r'E:\log\channel_add\channel_add11.txt',names=['cha','dvid','dt','act','isna'],delimiter='\001')
# 替换hive特殊符号
df['act']=df['act'].str.replace('\002',',')
# 筛选新激活用户
df['is_new']=np.where(df['isna'].str.find('false')==-1,'F','T')
df2=df[df['is_new']=='T']

# 字符串分割转换为列表
df2['act']=df2['act'].str.split(',')
df2['actimes']=df2['act'].apply(date_change)		
groupd=df2.groupby('cha')['actimes']
# Android精准
df3=df2[df2['cha'].isin(['c147','c148','c149','c157','c158','c163','c164','c165','c166','c167','c170','c171','c180','c181','c182','c183','c184'])]
df3['actimes'].mean()