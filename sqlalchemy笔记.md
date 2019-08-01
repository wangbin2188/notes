from sqlalchemy import Column, String, create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class User(Base):

	__tablename__ = 'user'

	id = Column(String(20), primary_key=True)
	name = Column(String(20))


engine = create_engine('mysql://dbuser:dbpw@dbip:3306/dbname')
DBSession = sessionmaker(bind=engine)


session = DBSession()
new_user = User(id='5', name='Bob')
session.add(new_user)
session.commit()
session.close()
# create table
# Base.metadata.create_all(engine)
# Batch insert
# DBSession.bulk_save_objects([Customer(name="NAME " + str(i)) for i in xrange(min(10000, n1))])  
# DBSession.bulk_insert_mappings(Customer,[dict(name="NAME " + str(i)) for i in xrange(min(10000, n1))]) 
session.add_all([User,User,User...])  

几种常见sqlalchemy查询：
#简单查询    
print(session.query(User).all())
print(session.query(User.name, User.fullname).all())    
print(session.query(User, User.name).all())        

#带条件查询    
print(session.query(User).filter_by(name='user1').all())    
print(session.query(User).filter(User.name == "user").all())    
print(session.query(User).filter(User.name.like("user%")).all())      
  
#多条件查询    
print(session.query(User).filter(and_(User.name.like("user%"), User.fullname.like("first%"))).all())    
print(session.query(User).filter(or_(User.name.like("user%"), User.password != None)).all())   
print(session.query(User).filter(User.id.in_((1, 2))).all())      

#sql过滤    
print(session.query(User).filter("id>:id").params(id=1).all())        

#关联查询     
print(session.query(User, Address).filter(User.id == Address.user_id).all())    
print(session.query(User).join(User.addresses).all())    
print(session.query(User).outerjoin(User.addresses).all())        

#聚合查询    
print(session.query(User.name, func.count('*').label("user_count")).group_by(User.name).all())    
print(session.query(User.name, func.sum(User.id).label("user_id_sum")).group_by(User.name).all())        

#子查询    
stmt = session.query(Address.user_id, func.count('*').label("address_count")).group_by(Address.user_id).subquery()    
print(session.query(User, stmt.c.address_count).outerjoin((stmt, User.id == stmt.c.user_id)).order_by(User.id).all())     
   
#exists    
print(session.query(User).filter(exists().where(Address.user_id == User.id)))    
print(session.query(User).filter(User.addresses.any()))

# 限制返回字段查询
person = session.query(Person.name, Person.created_at,Person.updated_at).filter_by(name="zhongwei").order_by(Person.created_at).first()

# 记录总数查询：
from sqlalchemy import func


# count User records, without
# using a subquery.
session.query(func.count(User.id))


# return count of user "id" grouped
# by "name"
session.query(func.count(User.id)).group_by(User.name)


from sqlalchemy import distinct
# count distinct "name" values
session.query(func.count(distinct(User.name)))

from sqlalchemy import func, or_, not_

user = User(name='a')
session.add(user)
user = User(name='b')
session.add(user)
user = User(name='a')
session.add(user)
user = User()
session.add(user)
session.commit()
query = session.query(User)
print query # 显示SQL 语句
print query.statement # 同上
for user in query: # 遍历时查询
    print user.name
print query.all() # 返回的是一个类似列表的对象
print query.first().name # 记录不存在时，first() 会返回 None
# print query.one().name # 不存在，或有多行记录时会抛出异常
print query.filter(User.id == 2).first().name
print query.get(2).name # 以主键获取，等效于上句
print query.filter('id = 2').first().name # 支持字符串
query2 = session.query(User.name)
print query2.all() # 每行是个元组
print query2.limit(1).all() # 最多返回 1 条记录
print query2.offset(1).all() # 从第 2 条记录开始返回
print query2.order_by(User.name).all()
print query2.order_by('name').all()
print query2.order_by(User.name.desc()).all()
print query2.order_by('name desc').all()
print session.query(User.id).order_by(User.name.desc(), User.id).all()
print query2.filter(User.id == 1).scalar() # 如果有记录，返回第一条记录的第一个元素
print session.query('id').select_from(User).filter('id = 1').scalar()
print query2.filter(User.id > 1, User.name != 'a').scalar() # and
query3 = query2.filter(User.id > 1) # 多次拼接的 filter 也是 and
query3 = query3.filter(User.name != 'a')
print query3.scalar()
print query2.filter(or_(User.id == 1, User.id == 2)).all() # or
print query2.filter(User.id.in_((1, 2))).all() # in
query4 = session.query(User.id)
print query4.filter(User.name == None).scalar()
print query4.filter('name is null').scalar()
print query4.filter(not_(User.name == None)).all() # not
print query4.filter(User.name != None).all()
print query4.count()
print session.query(func.count('*')).select_from(User).scalar()
print session.query(func.count('1')).select_from(User).scalar()
print session.query(func.count(User.id)).scalar()
print session.query(func.count('*')).filter(User.id > 0).scalar() # filter() 中包含 User，因此不需要指定表
print session.query(func.count('*')).filter(User.name == 'a').limit(1).scalar() == 1 # 可以用 limit() 限制 count() 的返回数
print session.query(func.sum(User.id)).scalar()
print session.query(func.now()).scalar() # func 后可以跟任意函数名，只要该数据库支持
print session.query(func.current_timestamp()).scalar()
print session.query(func.md5(User.name)).filter(User.id == 1).scalar()
query.filter(User.id == 1).update({User.name: 'c'})
user = query.get(1)
print user.name
user.name = 'd'
session.flush() # 写数据库，但并不提交
print query.get(1).name
session.delete(user)
session.flush()
print query.get(1)
session.rollback()
print query.get(1).name
query.filter(User.id == 1).delete()
session.commit()
print query.get(1)