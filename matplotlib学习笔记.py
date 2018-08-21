matplotlib学习笔记

#堆积柱状图
import matplotlib.pyplot as plt
import numpy as np

N = 5
menMeans = (20, 35, 30, 35, 27)
womenMeans = (25, 32, 34, 20, 25)
# menStd = (2, 3, 4, 1, 2)
# womenStd = (3, 5, 2, 3, 3)
ind = np.arange(N)
width = 0.35
p1 = plt.bar(ind, menMeans, width, color='r')
p2 = plt.bar(ind, womenMeans, width, color='y',bottom=menMeans)
plt.ylabel('Scores')
plt.title('Scores by group and gender')
plt.xticks(ind + width/2., ('G1', 'G2', 'G3', 'G4', 'G5'))
plt.yticks(np.arange(0, 81, 10))
plt.legend((p1[0], p2[0]), ('Men', 'Women'))
plt.show()

#复合柱状图
import numpy as np
import matplotlib.pyplot as plt
n_groups = 5
means_men = (20, 35, 30, 35, 27)
std_men = (2, 3, 4, 1, 2)
means_women = (25, 32, 34, 20, 25)
std_women = (3, 5, 2, 3, 3)
fig, ax = plt.subplots()
index = np.arange(n_groups)
bar_width = 0.35
opacity = 0.4
error_config = {'ecolor': '0.3'}
rects1 = plt.bar(index, means_men, bar_width,alpha=opacity,color='b',yerr=std_men,error_kw=error_config,label='Men',edgecolor='b')
rects2 = plt.bar(index + bar_width, means_women, bar_width,alpha=opacity,color='r',yerr=std_women,error_kw=error_config,
label='Women',edgecolor='r')
plt.xlabel('Group')
plt.ylabel('Scores')
plt.title('Scores by group and gender')
plt.xticks(index + bar_width, ('A', 'B', 'C', 'D', 'E'))
plt.legend()
plt.tight_layout()
plt.show()

#散点图
x=[1,2,3,4]
y=[3,4,1,2]
plt.plot(x,y,marker='o')
plt.xlim(0.,5.)
plt.ylim(0.,5.)
plt.show()

#散点图2
N = 50
x = np.random.rand(N)
y = np.random.rand(N)
colors = np.random.rand(N)
area = np.pi * (15 * np.random.rand(N))**2 # 0 to 15 point radiuses
plt.scatter(x, y, s=area, c=colors, alpha=0.5)
plt.show()

#漂亮的散点图3
import numpy as np
import matplotlib.pyplot as plt
plt.style.use('dark_background')
L = 6
x = np.linspace(0, L)
ncolors = len(plt.rcParams['axes.color_cycle'])
shift = np.linspace(0, L, ncolors, endpoint=False)
for s in shift:
plt.plot(x, np.sin(x + s), 'o-')
plt.xlabel('x-axis')
plt.ylabel('y-axis')
plt.title('title')
plt.show()

#饼图
labels = 'Frogs', 'Hogs', 'Dogs', 'Logs'
sizes = [15, 30, 45, 10]
colors = ['green', 'red', 'blue', 'yellow']
explode = (0, 0.1, 0, 0)
plt.pie(sizes,explode=explode,labels=labels,colors=colors,shadow=True,autopct='%1.1f%%',startangle=90,)
plt.show()

#折线图
x = np.arange(0, 20, 0.1)
y1 = np.sin(x)
y2= np.cos(x)
y3=np.sin(x)
t1=plt.plot(x, y1,marker='o',mec='b',label='t1')
t2=plt.plot(x, y2,color='g',marker='^',mec='g',label='t2')
t3=plt.plot(x-1, y3,color='r',marker='*',mec='r',label='t3')
plt.xlim(-2,20)
plt.ylim(-2,2)
plt.grid()
plt.legend()
plt.title('table',fontsize=14,color='b',fontstyle='normal',fontname='Helvetica')
plt.xlabel('x axes')
plt.ylabel('y axes')
plt.xticks(color='gold')
# plt.yticks()
plt.show()

#柱状图折线图组合

n_groups = 10
means_men = (20, 35, 30, 35, 27,25, 32, 34, 20, 25)
std_men = (2, 3, 4, 1, 2)
means_women = (25, 32, 34, 20, 25,20, 35, 30, 35, 27)
std_women = (3, 5, 2, 3, 3)
fig, ax = plt.subplots()
index = np.arange(n_groups)
bar_width = 0.7
opacity = 0.4
error_config = {'ecolor': '0.3'}
rects1 = plt.bar(index, means_men, bar_width,color='b',error_kw=error_config,label='Men',edgecolor='b')
rects2 = plt.plot(index+bar_width/2, means_women,color='g',marker='o',markersize=10,label='Women',mec='g',lw=2)
plt.xlabel('Group')
plt.ylabel('Scores')
plt.ylim(0,50)
plt.title('Scores by group and gender')
plt.xticks(index+bar_width/2 , ('A', 'B', 'C', 'D', 'E','F','G','H','I','J'))
plt.legend()
plt.grid(color='b',lw=2)
plt.tight_layout()
plt.show()

#带标签的柱状图
import matplotlib.pyplot as plt
import numpy as np
N = 5
menMeans = (20, 35, 30, 35, 27)
menStd = (2, 3, 4, 1, 2)
ind = np.arange(N) # the x locations for the groups
width = 0.35 # the width of the bars
fig, ax = plt.subplots()
rects1 = ax.bar(ind, menMeans, width, color='r', yerr=menStd)
womenMeans = (25, 32, 34, 20, 25)
womenStd = (3, 5, 2, 3, 3)
rects2 = ax.bar(ind + width, womenMeans, width, color='y', yerr=womenStd)
# add some text for labels, title and axes ticks
ax.set_ylabel('Scores')
ax.set_title('Scores by group and gender')
ax.set_xticks(ind + width)
ax.set_xticklabels(('G1', 'G2', 'G3', 'G4', 'G5'))
ax.legend((rects1[0], rects2[0]), ('Men', 'Women'))
def autolabel(rects):
# attach some text labels
    for rect in rects:
        height = rect.get_height()
        ax.text(rect.get_x() + rect.get_width()/2., 1.05*height,'%d' % int(height),ha='center', va='bottom')
autolabel(rects1)
autolabel(rects2)
plt.show()

#新增顶部坐标轴
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import host_subplot
import mpl_toolkits.axisartist as AA
import numpy as np
ax = host_subplot(111, axes_class=AA.Axes)
xx = np.arange(0, 2*np.pi, 0.01)
ax.plot(xx, np.sin(xx))
ax2 = ax.twin() # ax2 is responsible for "top" axis and "right" axis
ax2.set_xticks([0., .5*np.pi, np.pi, 1.5*np.pi, 2*np.pi])
ax2.set_xticklabels(["$0$", r"$\frac{1}{2}\pi$",r"$\pi$", r"$\frac{3}{2}\pi$", r"$2\pi$"])
ax2.axis["right"].major_ticklabels.set_visible(False)
plt.draw()
plt.show()

#学习线条类型:linspace/cycler/set_prop_cycle
#linspace确定上下限，取中间几个值，默认num=50;
#cycler/set_prop_cycle循环赋值
from cycler import cycler
import numpy as np
import matplotlib.pyplot as plt
x = np.linspace(0, 2 * np.pi)

offsets = np.linspace(0, 2*np.pi, 4, endpoint=False)

# Create array with shifted-sine curve along each column
yy = np.transpose([np.sin(x + phi) for phi in offsets])
plt.rc('lines', linewidth=4)
plt.rc('axes', prop_cycle=(cycler('color', ['r', 'g', 'b', 'y']) +cycler('linestyle', ['-', '--', ':', '-.'])))
fig, (ax0, ax1) = plt.subplots(nrows=2)
ax0.plot(yy)
ax0.set_title('Set default color cycle to rgby')
ax1.set_prop_cycle(cycler('color', ['c', 'm', 'y', 'k']) +cycler('lw', [1, 2, 3, 4]))
ax1.plot(yy)
ax1.set_title('Set axes color cycle to cmyk')
# Tweak spacing between subplots to prevent labels from overlapping
plt.subplots_adjust(hspace=0.3)
plt.show()


#画极坐标图
#radii代表r
#theta代表角度
#width代表夹角的宽度
#bottom代表基准点
import numpy as np
import matplotlib.pyplot as plt
N = 20
theta = np.linspace(0.0, 2 * np.pi, N, endpoint=False)
radii = 10 * np.random.rand(N)
radii=range(1,21)
width = np.pi / 4 * np.random.rand(N)
ax = plt.subplot(111, projection='polar')
bars = ax.bar(theta, radii, width=np.pi /8, bottom=0.0)
# Use custom colors and opacity
for r, bar in zip(radii, bars):
    bar.set_facecolor(plt.cm.jet(r / 10.))
# bar.set_alpha(0.5)
plt.show()

#极坐标图2
import numpy as np
import matplotlib.pyplot as plt
N = 150
r = 2 * np.random.rand(N)
theta = 2 * np.pi * np.random.rand(N)
area = 200 * r**2 * np.random.rand(N)
colors = theta
ax = plt.subplot(111, projection='polar')
c = plt.scatter(theta, r, c=colors, s=area, cmap=plt.cm.hsv)
c.set_alpha(0.75)
plt.show()


#正态直方图
import numpy as np
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
# example data
mu = 100 # mean of distribution
sigma = 15 # standard deviation of distribution
x = mu + sigma * np.random.randn(10000)
num_bins = 50
# the histogram of the data
n, bins, patches = plt.hist(x, num_bins, normed=1, facecolor='green', alpha=0.5)
# add a 'best fit' line
y = mlab.normpdf(bins, mu, sigma)
plt.plot(bins, y, 'r--')
plt.xlabel('Smarts')
plt.ylabel('Probability')
plt.title(r'Histogram of IQ: $\mu=100$, $\sigma=15$')
# Tweak spacing to prevent clipping of ylabel
plt.subplots_adjust(left=0.15)
plt.show()

#使用模板的折线图
from matplotlib import pyplot as plt
import numpy as np
x = np.linspace(0, 10)
with plt.style.context('fivethirtyeight'):
plt.plot(x, np.sin(x) + x + np.random.randn(50))
plt.plot(x, np.sin(x) + 0.5 * x + np.random.randn(50))
plt.plot(x, np.sin(x) + 2 * x + np.random.randn(50))
plt.show()

#横向条形图
plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt
people = ('Tom', 'Dick', 'Harry', 'Slim', 'Jim')
y_pos = np.arange(len(people))
performance = 3 + 10 * np.random.rand(len(people))
error = np.random.rand(len(people))
plt.barh(y_pos, performance,  align='center')
plt.yticks(y_pos, people)
plt.xlabel('Performance')
plt.title('How fast do you want to go today?')
plt.show()

#面积图
x=np.linspace(0,1)
y = np.sin(4 * np.pi * x) * np.exp(-5 * x)
plt.fill(x,y,'b')
plt.grid()
plt.show()
#面积图2
x = np.linspace(0, 2 * np.pi, 100)
y1 = np.sin(x)
y2 = np.sin(3 * x)
plt.fill(x, y1, 'b', x, y2, 'r', alpha=0.3)
plt.show()

#面积图3
#stackplot与fill_between殊途同归，而且简单
import numpy as np
import matplotlib.pyplot as plt
def fnx():
	return np.random.randint(5, 50, 10)

y = np.row_stack((fnx(), fnx(), fnx()))
# yy=np.column_stack((fnx(),fnx(),fnx()))
#把一维数组以行的形式合成二维数组
x = np.arange(10)
y1, y2, y3 = fnx(), fnx(), fnx()
fig, ax = plt.subplots()
# ax.stackplot(x, y1,y2, y3)
#两者结果相同
ax.stackplot(x,y)
plt.show()

#面积图4
import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(0, 2 * np.pi, 100)
y1 = np.sin(x)
y3 =np.cos(x)
y4=np.exp(-x)
plt.fill_between(x, y1,y2=0,color='b')
plt.fill_between(x,y4+y1,y2=y1,color='r')
plt.fill_between(x,y4+y1+y3,y2=y4+y1,color='g')
plt.show()

#对数据标记的设定
import matplotlib.pyplot as plt
import numpy as np
def f(t):
    'a damped exponential'
    s1 = np.cos(2 * np.pi * t)
    e1 = np.exp(t)
    return s1 * e1
t1 = np.arange(0.0, 5.0, .1)
l = plt.plot(t1, f(t1), 'ro')
plt.setp(l, 'markersize', 10)
plt.setp(l, 'markerfacecolor', 'b')
plt.show()

#一条线标不同颜色
import numpy as np
import matplotlib.pyplot as plt
t = np.arange(0.0, 2.0, 0.01)
s = np.sin(2*np.pi*t)
upper = 0.77
lower = -0.77
supper = np.ma.masked_where(s < upper, s)
slower = np.ma.masked_where(s > lower, s)
smiddle = np.ma.masked_where(np.logical_or(s < lower, s > upper), s)
plt.plot(t, slower, 'r', t, smiddle, 'b', t, supper, 'g')
plt.show()

#有关日期的散点图
import matplotlib.pyplot as plt
from matplotlib.dates import YEARLY, DateFormatter, rrulewrapper, RRuleLocator, drange
import numpy as np
import datetime
# tick every 5th easter
rule = rrulewrapper(YEARLY, byeaster=1, interval=5)
loc = RRuleLocator(rule)
formatter = DateFormatter('%m/%d/%y')
date1 = datetime.date(1952, 1, 1)
date2 = datetime.date(2004, 4, 12)
delta = datetime.timedelta(days=365)
dates = drange(date1, date2, delta)
s = np.random.rand(len(dates)) # make up some random y values
fig, ax = plt.subplots()
plt.plot_date(dates, s)
ax.xaxis.set_major_locator(loc)
ax.xaxis.set_major_formatter(formatter)
labels = ax.get_xticklabels()
plt.setp(labels, rotation=30, fontsize=10)
plt.show()

#有关日期的散点图2
import datetime
import matplotlib.pyplot as plt
from matplotlib.dates import DayLocator, HourLocator, DateFormatter, drange
from numpy import arange
date1 = datetime.datetime(2000, 3, 2)
date2 = datetime.datetime(2000, 3, 6)
delta = datetime.timedelta(hours=6)
dates = drange(date1, date2, delta)
y = arange(len(dates)*1.0)
fig, ax = plt.subplots()
ax.plot_date(dates, y*y)
ax.set_xlim(dates[0], dates[-1])
ax.xaxis.set_major_locator(DayLocator())
ax.xaxis.set_minor_locator(HourLocator(arange(0, 25, 6)))
ax.xaxis.set_major_formatter(DateFormatter('%Y-%m-%d'))
ax.fmt_xdata = DateFormatter('%Y-%m-%d %H:%M:%S')
fig.autofmt_xdate()
plt.show()

#漂亮的椭圆散点图
import matplotlib.pyplot as plt
import numpy.random as rnd
from matplotlib.patches import Ellipse
NUM = 250
ells = [Ellipse(xy=rnd.rand(2)*10, width=rnd.rand(), height=rnd.rand(), angle=rnd.rand()*360) for i in range(NUM)]
fig = plt.figure(0)
ax = fig.add_subplot(111, aspect='equal')
for e in ells:
    ax.add_artist(e)
    e.set_clip_box(ax.bbox)
    e.set_alpha(rnd.rand())
    e.set_facecolor(rnd.rand(3))
ax.set_xlim(0, 10)
ax.set_ylim(0, 10)
plt.show()

#椭圆图
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Ellipse
delta = 45.0 # degrees
angles = np.arange(0, 360 + delta, delta)
ells = [Ellipse((1, 1), 4, 2, a) for a in angles]
a = plt.subplot(111, aspect='equal')
for e in ells:
e.set_clip_box(a.bbox)
e.set_alpha(0.1)
a.add_artist(e)
plt.xlim(-2, 4)
plt.ylim(-1, 3)
plt.show()

#图例位置、数据标记
import matplotlib.pyplot as plt
import numpy as np
t1 = np.arange(0.0, 2.0, 0.1)
t2 = np.arange(0.0, 2.0, 0.01)
# note that plot returns a list of lines. The "l1, = plot" usage
# extracts the first element of the list into l1 using tuple
# unpacking. So l1 is a Line2D instance, not a sequence of lines
l1, = plt.plot(t2, np.exp(-t2))
l2, l3 = plt.plot(t2, np.sin(2 * np.pi * t2), '--go', t1, np.log(1 + t1), '.')
l4, = plt.plot(t2, np.exp(-t2) * np.sin(2 * np.pi * t2), 'rs-.')
plt.legend((l2, l4), ('oscillatory', 'damped'), loc='upper right', shadow=True)
plt.xlabel('time')
plt.ylabel('volts')
plt.title('Damped oscillation')
plt.show()

#特殊的数据标记
import matplotlib.pyplot as plt
import matplotlib.path as mpath
import numpy as np
star = mpath.Path.unit_regular_star(6)
circle = mpath.Path.unit_circle()
# concatenate the circle with an internal cutout of the star
verts = np.concatenate([circle.vertices, star.vertices[::-1, ...]])
codes = np.concatenate([circle.codes, star.codes])
cut_star = mpath.Path(verts, codes)
plt.plot(np.arange(10)**2, '--r', marker=cut_star, markersize=15)
plt.show()

#在不同区域使用不同的标记
import matplotlib.pyplot as plt
import numpy as np
N = 100
r0 = 0.6
x = 0.9*np.random.rand(N)
y = 0.9*np.random.rand(N)
area = np.pi*(10 * np.random.rand(N))**2 # 0 to 10 point radiuses
c = np.sqrt(area)
r = np.sqrt(x*x + y*y)
area1 = np.ma.masked_where(r < r0, area)
area2 = np.ma.masked_where(r >= r0, area)
plt.scatter(x, y, s=area1, marker='^', c=c, hold='on')
plt.scatter(x, y, s=area2, marker='o', c=c)
# Show the boundary between the regions:
theta = np.arange(0, np.pi/2, 0.01)
plt.plot(r0*np.cos(theta), r0*np.sin(theta))
plt.show()




#套图
import numpy as np
import matplotlib.pyplot as plt
x1 = np.linspace(0.0, 5.0)
x2 = np.linspace(0.0, 2.0)
y1 = np.cos(2 * np.pi * x1) * np.exp(-x1)
y2 = np.cos(2 * np.pi * x2)
plt.subplot(2, 1, 1)
plt.plot(x1, y1, 'ko-')
plt.title('A tale of 2 subplots')
plt.ylabel('Damped oscillation')
plt.subplot(2, 1, 2)
plt.plot(x2, y2, 'r.-')
plt.xlabel('time (s)')
plt.ylabel('Undamped')
plt.show()


#三维散点图
import numpy as np
import matplotlib.pyplot as plt

N = 50
x = np.random.rand(N)
y = np.random.rand(N)
colors = np.random.rand(N)
area = np.pi * (15 * np.random.rand(N))**2 # 0 to 15 point radiuses
plt.scatter(x, y, s=area, c=colors, alpha=0.5)
plt.show()
plt.scatter(x, y, marker='o', c='b', s=5, zorder=10)
#散点图标准格式
#（x坐标，y坐标，marker标记类型，s面积大小)
#有关日期 
import matplotlib.pyplot as plt
from matplotlib.finance import quotes_historical_yahoo_ochl
from matplotlib.dates import YearLocator, MonthLocator, DateFormatter
import datetime
date1 = datetime.date(1995, 1, 1)
date2 = datetime.date(2004, 4, 12)
years = YearLocator() # every year
months = MonthLocator() # every month
yearsFmt = DateFormatter('%Y')
quotes = quotes_historical_yahoo_ochl('INTC', date1, date2)
if len(quotes) == 0:
	raise SystemExit
dates = [q[0] for q in quotes]
opens = [q[1] for q in quotes]
fig, ax = plt.subplots()
ax.plot_date(dates, opens, '-')
# format the ticks
ax.xaxis.set_major_locator(years)
ax.xaxis.set_major_formatter(yearsFmt)
ax.xaxis.set_minor_locator(months)
ax.autoscale_view()
# format the coords message box
def price(x):
	return '$%1.2f' % x
ax.fmt_xdata = DateFormatter('%Y-%m-%d')
ax.fmt_ydata = price
ax.grid(True)
fig.autofmt_xdate()
plt.show()


#################################
#从数据库取数并做成图表
#################################


# coding=gbk
import mysql.connector
import matplotlib.pyplot as plt
import numpy as np

conn = mysql.connector.connect(user='root', password='', database='test')
cursor = conn.cursor()
cursor.execute('select * from test.agents where create_date>=20151218')
values = cursor.fetchall()
create_date=[]
give_price_num1=[]
suc_order_num1=[]
give_price_num2=[]
suc_order_num2=[]
for i in values:
	if i[1]=='inter':
		create_date.append(i[0])
		give_price_num1.append(i[4])
		suc_order_num1.append(i[5])
	else:
		give_price_num2.append(i[4])
		suc_order_num2.append(i[5])
print(create_date)
print(agents_num)
cursor.close()
conn.close()

柱状图
N = len(give_price_num1)
ind = np.arange(N)
width = 0.7
p1 = plt.bar(ind, give_price_num1, width, color='r',edgecolor='r',label='give_price_num')
p2 = plt.bar(ind + width, suc_order_num1, width,color='g',edgecolor='g',label='suc_order_num')
p3= plt.plot(ind + width,agents_num,marker='o',color='b')
plt.ylabel('Scores')
plt.title('Scores by group and gender')
plt.xticks(ind + width/2., create_date)
plt.show()

#折线图
# N = len(agents_num)
# ind = np.arange(N)
# width = 0.7
# plt.plot(ind,agents_num,marker='o')
# plt.xticks(ind + width/2., create_date)
# plt.show()

######################################
#从数据库取数并做成图表+使用日期格式
######################################

# coding=gbk
import mysql.connector
import matplotlib.pyplot as plt
import numpy as np
import datetime
from numpy import arange
from matplotlib.dates import YEARLY, DateFormatter, rrulewrapper, RRuleLocator, drange

#连接数据库
conn = mysql.connector.connect(user='', password='', database='')
cursor = conn.cursor()
cursor.execute('select * from test.agents where create_date>=20151215')
values = cursor.fetchall()
create_date=[]
give_price_num1=[]
suc_order_num1=[]
div1=[]
give_price_num2=[]
suc_order_num2=[]
div2=[]
for i in values:
	if i[1]=='inter':
		create_date.append(i[0])
		give_price_num1.append(i[4])
		suc_order_num1.append(i[5])
		div1.append(i[5]/i[4])
	else:
		give_price_num2.append(i[4])
		suc_order_num2.append(i[5])
		div2.append(i[5]/i[4])
cursor.close()
conn.close()



#柱状图
#日期是自动展示的,每次要在末尾多加一天


formatter = DateFormatter('%Y-%m-%d')
date1 = datetime.date(2015, 12, 15)
date2 = datetime.date(2016, 1, 2)
delta = datetime.timedelta(days=1)
dates = drange(date1, date2, delta)

print(create_date)
print(dates)
fig, ax = plt.subplots()
plt.plot_date(dates, div1)

ax.xaxis.set_major_formatter(formatter)
labels = ax.get_xticklabels()
plt.setp(labels, rotation=30, fontsize=10)
plt.show()



################
#marker
/ - diagonal hatching
\ - back diagonal
| - vertical
- - horizontal
+ - crossed
x - crossed diagonal
o - small circle
O - large circle
. - dots
* - stars
s - square
#color
b: blue
g: green
r: red
c: cyan
m: magenta
y: yellow
k: black
w: white
################
#彩色折线图
import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
# Red Yellow Green divergent colormap
red_yellow_green = ['#d73027', '#f46d43', '#fdae61',
'#fee08b', '#ffffbf', '#d9ef8b',
'#a6d96a', '#66bd63', '#1a9850']
sample_size = 1000
fig, ax = plt.subplots(1)
for i in range(9):
	y = np.random.normal(size=sample_size).cumsum()
	x = np.arange(sample_size)
	ax.scatter(x, y, label=str(i), linewidth=0.1,edgecolors='grey',facecolor=red_yellow_green[i])
ax.legend()
plt.show()

#柱状图和折线图组合,使用次坐标,解决中文显示问题,解决数字百分比格式
# -*- coding:utf-8 -*-
import  numpy as np
import  matplotlib.pyplot as plt
from matplotlib.ticker import  FuncFormatter
#定义函数修改数据标签格式
def percent(x, pos):
    return '%2.0f%%'  % (x*100)
formatter = FuncFormatter(percent)
n_groups = 10
index = np.arange(n_groups)
bar_width = 0.7
means_men = (20, 35, 30, 35, 27,25, 32, 34, 20, 25)
means_women = (0.2, 0.3, 0.4, 0.1,0.2,0.3, 0.5, 0.2, 0.3, 0.3)
fig,ax = plt.subplots()
#新增ay2和ax共享x轴
ay2=ax.twinx()
#以下指定字体，解决中文显示问题
plt.rcParams['font.sans-serif'] = ['SimHei'] #指定默认字体
plt.rcParams['axes.unicode_minus'] = False #解决保存图像是负号'-'显示为方块的问题
ax.set_ylim(0,50)
ay2.set_ylim(0,1)
ay2.yaxis.set_major_formatter(formatter)
p1=ax.bar(index, means_men, bar_width,color='b',label='Men',edgecolor='b')
p2=ay2.plot(index+bar_width/2, means_women,color='g',marker='o',markersize=10,label='Women',mec='g',lw=2)
ax.set_xlabel('分组')
ax.set_ylabel('分数')
ax.set_title(u'妹的，终于能显示中文了！')
ay2.set_ylabel('百分比')
ax.set_xticks(index+bar_width/2)
ax.set_xticklabels( ('A', 'B', 'C', 'D', 'E','F','G','H','I','J'))
plt.legend((p1[0], p2[0]), (u'男士', u'女士'))
plt.show()


#对坐标轴标签格式的定义
from matplotlib.ticker import FuncFormatter
import matplotlib.pyplot as plt
import numpy as np
x = np.arange(4)
money = [1.5e5, 2.5e6, 5.5e6, 2.0e7]
def millions(x, pos):
    return '$%1.1fM' % (x*1e-6)
    # return '$%1.1f%%' % (x*1e-6)
#%%是%的转义符
formatter = FuncFormatter(millions)
fig, ax = plt.subplots()
ax.yaxis.set_major_formatter(formatter)
plt.bar(x, money)
plt.xticks(x + 0.5, ('Bill', 'Fred', 'Mary', 'Sue'))
plt.show()




#从CSV取数并绘图
#--coding:utf-8--
import csv
import matplotlib.pyplot as plt
import numpy as np
import datetime
from numpy import arange
from matplotlib.dates import YEARLY, DateFormatter, rrulewrapper, RRuleLocator, drange
from matplotlib.ticker import  FuncFormatter
def fread(path):
    f=open(path,'r',encoding='utf-8')
    reader=csv.reader(f)
    L=[]
    for line in reader:
        L.append(line)
    f.close()
    return L

R_data=fread('C:\Python34/pangolin.csv')

# ['2015/11/3', '国际', '总计', '非导单', '261', '21', '3', '18', '50', '8', '12', '12', '5853']
# print(R_data[1000:1020])
create_date=[]
order_num=[]
pay_num=[]
grab_per=[]
for values in R_data:
    if values[1]=='国际' and values[3]=='国际精选报价' and values[2]=='单程':
        create_date.append(values[0])
        order_num.append(values[4])
        pay_num.append(int(values[5]))
        grab_per.append(int(values[9])/int(values[5]))

plt.rcParams['font.sans-serif'] = ['SimHei'] #指定默认字体
plt.rcParams['axes.unicode_minus'] = False #解决保存图像是负号'-'显示为方块的问题

def percent(x, pos):
    return '%2.0f%%'  % (x*100)
formatter1 = FuncFormatter(percent)

formatter2 = DateFormatter('%Y-%m-%d')
date1 = datetime.date(2015, 11, 3)
date2 = datetime.date(2016, 1, 6)
delta = datetime.timedelta(days=1)
dates = drange(date1, date2, delta)

x=np.arange(len(create_date))
bar_width=0.8
fig, ax = plt.subplots()
ay2=ax.twinx()
ay2.yaxis.set_major_formatter(formatter1)
p1=ax.bar(x,pay_num,bar_width,color='b',edgecolor='b',label=u'支付订单')
# p1=ax.stackplot(x,pay_num,color='b')
p2=ay2.plot(x, grab_per,marker='o',color='r',mec='r',label=u'抢单成功率')
# ax.xaxis.set_major_formatter(formatter2)
# labels = ax.get_xticklabels()
# plt.setp(labels, rotation=30, fontsize=10)
ax.set_xlim(0,63)
ax.set_xlabel('日期')
ax.set_ylabel('支付订单')
ax.set_title(u'国际精选抢单趋势图')
ay2.set_ylabel('抢单成功率')
ax.set_xticklabels(create_date[::10])
plt.legend((p1[0], p2[0]), (u'支付订单', u'抢单成功率'))
plt.show()

#动画
# -*- coding: utf-8 -*- 
import numpy as np 
import matplotlib.pyplot as plt 
import matplotlib.animation as animation 

def data_gen(): 
  t = data_gen.t 
  cnt = 0
  while cnt < 1000: 
    cnt+=1
    t += 0.05
    yield t, np.sin(2*np.pi*t) * np.exp(-t/10.) 
data_gen.t = 0

fig, ax = plt.subplots() 
line, = ax.plot([], [], lw=2) 
ax.set_ylim(-1.1, 1.1) 
ax.set_xlim(0, 5) 
ax.grid() 
xdata, ydata = [], [] 
 
def run(data): 
  # update the data 
  t,y = data 
  xdata.append(t) 
  ydata.append(y) 
  xmin, xmax = ax.get_xlim() 
  if t >= xmax: 
    ax.set_xlim(xmin, 2*xmax) 
    ax.figure.canvas.draw() 
  line.set_data(xdata, ydata) 
  return line, 

ani = animation.FuncAnimation(fig, run, data_gen, blit=True, interval=1, repeat=False) 
plt.show() 