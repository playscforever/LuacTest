
#include "cocos2d.h"
USING_NS_CC;

class CircleBy : public ActionInterval
{
public:
	//time ΪתһȦ��Ҫ��ʱ��
	static CircleBy* create(float time , Vec2 center, float radius);
	bool init(float time , Vec2 center, float radius);
	virtual void update(float time);
protected:
	Vec2 m_circleCenter;
	float m_radius;
	float m_radian;
	int m_moveTimes;
};

//Բ���˶���������ͷ�ķ����ǰ���ķ���һ��
//����ֱ���޸�CircleBy��ʵ�֣� Ϊ����ϰ�����Զ�������½���
// class CircleRotateBy : public ActionInterval
// {
// public:
// 	static CircleRotateBy* create(float time, Vec2 circleCenter, float radius);
// 	bool init(float time, Vec2 circlrCenter, float radius);
// 	virtual void update(float time);
// protected:
// 	int m_count;
// 	float m_radius;
// 	//ÿ���ƶ��Ļ��Ⱥ���ת�ĽǶ�
// 	float m_radian;
// 	float m_rotate;
// 	Vec2 m_circleCenter;
// };
