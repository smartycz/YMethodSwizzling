## YMethodSwizzling
## 自动化埋点！！！
# 自动化埋点原理和实现方案（ios）

1.Runtime 替换点击事件方法
	实现一个View 的 Category，在View的load的方法里利用运行时机制替换View的点击方法或代理delegate。

2.设计产品定义ActionLog ID 交互界面
	每个版本独立一个模式用于产品定义 ActionLog ID和StaticParam。当产品点击一个View，弹出界面，产品输入该事件的ID和静态参数，保存到本地数据库或配置表。该View的ActionName和所在Class的Name做唯一标识。

3.发送ActionLog
	当View被点击，会先执行替换的方法。在替换的方法里面通过该View的ActionName和所在的ClassName读取数据库或配置，取出ActionLog ID 和StaticParam发送log（ActionLog Manager），然后再返回执行业务逻辑事件方法。（也可以先执行原方法，再执行发送log逻辑）

4.Dynamic Parameter处理
	现阶段实现方案：在viewcontroller的基类定义一个参数，在点击方法设置参数的值，在替换方法发送log的时候，取出该值发送。（未达到全自动）
	
5.可能遇到的问题
	a.可能某些用户行为无法在Category实现替换方法。
	b.一个用户行为可能在不同的状态对应不同的ActionLog ID。
	c.多个点击事件对应一个执行方法且ActionLog ID不同。（很少）
