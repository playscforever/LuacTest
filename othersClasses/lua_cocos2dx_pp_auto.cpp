#include "lua_cocos2dx_pp_auto.hpp"
#include "CCCircleBy.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



int lua_pp_api_CircleBy_init(lua_State* tolua_S)
{
    int argc = 0;
    CircleBy* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"CircleBy",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (CircleBy*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pp_api_CircleBy_init'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 3) 
    {
        double arg0;
        cocos2d::Vec2 arg1;
        double arg2;

        ok &= luaval_to_number(tolua_S, 2,&arg0, "CircleBy:init");

        ok &= luaval_to_vec2(tolua_S, 3, &arg1, "CircleBy:init");

        ok &= luaval_to_number(tolua_S, 4,&arg2, "CircleBy:init");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_pp_api_CircleBy_init'", nullptr);
            return 0;
        }
        bool ret = cobj->init(arg0, arg1, arg2);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "CircleBy:init",argc, 3);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pp_api_CircleBy_init'.",&tolua_err);
#endif

    return 0;
}
int lua_pp_api_CircleBy_update(lua_State* tolua_S)
{
    int argc = 0;
    CircleBy* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"CircleBy",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (CircleBy*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_pp_api_CircleBy_update'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0, "CircleBy:update");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_pp_api_CircleBy_update'", nullptr);
            return 0;
        }
        cobj->update(arg0);
        return 0;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "CircleBy:update",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pp_api_CircleBy_update'.",&tolua_err);
#endif

    return 0;
}
int lua_pp_api_CircleBy_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"CircleBy",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        double arg0;
        cocos2d::Vec2 arg1;
        double arg2;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "CircleBy:create");
        ok &= luaval_to_vec2(tolua_S, 3, &arg1, "CircleBy:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "CircleBy:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_pp_api_CircleBy_create'", nullptr);
            return 0;
        }
        CircleBy* ret = CircleBy::create(arg0, arg1, arg2);
        object_to_luaval<CircleBy>(tolua_S, "CircleBy",(CircleBy*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "CircleBy:create",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_pp_api_CircleBy_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_pp_api_CircleBy_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (CircleBy)");
    return 0;
}

int lua_register_pp_api_CircleBy(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"CircleBy");
    tolua_cclass(tolua_S,"CircleBy","CircleBy","cc.ActionInterval",nullptr);

    tolua_beginmodule(tolua_S,"CircleBy");
        tolua_function(tolua_S,"init",lua_pp_api_CircleBy_init);
        tolua_function(tolua_S,"update",lua_pp_api_CircleBy_update);
        tolua_function(tolua_S,"create", lua_pp_api_CircleBy_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(CircleBy).name();
    g_luaType[typeName] = "CircleBy";
    g_typeCast["CircleBy"] = "CircleBy";
    return 1;
}
TOLUA_API int register_all_pp_api(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"pp",0);
	tolua_beginmodule(tolua_S,"pp");

	lua_register_pp_api_CircleBy(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

