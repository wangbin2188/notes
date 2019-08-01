
#安装mongodb
创建mongodb数据文件的目录，data必须在根目录
mkdir /data/db
export LC_ALL=C
启动服务
./mongodb/bin/mongod
# 启动mongodb shell
./mongodb/bin/mongo


****************************************db操作****************************************
# 显示所有数据库列表
show dbs
# 连接到一个指定的数据库,若没有则直接创建
use dbname
# 删除数据库
db.dropDatabase()

****************************************collection操作****************************************
# 查看数据库中的所有集合
db.getCollectionNames() 
show collections
# 创建集合
db.createCollection("ios_group")
# 删除集合
db.userdetails.drop()

# 集合数据的条数
db.userdetails.count()
# 集合储存空间的大小
db.userdetails.storageSize()
# 创建一个集合
db.createCollection("collName", {size: 20, capped: 5, max: 100});
# 通过名称获取集合
db.getCollection("userdetails")
# 集合重命名
db.userInfo.renameCollection("users")
# 在集合中插入文档
db.userdetails.insert(document)
db.userdetails.insert({"user_id" : "user1","password" :"1a2b3c" ,"date_of_join" : "16/10/2010" ,"education" :"M.C.A.", "profession" : "CONSULTANT","interest" : "MUSIC","community_name" :["MODERN MUSIC", "CLASSICAL MUSIC","WESTERN MUSIC"],"community_moder_id" : ["MR. Alex","MR. Dang","MR Haris"],"community_members" : [700,200,1500],"friends_id" : ["kumar","harry","anand"],"ban_friends_id" :["Amir","Raja","mont"]});
db.userdetails.insert({"user_id" : "user2","password" :"11aa1a" ,"date_of_join" : "17/10/2009" ,"education" :"M.B.A." , "profession" : "MARKETING","interest" : "MUSIC","community_name" :["MODERN MUSIC", "CLASSICAL MUSIC","WESTERN MUSIC"],"community_moder_id" : ["MR. Roy","MR. Das","MR Doglus"],"community_members" : [500,300,1400],"friends_id" : ["pal","viki","john"],"ban_friends_id" :["jalan","monoj","evan"]});
db.userdetails.insert({"user_id" : "user3","password" :"b1c1d1" ,"date_of_join" : "16/10/2010" ,"education" :"M.C.A." , "profession" : "IT COR.","interest" : "ART","community_name" :["MODERN ART", "CLASSICAL ART","WESTERN ART"],"community_moder_id" : ["MR. Rifel","MR. Sarma","MR Bhatia"],"community_members" : [5000,2000,1500],"friends_id" : ["philip","anant","alan"],"ban_friends_id" :["Amir","Raja","mont"]});
db.userdetails.insert({"user_id" : "user4","password" :"abczyx" ,"date_of_join" : "17/8/2009" ,"education" :"M.B.B.S." , "profession" : "DOCTOR","interest" : "SPORTS","community_name" :["ATHELATIC", "GAMES FAN GYES","FAVOURIT GAMES"],"community_moder_id" : ["MR. Paul","MR. Das","MR Doglus"],"community_members" : [2500,2200,3500],"friends_id" : ["vinod","viki","john"],"ban_friends_id" :["jalan","monoj","evan"]});
****************************************document操作****************************************
# 新建文档
document=({"user_id" : "ABCDBWN","password" :"ABCDBWN"})
# 删除文档
db.userdetails.remove( { "user_id" : "testuser" } )
db.userdetails.remove({})

****************************************查询操作****************************************

# 查询、条件查询age>22
db.userdetails.find()
db.userdetails.find({"education":"M.C.A."})
db.userdetails.distinct('user_id')
db.testtable.find({age : {$gt : 22}})
# 查询指定列的内容+where条件
db.userdetails.find({}, {user_id: 1, education: 1});
db.userdetails.find({age: {$gt: 25}}, {user_id: 1, education: 1});
# 条件or
db.userInfo.find({$or: [{age: 22}, {age: 25}]});
# 按照age升序排列，-1=降序
db.userInfo.find().sort({age: 1});
# 查询5~10条数据
db.userInfo.find().limit(10).skip(5);
# 修改数据name
db.userdetails.update({age: 25}, {$set: {name: 'changeName'}}, false, true);

---------------------------
|     RDBMS |   MongoDB   |   
|     Table |   Collection|   myinfo.userdetails
|     Column|   Key       |   
|     Value |   Value     |   
|     Rows  |   Document  |   document
---------------------------





*****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
>>> import pymongo
>>> client = pymongo.MongoClient("localhost", 27017)
# 指定数据库
>>> db = client.test
>>> db.name
u'test'
for item in db.userdetails.find({'user_id':'user1'}):
	print item['education']
>>> db.my_collection
Collection(Database(MongoClient('localhost', 27017), u'test'), u'my_collection')
>>> db.my_collection.insert_one({"x": 10}).inserted_id
ObjectId('4aba15ebe23f6b53b0000000')
# 查询集合中的某一条数据
db.my_collection.find_one()
db.userdetails.find_one({'user_id':'user2'})
{u'x': 10, u'_id': ObjectId('4aba15ebe23f6b53b0000000')}
# 遍历查询结果数据
for item in db.my_collection.find():
	print(item["x"])

>>> db.my_collection.create_index("x")
u'x_1'
>>> for item in db.my_collection.find().sort("x", pymongo.ASCENDING):
...     print(item["x"])
...
8
10
11
>>> [item["x"] for item in db.my_collection.find().limit(2).skip(1)]
[8, 11]