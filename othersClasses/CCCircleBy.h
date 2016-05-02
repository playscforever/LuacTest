
#include "cocos2d.h"
USING_NS_CC;

class CircleBy : public ActionInterval
{
public:
	//time 为转一圈需要的时间
	static CircleBy* create(float time , Vec2 center, float radius);
	bool init(float time , Vec2 center, float radius);
	virtual void update(float time);
protected:
	Vec2 m_circleCenter;
	float m_radius;
	float m_radian;
	int m_moveTimes;
};

//圆周运动，并保持头的方向和前进的方向一致
//可以直接修改CircleBy来实现， 为了练习创建自定义类才新建的
// class CircleRotateBy : public ActionInterval
// {
// public:
// 	static CircleRotateBy* create(float time, Vec2 circleCenter, float radius);
// 	bool init(float time, Vec2 circlrCenter, float radius);
// 	virtual void update(float time);
// protected:
// 	int m_count;
// 	float m_radius;
// 	//每贞移动的弧度和旋转的角度
// 	float m_radian;
// 	float m_rotate;
// 	Vec2 m_circleCenter;
// };
