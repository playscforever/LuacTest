#include "CCCircleBy.h"
USING_NS_CC;

CircleBy* CircleBy::create(float time , Vec2 center, float radius)
{
	auto circleBy = new CircleBy();
	if (circleBy && circleBy->init(time, center, radius))
	{
		circleBy->autorelease();
		return circleBy;
	}
	return nullptr;
}
bool CircleBy::init(float time , Vec2 center, float radius)
{
	if(ActionInterval::initWithDuration(time))
	{
		m_circleCenter = center;
		m_radius = radius;
		//每次刷新需要移动的弧度
		m_radian = 2*M_PI/(time / Director::getInstance()->getAnimationInterval());
		m_moveTimes = 0;
		return true;
	}
	return false;
}
void CircleBy::update(float time)
{
	//默认会把target放到运行轨迹的最上面
	float radian = m_radian * m_moveTimes;
	m_moveTimes ++;
	float x = m_radius * sin(radian);
	float y = m_radius * cos(radian);
	_target->setPosition(Vec2(x + m_circleCenter.x, y + m_circleCenter.y));
}


//class CircleRotateBy : public ActionInterval
// CircleRotateBy* CircleRotateBy::create(float time, Vec2 circleCenter, float radius)
// {
// 	auto circleRotateBy = new CircleRotateBy();
// 	if (circleRotateBy && circleRotateBy->init(time, circleCenter, radius))
// 	{
// 		circleRotateBy->autorelease();
// 		return circleRotateBy;
// 	}
// 	return nullptr;
// }
// bool CircleRotateBy::init(float time, Vec2 circlrCenter, float radius)
// {
// 	if(ActionInterval::initWithDuration(time))
// 	{
// 		m_count = 0;
// 		m_radius = radius;
// 		m_circleCenter = circlrCenter;
// 		//每贞移动的弧度和旋转的角度
// 		m_radian = 2 *M_PI/(time/Director::getInstance()->getAnimationInterval());
// 		m_rotate = 360/(time/Director::getInstance()->getAnimationInterval());
// 		return true;
// 	}
// 	return false;
// }
// void CircleRotateBy::update(float time)
// {
// 	m_radius = m_radius + 0.5;
// 	float radian = m_count * m_radian;
// 	float rotate = m_count * m_rotate;
// 	m_count++;
// 	float dx = m_radius * sin(radian);
// 	float dy = m_radius * cos(radian);
// 	_target->setPosition(m_circleCenter.x + dx, m_circleCenter.y + dy);
// 	_target->setRotation(rotate);
// }