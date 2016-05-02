#include "base/ccConfig.h"
#ifndef __pp_api_h__
#define __pp_api_h__

#ifdef __cplusplus
extern "C" {
#endif
#include "tolua++.h"
#ifdef __cplusplus
}
#endif

int register_all_pp_api(lua_State* tolua_S);





#endif // __pp_api_h__
